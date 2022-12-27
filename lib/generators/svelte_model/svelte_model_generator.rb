
require 'rails/generators/base'


  class SvelteModelGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("templates", __dir__)
    TARGET_PATH = 'app/frontend/modules'

    def configure_model
      klass = class_name.classify

      copy_file "FetchData.ts", TARGET_PATH unless File.exist?(File.expand_path('FetchData.ts', TARGET_PATH))
    end


  end
