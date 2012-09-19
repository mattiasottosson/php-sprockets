require 'sprockets'
require 'sprockets-sass'
require 'sass'
require 'compass'

class JSAsset
  attr_accessor :assets, :asset_path, :env

  def initialize(assets,asset_path,env)
    self.assets = assets
    self.env = env
    self.asset_path = asset_path
    self.collect
  end

  def collect
    #Collect all assets
    self.assets = self.assets.to_a.map do |asset|
      asset.pathname.to_s.split('/').last
    end

    #Remove the manifest file it self
    self.assets.shift

    #Combine in to scripts tags
    self.assets = self.assets.map do |asset|
      '<script src="//'+self.env['HTTP_HOST']+'/'+self.asset_path+'/'+asset+'" type="text/javascript"></script>'
    end
  end

  def tags
    self.assets.join("\n")
  end

end

project_root = File.expand_path(File.dirname(__FILE__))
asset_path = 'assets'

sprockets = Sprockets::Environment.new(project_root) do |env|
  env.logger = Logger.new(STDOUT)
end

sprockets.append_path(File.join(project_root, asset_path, 'stylesheets'))
sprockets.append_path(File.join(project_root, asset_path, 'javascripts'))
sprockets.append_path(File.join(project_root, asset_path, 'javascripts/public'))
sprockets.append_path(File.join(project_root, asset_path, 'images'))

map "/assets" do
  run sprockets
end

map "/assets/images" do
  run sprockets
end

map '/javascripts' do
  run Proc.new { |env| [
        200,
        {"Content-Type" => "text/plain"},
        [JSAsset.new(sprockets['application-manifest.js'],asset_path,env).tags]
      ]}
end
