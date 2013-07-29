require 'rack/test'
require File.expand_path('../../lib/rack-noindex_https', __FILE__)


def app
  Rack::Lint.new(mock_app)
end
def main_app
  lambda { |env|
    request = Rack::Request.new(env)
    case request.path
      when '/' then
        [200, {'Content-Type' => 'application/html'}, ['<html><head>Hello world</head><body></body></html>']]
      when '/test.xml' then
        [200, {'Content-Type' => 'application/xml'}, ['<head></head><xml></xml>']]
      when '/bob' then
        [200, {'Content-Type' => 'application/html'}, ['<body>bob here</body>']]
      else
        [404, 'Nothing here']
    end
  }
end

def mock_app()
  return @app unless @app.nil?
  @app = Rack::Builder.app do
    use Rack::NoindexHttps
    run main_app
  end
end
