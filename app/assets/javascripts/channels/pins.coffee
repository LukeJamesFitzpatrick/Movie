jQuery(document).on 'ready', ->
  comments = $('#comments')
  if comments.length > 0
    App.global_chat = App.cable.subscriptions.create {
      channel: "PinsChannel"
      pin_id: comments.data('pin-id')
    },
    connected: ->
    disconnected: ->
    received: (data) ->
      comments.append data['comment']
    send_comment: (comment, pin_id) ->
      @perform 'send_comment', comment: comment, pin_id: pin_id
  $('#new_comment').submit (e) ->
    $this = $(this)
    textarea = $this.find('#comment_content')
    if $.trim(textarea.val()).length > 1
      App.global_chat.send_comment textarea.val(),
      comments.data('pin-id')
      textarea.val('')
    e.preventDefault()
    return false
