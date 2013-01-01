require 'sprockets'
require 'sprockets-sass'
require 'sass'
require 'compass'

class Compressor
  def self.run
    project_root = File.expand_path(File.dirname(__FILE__))
    asset_path = 'assets'

    sprockets = Sprockets::Environment.new(project_root) do |env|
      env.logger = Logger.new(STDOUT)
      env.js_compressor = :uglifier
      env.css_compressor = :yui
    end

    sprockets.append_path(File.join(project_root, asset_path, 'stylesheets'))
    sprockets.append_path(File.join(project_root, asset_path, 'javascripts'))
    sprockets.append_path(File.join(project_root, asset_path, 'javascripts/public'))
    sprockets.append_path(File.join(project_root, asset_path, 'images'))

    puts "** Generating compressed js... "
    File.open("#{asset_path}/compressed/application.min.js", 'w') do |f|
       f.write(sprockets.find_asset('application-manifest.js').to_s)
    end

    puts "** Generating compressed css... "
    File.open("#{asset_path}/compressed/application.min.css", 'w') do |f|
       f.write(sprockets.find_asset('application-manifest.css').to_s)
    end

  end
end


namespace :assets do
  desc "Compress assets"
  task :compress do
    Compressor.run
  end
end

