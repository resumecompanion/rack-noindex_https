require "rack-noindex_https/version"

module Rack
  class NoindexHttps
    def initialize(app)
      @app = app
    end

    def call(env)
      puts "got here"
      @status, @headers, @body = @app.call(env)
      puts env.inspect
      
      if env['rack.url_scheme'] == 'https' && (@headers['Content-Type'] =~ /application\/html/ || @headers['Content-Type'] =~ /text\/html/)
        @body = @body.collect {|fragement| puts "updating"; fragement.gsub(%r{</head>}, '<meta name="robots" content="noindex"></head>') } 
      end

      puts 'finished'

      [@status, @headers, @body]
    end
  end
end
