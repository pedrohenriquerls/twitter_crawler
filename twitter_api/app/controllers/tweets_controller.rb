require 'byebug'

class TweetsController < ApplicationController

  def create
    @invalid_tweets = Tweet.create(tweets_params).delete_if(&:valid?)

    if @invalid_tweets.blank?
      render text: 'All tweets are saved with success'
    else
      render text: 'Some tweets dont be saved'
    end
  end

  private
    def tweets_params
      params.permit(tweets: [:username, :key, :date, :content])[:tweets]
    end
end
