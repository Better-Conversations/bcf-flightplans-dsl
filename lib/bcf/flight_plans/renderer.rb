module BCF
  module FlightPlans
    class Notes
      def chunk_notes
        # First we group adjacent spoken items together
        groups = []

        items.each do |item|
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

    class PDFRenderer
      def initialize(flight_plan, output_path, build_context: Dir.mktmpdir, for_user:, page_size: "a4", style: "normal")
        @flight_plan = flight_plan
        @output_path = output_path
        @build_context = build_context
        @page_size = page_size
        @style = style
        @for_user = for_user

        # Copy resources from within the gem root to the build context
        in_gem_resource_root = Pathname.new(BCF::FlightPlans::GEM_ROOT).join(root)
        FileUtils.cp_r(in_gem_resource_root, @build_context)

        validate_typst!
      end

      # Helper method to get the path of the assembled Typst document
      def output_typ
        File.join(@build_context, "output.typ")
      end

      def render
        assemble_typst
        compile_typst
      end

      private

      def self.validate_typst!
        unless Open3.capture3("which typst")[2].success?
          raise TypstMissingError
        end
      end

      def assemble_typst
        template_context = TypstTemplateContext.new(
          build_context: @build_context,
          flight_plan: @flight_plan,
          vars: {
            for_user: @for_user,
            page_size: @page_size,
            style: @style
          }
        )

        File.write(output_typ, template_context.assemble)
      end

      def compile_typst
        # As we execute this in a different directory we need to make the path absolute
        pdf_output_path_absolute = File.expand_path(@output_path)

        stdout, stderr, status = Open3.capture3(
          "typst",
          "c",
          "output.typ",
          pdf_output_path_absolute,
          chdir: @build_context
        )

        unless status.success?
          raise TypstCompileError.new(
            stdout,
            stderr,
            status.exitstatus,
            File.read(output_typ)
          )
        end
      end
    end

    module RenderHelpers
      def format_speakers(speakers)
        if speakers.is_a? Array
          speakers.map { |s| format_speakers(s) }.join(" and ")
        else
          speakers.to_s.capitalize
        end
      end
    end

    class TypstTemplateContext
      attr_accessor :flight_plan

      def initialize(build_context:, flight_plan:, vars: {})
        @build_context = build_context
        @tempfiles = []
        @flight_plan = flight_plan
        @vars = vars
      end

      def assemble
        template('entry_point').render(self)
      end

      # From here in are methods which are called within the

      def find_breakout_room(breakout_room_id)
        @flight_plan.breakout_rooms.find { |br| br.id == breakout_room_id }
      end

      def render_content(content)
        return "" if content.nil?
        return content if content.is_a? String

        template("render_content").render(self, content: content)
      end

      def render_note(note)
        template("render_note").render(self, note: note)
      end

      def render_markdown(md)
        tempfile = Tempfile.create(["md_fragment", ".md"], @build_context)
        File.write(tempfile, md)
        @tempfiles << tempfile

        %Q{cmarker.render(read("#{Pathname.new(tempfile.path).relative_path_from(Pathname.new(@build_context))}"))}
      end

      private def method_missing(symbol, *args)
        @vars[symbol] || super
      end

      private

      def template(name)
        Tilt.new(@build_context.join("#{name}.typ.erb"))
      end
    end

    class FlightPlan
      def render_pdf(output_path, **kwargs)
        PDFRenderer.new(self, output_path, **kwargs)
                   .render
      end

      def write_json(output_path)
        File.write(output_path, to_json)
      end
    end
  end
end
