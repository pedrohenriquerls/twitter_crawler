# Twitter Crawler

Its a simple rake task to get tweets from one or more keywords

Here's a simple example of how get tweets with ruby and test keywords:

```ruby
rake track_tweets['ruby, test']
```

If the twitter API offline, the crawler still saving on memory the found tweets, after API become online again the tweets will be sended.
