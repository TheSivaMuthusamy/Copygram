module ApplicationHelper
  .container
    -flash.each do |name, msg|
      = content_tag :div, msg, class: [:alert, alert_for(name)]
    = yield
end
