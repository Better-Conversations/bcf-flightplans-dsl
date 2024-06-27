require 'tmpdir'

module BCF
  TableRow = Struct.new(
    :time,
    :length,
    :section_info,
    :facilitator_content,
    :producer_content
  ) do
    def to_typst
      [
        "[#{self.time.to_s.rjust(2, "0")}]",
        "[#{self.length}]",
        "[#{self.section_info}]",
        "[#{self.facilitator_content}]",
        "[#{self.producer_content}]",
      ].join(",") + ",\n"
    end
  end

  class Block
    def to_typst(current_time)
      TableRow.new(
        time: current_time,
        length: self.length,
        section_info: "#{self.name}",
        facilitator_content: self.facilitator_notes.to_typst,
        producer_content: self.producer_notes.to_typst
      ).to_typst
    end
  end

  class Notes
    def to_typst
      # First we group adjacent spoken items together
      groups = []
      self.items.each do |item|
        if item.is_a?(Spoken) && !groups.empty?
          last_group = groups.last

          if last_group.is_a? Array
            last_group << item
          else
            groups << [item]
          end
        else
          groups << item
        end
      end

      # Then we convert the groups to typst
      groups.map do |group|
        if group.is_a? Array
          "#spoken(
          #{group.map(&:to_typst_expr).join(",\n")}
        )"
        else
          group.to_typst
        end
      end.join("\n\n")
    end
  end

  class Instruction
    def to_typst
      "#instruction[#{self.content}]"
    end
  end

  class Spoken
    # This is named differently as it provides a code expression not a content string
    def to_typst_expr
      if self.fixed
        "bcf-cue[#{self.content}]"
      else
        "[#{self.content}]"
      end
    end
  end

  class Chat
    def to_typst
      "#chat[#{self.content}]"
    end
  end

  class FlightPlan
    def to_typst
      <<TYPST
#import "template.typ": flight-plan, flight-plan-table, instruction, chat, spoken
#show: doc => flight-plan(
  module_number: #{self.module_number},
  module_name: "#{self.module_title}",
  duration: #{self.total_length},
  when: datetime(
    year: 2024,
    month: 6,
    day: 19,
    hour: 9,
    minute: 0,
    second: 0,
  ),
  organisation: "Better Conversations Foundation",
  doc
)

== Time Plan

#flight-plan-table(
  #{self.blocks_typst}
)
TYPST
    end

    def blocks_typst
      typst = []
      current_speaker = nil
      current_time = self.initial_time || -30

      self.blocks.each do |block|
        next_speaker = block.speaker

        if next_speaker != current_speaker && current_speaker != nil
          # TODO: Make this cleaner
          typst << "#speaker-swap[#{current_speaker}],"
          current_speaker = next_speaker
        end

        typst << block.to_typst(current_time)
        current_time += block.length
      end

      typst.join("\n")
    end

    def render_pdf(output_path, debug_typst_path = nil)
      Dir.mktmpdir do |dir|
        # Copy all files from ./typst to the temp directory
        Dir.glob(File.join(File.dirname(__FILE__), "..", 'typst', '*')).each do |file|
          FileUtils.cp(file, dir)
        end

        typst_path = File.join(dir, 'output.typ')
        typst_content = self.to_typst
        File.write(typst_path, typst_content)

        system("typstyle -i #{typst_path}")
        FileUtils.cp(typst_path, debug_typst_path) if debug_typst_path

        system("typst c #{typst_path} #{output_path}")
      end
    end
  end
end
