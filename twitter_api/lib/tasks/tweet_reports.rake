namespace :tweet_reports do
  desc 'get average tweets maded by time'
  task time_average: :environment do
    results = {}
    ActiveRecord::Base.connection.execute('SELECT COUNT(id) AS tweets
         , EXTRACT(hour from "date") AS hour
         , EXTRACT(day from "date") AS day
      FROM tweets
     GROUP BY hour, day').each do |tuple|
      results[tuple['hour']] ||= Hash.new 0
      results[tuple['hour']]['tweets'] += tuple['tweets'].to_i
      results[tuple['hour']]['days'] += 1
      results[tuple['hour']][:result] = results[tuple['hour']]['tweets'] / results[tuple['hour']]['days']
    end

    str = ''
    results.each_pair do |key, obj|
       str += "#{key}:00 -> #{obj[:result]}, "
    end

    puts "Média de tweets por horário #{str}"
  end

  desc 'get user with more tweets'
  task user_with_more_tweets: :environment do
    result = {
        '_user' => '',
        'tweets' => 0
    }
    ActiveRecord::Base.connection.execute('SELECT COUNT(id) AS tweets
         , username AS _user
      FROM tweets
     GROUP BY _user').each do |tuple|
      result = tuple if tuple['tweets'].to_i > result['tweets'].to_i
    end

    puts "Usuário com maior número de tweets #{result['_user']} - #{result['tweets']}"
  end
end
