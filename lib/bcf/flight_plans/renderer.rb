module BCF
  module FlightPlans
    class Notes
      def chunk_notes
        # First we group adjacent spoken items together
        groups = []

        self.items.each do |item|
          if item.is_a?(Spoken)
            last_group = groups.last

            if last_group.is_a? SpokenGroup
              last_group.lines << item
            else
              groups << SpokenGroup.new(lines: [item])
            end
          else
            groups << item
          end
        end

        groups
      end
    end

    SpokenGroup = Struct.new(:lines)

    class FormatRenderContext
      attr_reader :root

      def initialize(root, extension)
        spec = Gem::Specification.find_by_name("bcf-flightplans")
        gem_root = spec.gem_dir
        @root = Pathname.new(gem_root).join(root)
        puts @root

        @extension = extension
        @redcarpet = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: false)
      end

      def format_speakers(speakers)
        if speakers.is_a? Array
          speakers.map { |s| format_speakers(s) }.join(" and ")
        else
          speakers.to_s.capitalize
        end
      end

      def render_content(content)
        return "" if content.nil?
        return content if content.is_a? String

        Tilt.new(@root.join("render_content.#{@extension}.erb"))
            .render(self, content: content)
      end

      def render_note(note)
        Tilt.new(@root.join("render_note.#{@extension}.erb"))
            .render(self, note: note)
      end

      def render_markdown(md)
        @redcarpet.render(md)
      end
    end

    class TypstRenderContext < FormatRenderContext
      def initialize
        super('formats/typst', 'typ')
      end

      def render_flight_plan(flight_plan)
        Tilt.new(self.root.join('entry_point.typ.erb'))
            .render(self, flight_plan: flight_plan)
      end

      # TODO: It might be good to isolate these into markdown files which we then read back to avoid escaping issues.
      #  Implement this when we move to more ERB
      def render_markdown(md)
        "cmarker.render(\"#{md}\")"
      end
    end

    class HtmlRenderContext < FormatRenderContext
      def initialize
        super("formats/html", "html")
      end

      def self.render_html_flight_plan(flight_plan)
        Tilt.new('formats/html/table.html.erb')
            .render(new, flight_plan: flight_plan)
      end
    end

    class FlightPlan
      def render_pdf(output_path, debug_typst_path = nil)
        puts "A"
        typst_renderer = TypstRenderContext.new
        puts "B"

        Dir.mktmpdir do |dir|
          puts "C"
          # Copy all files from ./typst to the temp directory
          Dir.glob(File.join(typst_renderer.root, '*')).each do |file|
            FileUtils.cp(file, dir)
          end
          puts "D"

          typst_path = File.join(dir, 'output.typ')
          typst_content = typst_renderer.render_flight_plan(self)
          puts "E"

          File.write(typst_path, typst_content)
          puts "F"
          puts "Rendering to #{output_path}"
          system("typst c #{typst_path} #{output_path}")
        end
      end

      def write_json(output_path)
        File.open(output_path, 'w') do |f|
          f.write(self.to_json)
        end
      end
    end
  end
end
