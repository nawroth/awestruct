require 'awestruct'
require 'awestruct/commands/manifest'


module Awestruct
  module Commands
    class Init

      BASE_MANIFEST = Manifest.new {
        mkdir( '_config' )
        mkdir( '_layouts' )
        mkdir( '_ext' )
        copy_file( '_ext/pipeline.rb', File.join( File.dirname(__FILE__), 'base_pipeline.rb' ) )
        mkdir( 'stylesheets' )
      }

      def initialize(dir=Dir.pwd,framework='compass',scaffold=true)
        @dir       = dir
        @framework = framework
        @scaffold  = scaffold
      end

      def run()
        manifest = Manifest.new( BASE_MANIFEST )
        manifest.install_compass( @framework )
        if ( @scaffold )
          manifest.copy_file( '_layouts/base.html.haml', File.join( File.dirname(__FILE__), '/base_layout.html.haml' ) )
          manifest.copy_file( 'index.html.haml', File.join( File.dirname(__FILE__), '/base_index.html.haml' ) )
        end
        manifest.perform( @dir )
      end

    end
  end
end