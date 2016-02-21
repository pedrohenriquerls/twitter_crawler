require 'byebug'

class TweetsController < ApplicationController

  def create
    @invalid_tweets = Tweet.create(tweets_params).delete_if(&:valid?)

    if @invalid_tweets.blank?
      render text: 'All tweets are saved with success'
    else
      render text: 'Some tweets dont be saved', status: :unprocessable_entity
    end
  end

  def list_all
    render json: Tweet.all.to_json
  end

  private
    def tweets_params
      params.permit(tweets: [:username, :key, :date, :content])[:tweets]
    end
end
