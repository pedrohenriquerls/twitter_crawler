# Tweets API

Its a simple endpoint to save the tweets getted on Twitter Crawler

##Api
#####Post: tweets
params: key, username, date, content
>Example:
>curl -H "Content-Type: application/json" -X POST -d '{"tweets":[{"username": "mussum", "content": "cacildes essa biritis", "key": "cacildes", "date": "2016-02-21 19:18:20 +0000"}]}' localhost:3000/tweets

>Response: 'All tweets are saved with success'.
