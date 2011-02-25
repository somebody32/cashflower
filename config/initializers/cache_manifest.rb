IPHONE_CACHE_MANIFEST = Rack::Offline.configure do

  # styles
  cache "/stylesheets/jqtouch/jqtouch.css"
  cache "/stylesheets/jqtouch/themes/apple/theme.css"

  # js
  cache "/javascripts/libs/jquery.min.js"
  cache "/javascripts/libs/jqtouch.js"
  cache "/javascripts/libs/handlebars-0.9.0.pre.4.js"
  cache "/javascripts/libs/json.js"
  cache "/javascripts/libs/jquery.offline.js"
  cache "/javascripts/application.js"

  # images
  %w(toolButton backButton activeButton toolbar pinstripes chevron).each do |img|
    cache "/images/jqtouch/themes/apple/img/#{img}.png"
  end
  %w(coin income outcome).each { |img| cache "/images/#{img}.png" }

  network "/"
end

