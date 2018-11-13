require 'opal'
require 'native'
require 'opal/jquery'

Document.ready? do
  Element.find('#ajax').on :click do |event|
    div_demo = Element.find('#demo')
    HTTP.get('ajax_info.txt') do |response|
      if response.ok?
        div_demo.text(response.body)
      else
        div_demo.text(response.inspect)
      end
    end
  end

  class Trello
    def initialize
      @trello = Native(`Trello`)
    end

    def version
      @trello.version
    end

    def authentication_success
      puts 'Successful authentication'
    end

    def authentication_failure
      puts 'Failed authentication'
    end

    def authorize
      @trello.authorize({
                           type: 'popup',
                           name: 'Getting Started Application',
                           scope: {
                               read: 'true',
                               write: 'true' },
                           expiration: 'never',
                           success: `function(){ self.$authentication_success() }`,
                           error: `function(){ self.$authentication_failure() }`
                       })
    end

    def creation_success(data)
      puts 'Card created successfully.'
      puts "data #{data}"
      puts `JSON.stringify(data, null, 2)`
    end

    def new_card
      list = '5be618c7f0ee00436df7217a'
      card = {
          name: 'Opal Ruby',
          desc: 'This is the description of our new card.',
          idList: list,
          pos: 'top'
      }

      @trello.post('/cards/', card, `function(data){ self.$creation_success(data) }`)
    end
  end

  trello = Trello.new
  puts "Trello Version #{trello.version}"
  trello.authorize
  trello.new_card
end
