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
  end

  describe '.track_tweets' do
    it 'should be success response' do
      success_response = 'All tweets are saved with success'
      stub_request(:any, /localhost:3000/).to_return(:status => [200, success_response])
      TwitterClient.instance.track_tweets 'code'
      response = TwitterClient.instance.result.response
      expect(response.is_a? Net::HTTPOK).to be(true)
    end

    it 'connection refused' do
      expect(TwitterClient.instance.unsended_tweets.length).to eq(0)
      stub_request(:any, /localhost:3000/).to_return do
        raise Errno::ECONNREFUSED
      end

      TwitterClient.instance.track_tweets 'code'
      expect(TwitterClient.instance.unsended_tweets.length).to eq(2)
    end
  end
end