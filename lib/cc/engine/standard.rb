require "json"
require "delegate"
require "pathname"
require "standard"
require "rubocop/config_patch"
require "cc/engine/config_upgrader"
require "cc/engine/source_file"
require "cc/engine/category_parser"
require "cc/engine/file_list_resolver"
require "cc/engine/issue"
require "active_support"
require "active_support/core_ext"

module CC
  module Engine
    class Standard
      def initialize(root, engine_config, io)
        @root = root
        @engine_config = engine_config || {}
        @io = io
      end

      def run
        Dir.chdir(root) do
          files_to_inspect.each do |path|
            SourceFile.new(
              builds_config: builds_config,
              io: io,
              path: path,
              root: root
            ).inspect
          end
        end
      end

      private

      attr_reader :root, :engine_config, :io

      def files_to_inspect
        @_files_to_inspect ||= FileListResolver.new(
          builds_config: builds_config,
          engine_config: engine_config,
          root: root
        ).expanded_list
      end

      def builds_config
        @_builds_config ||= begin
          override_default_ruby_version
          ::Standard::BuildsConfig.new.call([])
        end
      end

      def override_default_ruby_version
        ruby_version = ".ruby-version"
        if File.exist?(ruby_version)
          project_ruby_version = `cat #{ruby_version}`
          ::Standard::LoadsYamlConfig.const_set(:RUBY_VERSION, project_ruby_version)
        end
      end
    end
  end
end
