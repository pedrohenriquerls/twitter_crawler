class Tweet < ActiveRecord::Base
  validates_presence_of :content, :date, :username, :key
  validates_length_of :content, maximum: 140, allow_blank: false
end
