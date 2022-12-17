namespace :push_favorite do
  desc "LINEBOT:お気に入りの通知"
  task :push_line_message_task => :environment do
    
    favorites = Knowledge.where(title: "user_uid")
    favorites.each do |f|
      message = {
        type: 'text',
        text: f.title
      }
    
    client = Line::Bot::Client.new { |config|
        config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
        config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
      }
      response = client.push_message(f.user_uid, message)
      p response
    end
  end
end
