require "todo/version"

# Configuration
#
# Basic authorization:
#
# Get your API public key from Trello via the irb console:
#
# $ gem install ruby-trello
# $ irb -rubygems
# irb> require 'trello'
# irb> Trello.open_public_key_url                         # copy your public key
# irb> Trello.open_authorization_url key: 'yourpublickey' # copy your member token
#
# You can now use the public key and member token in your app code:

require 'trello'

Trello.configure do |config|
  config.developer_public_key = ENV['TRELLO_DEVELOPER_PUBLIC_KEY'] # The "key" from step 1
  config.member_token = ENV['TRELLO_MEMBER_TOKEN'] # The token from step 2.
end

# 2-legged OAuth authorization

# Trello.configure do |config|
#   config.consumer_key = ENV['TRELLO_CONSUMER_KEY']
#   config.consumer_secret = ENV['TRELLO_CONSUMER_SECRET']
#   config.oauth_token = ENV['TRELLO_OAUTH_TOKEN']
#   config.oauth_token_secret = ENV['TRELLO_OAUTH_TOKEN_SECRET']
# end

# 3-legged OAuth authorization

# Trello.configure do |config|
#   config.consumer_key    = ENV['TRELLO_CONSUMER_KEY']
#   config.consumer_secret = ENV['TRELLO_CONSUMER_SECRET']
#   config.return_url      = "http://your.site.com/path/to/receive/post"
#   config.callback        = lambda { |request_token| DB.save(request_token.key, request_token.secret) }
# end

# All the calls this library makes to Trello require authentication using these keys. Be sure to protect them.

module Todo
  def self.todo
    user = Trello::Member.find("me")
    puts user.full_name
    puts

    scratch = nil
    user.boards.each do |board|
      # puts board.name
      # puts
      scratch = board if board.name == 'Scratch'
    end

    puts "Board: #{scratch.name}"
    puts

    to_do_list = nil
    scratch.lists.each do |list|
      # puts list.name
      # puts
      to_do_list = list if list.name == 'To Do'
    end

    puts "List: #{to_do_list.name}"
    puts

    unless to_do_list.cards.any?
      Trello::Card.create(list_id: to_do_list.id, name: 'My To Do', description: 'my to do')
    end

    to_do_list.cards.each do |card|
      puts card.name
    end
  end
end
