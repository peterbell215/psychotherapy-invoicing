
require 'rails/generators/base'


  class SvelteModelGenerator < Rails::Generators::NamedBase
    source_root File.expand_path("templates", __dir__)
    TARGET_PATH = 'app/frontend/modules'

    def configure_model
      copy_file "FetchData.ts", TARGET_PATH unless File.exist?(File.expand_path('FetchData.ts', TARGET_PATH))

      generate_svelte_typescript
    end

    def generate_svelte_typescript
      empty_directory "#{TARGET_PATH}/#{file_name.pluralize}"


      # klass = class_name.classify


    end
  end
