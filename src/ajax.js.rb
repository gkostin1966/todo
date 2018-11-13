require 'opal'
require 'jquery'
require 'opal/jquery'

# div = $$.document.getElementById(id)

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
end
