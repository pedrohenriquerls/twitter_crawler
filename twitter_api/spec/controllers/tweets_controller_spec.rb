require 'spec_helper'

describe TweetsController, type: :controller do
  let(:date){DateTime.new(2016, 2, 2)}

  describe '#create' do
    it 'should be created 2 tweets' do
      params = {tweets: [
        {username: 'test', content: 'lorem ipsum', key: 'ipsum', date: date},
        {username: 'test', content: 'lorem ipsum2', key: 'ipsum2', date: date}
      ]}

      expect(Tweet.count).to eq(0)

      post :create, params
      assert_response :success

      invalid_tweets = assigns :invalid_tweets
      expect(invalid_tweets.blank?).to be(true)
      expect(Tweet.count).to eq(2)
    end

    it 'should be created 1 tweet' do
      params = {tweets: [
          {username: 'test', content: 'lorem ipsum', key: 'ipsum', date: date},
          {username: 'test', content: '', key: 'ipsum2', date: date}
      ]}

      expect(Tweet.count).to eq(0)

      post :create, params
      assert_response :success

      invalid_tweets = assigns :invalid_tweets
      expect(invalid_tweets.length).to eq(1)
      expect(Tweet.count).to eq(1)
    end
  end
end