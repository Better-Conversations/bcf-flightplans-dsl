require 'tmpdir'
require 'tilt'
require 'tilt/erb'

def format_speakers(speakers)
  if speakers.is_a? Array
    speakers.map { |s| format_speakers(s) }.join(" and ")
  else
    speakers.to_s.capitalize
  end
end

module BCF
  # Typst Intermediate Representation
  module TIR
    TableRow = Struct.new(
      :time,
      :length,
      :section_info,
      :facilitator_content,
      :producer_content
    ) do
      def to_typst
        # Trailing comma is intentional and allowed in Typst even without additional arguments to follow
        "[#{self.time}], [#{self.length}], [#{self.section_info}], [#{self.facilitator_content}], [#{self.producer_content}],\n"
      end
    end
  end

  class Block
    def flipchart
      self.resources.find { |r| r.is_a? BCF::Resource::Flipchart }
    end

    def to_typst(current_time)
      section_info = "#{self.name}#linebreak()#bcf-nom[#{format_speakers(self.speaker)}]#linebreak()#{self.flipchart&.inplace_section_comment}#linebreak()#{self.section_comment}"
      TIR::TableRow.new(
        time: current_time.to_s.rjust(2, "0"),
        length: self.length,
        section_info: section_info,
        facilitator_content: self.facilitator_notes&.to_typst,
        producer_content: self.producer_notes&.to_typst
      ).to_typst
    end
  end

  class Notes
    def to_typst
      # First we group adjacent spoken items together
      groups = []
      self.items.each do |item|
        if item.is_a?(Spoken)
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
      template = Tilt.new('typst_erb/entry_point.typ.erb')
      template.render(self)
    end

    def render_pdf(output_path, debug_typst_path = nil)
      Dir.mktmpdir do |dir|
        # Copy all files from ./typst to the temp directory
        Dir.glob(File.join(File.dirname(__FILE__), "..", 'typst_erb', '*')).each do |file|
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
