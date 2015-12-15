json.array! @notifications do |notification|
  json.id notification.id
  #json.recipient notification.recipient
  json.actor notification.actor.nickname
  json.action notification.action
  json.notifiable do #notification.notifiable
    json.type "a #{notification.notifiable.class.to_s.underscore.humanize.downcase}"
  end
  json.url feed_feed_entry_path(notification.notifiable.feed_id, notification.notifiable.id, anchor: dom_id(notification.notifiable))
end
