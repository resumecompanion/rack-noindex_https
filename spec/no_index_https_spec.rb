require 'spec_helper'

module Rack
  describe NoindexHttps do
    include Rack::Test::Methods
    it 'should inject no index tag into head of https HTML request' do
      get('https://example.org/').body.should == '<html><head>Hello world<meta name="robots" content="noindex"></head><body></body></html>'
    end

    it 'should not inject no index tag of http HTML request' do
      get('/').body.should == '<html><head>Hello world</head><body></body></html>'
    end

    it 'should not inject no index tag into non HTML requests for HTTP' do
      get('/test.xml').body.should == '<head></head><xml></xml>'
    end

    it 'should not inject no index tag into non HTML requests for HTTPS' do
      get('https://example.org/test.xml').body.should == '<head></head><xml></xml>'
    end
  end
end
