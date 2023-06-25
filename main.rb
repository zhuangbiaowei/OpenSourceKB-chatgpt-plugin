require "sinatra"
require "rack/cors"
require "liquid"

require "./kb"
require "./api_config"
Dir[File.join('models', '*.rb')].each { |file| require_relative file }

Host = 'localhost'
Port = 4567

use Rack::Cors do
    allow do
        origins 'chat.openai.com'
        resource '*', :headers => :any, :methods => [:get, :post, :put, :delete, :options]
    end
end

get '/.well-known/icon.png' do
    send_file 'icon.png'
end

get '/.well-known/openapi.yaml' do
    content = File.read("openapi.yaml")
    template = Liquid::Template.parse(content)
    template.render('host' => Host, 'port' => Port, 'paths' => APIConfig.paths_string, 'components' => APIConfig.components_string)
end

get '/.well-known/ai-plugin.json' do
    content = File.read("ai-plugin.json")
    template = Liquid::Template.parse(content)
    template.render('host' => Host, 'port' => Port)
end
