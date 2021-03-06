require "rack-noindex_https/version"

module Rack
  class NoindexHttps
    def initialize(app)
      @app = app
    end

    def call(env)
      @status, @headers, @body = @app.call(env)
      
      if env['rack.url_scheme'] == 'https' && (@headers['Content-Type'] =~ /application\/html/ || @headers['Content-Type'] =~ /text\/html/)
        new_body = []
        @body.each {|fragement| new_body << fragement.gsub(%r{</head>}, '<meta name="robots" content="noindex"></head>') } 
        @body = new_body
      end

      [@status, @headers, @body]
    end
  end
end
