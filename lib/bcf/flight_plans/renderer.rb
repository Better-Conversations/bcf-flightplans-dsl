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

    class FormatRenderContext
      attr_reader :root, :tempfiles

      def initialize(root, extension, build_context)
        spec = Gem::Specification.find_by_name("bcf-flightplans")
        gem_root = spec.gem_dir
        @root = Pathname.new(gem_root).join(root)
        @build_context = build_context
        @tempfiles = []

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
        raise "Not implemented"
      end
    end

    class TypstRenderer
      def initialize(build_context, debug_print_typ)
        FileUtils.mkdir_p(build_context) unless Dir.exist?(build_context)

        @build_context = build_context
        @render_context = TypstRenderContext.new(build_context)
        @debug_print_typ = debug_print_typ

        unless Open3.capture3("which typst")[2].success?
          raise TypstMissingError
        end
      end

      def output_typ
        File.join(@build_context, "output.typ")
      end

      def compile_typst(pdf_output_path)
        # As we execute this in a different directory we need to make the path absolute
        pdf_output_path_absolute = File.expand_path(pdf_output_path)

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

      def render(flight_plan, pdf_output_path, for_user: nil, page_size: 'a4')
        output_typ = File.join(@build_context, "output.typ")

        File.write(output_typ, @render_context.render_flight_plan(flight_plan, for_user: for_user, page_size: page_size))

        if @debug_print_typ
          puts "[DEBUG] Typst input:"
          puts File.read(output_typ)
        end

        compile_typst(pdf_output_path)
      end
    end

    class TypstRenderContext < FormatRenderContext
      def initialize(build_context)
        super("formats/typst", "typ", build_context)

        # Copy all files from ./typst to the temp directory
        Dir.glob(File.join(root, "*")).each do |file|
          FileUtils.cp(file, build_context)
        end
      end

      # @return [String]
      def render_flight_plan(flight_plan, for_user: nil, page_size: 'a4')
        Tilt.new(root.join("entry_point.typ.erb"))
            .render(self, flight_plan: flight_plan, for_user: for_user, page_size: page_size)
      end

      # TODO: It might be good to isolate these into markdown files which we then read back to avoid escaping issues.
      #  Implement this when we move to more ERB
      def render_markdown(md)
        tempfile = Tempfile.create(['md_fragment', '.md'], @build_context)
        File.write(tempfile, md)
        self.tempfiles << tempfile

        "cmarker.render(read(\"#{Pathname.new(tempfile.path).relative_path_from(Pathname.new(@build_context)).to_s}\"))"
      end
    end

    class HtmlRenderContext < FormatRenderContext
      def initialize(temp_dir)
        super("formats/html", "html", temp_dir)
      end

      def render_markdown(md)
        @redcarpet.render(md)
      end

      def self.render_html_flight_plan(flight_plan, temp_dir)
        Tilt.new("formats/html/table.html.erb")
          .render(new(temp_dir), flight_plan: flight_plan)
      end
    end

    class FlightPlan
      def render_pdf(output_path, build_context: Dir.mktmpdir, debug_print_typ: false, for_user: nil, page_size: 'a4')
        typst_renderer = TypstRenderer.new(build_context, debug_print_typ)
        typst_renderer.render(self, output_path, for_user: for_user)
      end

      def write_json(output_path)
        File.write(output_path, to_json)
      end
    end
  end
end
