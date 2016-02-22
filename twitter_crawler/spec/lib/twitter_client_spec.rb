require 'spec_helper'
require_relative '../../lib/twitter_client'

class FakeConnection
  def initialize(body)
    @body = body
  end

  def stream(_, response)
    @body.each_line do |line|
      response.on_body(line)
    end
  end
end


describe TwitterClient do
  before(:each) do
    TwitterClient.instance.client.connection = FakeConnection.new(fixture('track_streaming.json'))
    stub_request(:any, /localhost:3000/).to_return(:status => [200, 'All tweets are saved with success'])
  end

  it '' do
    TwitterClient.instance.track_tweets 'code'
  end
end