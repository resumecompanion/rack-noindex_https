require "rack-noindex_https/version"

module Rack
  class NoindexHttps
    def initialize(app)
      @app = app
    end

    def call(env)
      dup._call(env)
    end

    def _call(env)
      @status, @headers, @body = @app.call(env)
      request = Rack::Request.new(env)
      
      if request.scheme == 'https' && @headers['Content-Type'] == 'application/html'
        @body = @body.collect {|fragement| fragement.gsub(%r{</head>}, '<meta name="robots" content="noindex"></head>') } 
      end

      [@status, @headers, @body]
    end
  end
end
