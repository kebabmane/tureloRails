class Notifications
  constructor: ->
    @notifications = $("[data-behavior='notifications']")
    @setup() if @notifications.length > 0

  setup: ->
    $("[data-behavior='notifications-link']").on "click", @handleClick
    $.ajax(
      url: "/notifications.json"
      dataType: "JSON"
      method: "GET"
      success: @handleSuccess
    )

  handleSuccess: (data) =>
    items = $.map data, (notification) ->
      "<li>
        <span class='item'>
          <span class='item-left'>
            <img src='http://lorempixel.com/50/50/'' alt='' />
              <span class='item-info'>
                  <span><%= FeedEntry.find(notification.notifiable_id).title %></span>
              </span>
          </span>
        </span>
       </li>"

    $("[data-behavior='unread-count']").text(items.length)
    $("[data-behavior='notification-items']").html(items)

jQuery ->
  new Notifications
