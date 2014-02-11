require 'dhelp/exporter/base'
require 'erb'
require 'fileutils'
require 'gettext'

module Dhelp::Exporter
  class Html < Base
    DEFAULT_EXPORT_DIR = '/usr/share/doc/HTML'
    SECTION_TEMPLATE   = "#{PREFIX}/share/dhelp/section.rhtml"
    INDEX_TEMPLATE     = "#{PREFIX}/share/dhelp/index.rhtml"
    FORMAT_NAMES       = {:html             => 'HTML',
                          :pdf              => 'PDF',
                          :postscript       => 'PostScript',
                          :"debiandoc-sgml" => 'DebianDoc-SGML',
                          :dvi              => 'DVI'}


    # Exports to HTML the dhelp document database. The only option is :dir,
    # which specifies the output directory (default is /usr/share/doc/HTML).
    def export(options)
      output_dir = options[:dir] || DEFAULT_EXPORT_DIR

      # Re-create output directory
      FileUtils.rm_rf(output_dir)
      FileUtils.mkdir_p(output_dir, :mode => 0755)
      FileUtils.chdir(output_dir)

      # Create README file
      File.open("README", "w") do |f|
        f.puts <<EOREADME
Don't put files in this directory!
dhelp will delete *all* files in this directory when creating a new index.

Esteban Manchado Velázquez (zoso@debian.org)
EOREADME
      end

      @section_tree = @doc_pool.section_tree

      # Generate section pages from the tree
      @section_tree.each_pair do |section, contents|
        export_section_page(output_dir, section, contents[:documents])
        # Process subsections
        contents[:subsections].each_pair do |subsection, subcontents|
          export_section_page(output_dir,
                              section + "/" + subsection,
                              subcontents[:documents])
        end
      end

      # Write special "section page" for all the docs
      all_docs = []
      @section_tree.each_pair do |section, contents|
        all_docs += contents[:documents]
        all_docs += contents[:subsections].map {|ss, ssc| ssc[:documents]}.flatten
      end
      export_section_page(output_dir, "All", all_docs)

      # @sections is the variable for the template
      @sections = @section_tree.keys.sort

      # Create general index file, now that the sections are already there
      tmpl = ERB.new(File.read(INDEX_TEMPLATE))
      html = tmpl.result(binding)
      File.open("index.html", "w") do |f|
        f.print html
      end
    rescue Errno::EACCES => e
      $stderr.puts "Don't have permissions to regenerate the HTML help"
      exit 1
    end



    def export_section_page(output_dir, section, item_list)
      capitalized_section = Dhelp.capitalize_section(section)
      section_dir = File.join(output_dir, capitalized_section)
      FileUtils.mkdir_p(section_dir, :mode => 0755)
      # Need to change the current directory because of the ERB template
      orig_dir = FileUtils.pwd
      FileUtils.chdir(section_dir)

      # Variables for the template
      @supported_formats = Dhelp::SUPPORTED_FORMATS
      @section_title     = capitalized_section
      @item_list         = item_list.sort{ |a,b|
        a.title.downcase <=> b.title.downcase
      }
      @doc_path_prefix   = "../" *
        # also count "HTML/"
        (section.split('/').size + 1)
      # Set-up gettext environment
      GetText.set_output_charset("UTF-8")
      GetText.bindtextdomain('dhelp')
      # Get HTML for the given section
      tmpl = ERB.new(File.read(SECTION_TEMPLATE))
      html = tmpl.result(binding)

      File.open("index.html", "w") do |f|
        f.print html
      end
      File.chmod 0644, 'index.html'

      # Set the cwd back
      FileUtils.chdir(orig_dir)
    end



    # Returns the correct name for each format
    def format_name(format)
      FORMAT_NAMES[format.downcase.to_sym] || format.capitalize
    end

    # Returns a suitable URL for the given path
    def resource_url(path)
      path.sub(/\/usr\/share\/doc\//, @doc_path_prefix)
    end

    # Proxy, to avoid problems with binding and ERB templates (bindtextdomain
    # doesn't work on the templates when called from the main program)
    def _(msg)
      GetText._(msg)
    end
  end
end
