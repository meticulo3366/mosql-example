@Browsers = new Meteor.Collection 'browsers'

Browsers.allow
  insert: -> true
  update: -> true
  remove: -> true

if Meteor.isServer
  Meteor.publish 'browsers_count', ->
    count = 0 # the count of all users
    initializing = true # true only when we first start
    handle = Browsers.find().observeChanges
      added: =>
        count++ # Increment the count when users are added.
        @changed 'browsers-count', 1, {count} unless initializing
      removed: =>
        count-- # Decrement the count when users are removed.
        @changed 'browsers-count', 1, {count}

    initializing = false

    # Call added now that we are done initializing. Use the id of 1 since
    # there is only ever one object in the collection.
    @added 'browsers-count', 1, {count}

    # Let the client know that the subscription is ready.
    @ready()

    # Stop the handle when the user disconnects or stops the subscription.
    # This is really important or you will get a memory leak.
    @onStop -> handle.stop()

  Meteor.startup ->
    if Browsers.find().count() is 0
      browserList = [
        {
          engine: "Trident"
          browser: "Internet Explorer 4.0"
          platform: "Win 95+"
          version: 4
          grade: "X"
        }
        {
          engine: "Trident"
          browser: "Internet Explorer 5.0"
          platform: "Win 95+"
          version: 5
          grade: "C"
        }
        {
          engine:  "Trident"
          browser: "Internet Explorer 5.5"
          platform: "Win 95+"
          version: 5.5
          grade: "A"
        }
        {
          engine: "Trident"
          browser: "Internet Explorer 6.0"
          platform: "Win 98+"
          version: 6
          grade: "A"
        }
        {
          engine: "Trident"
          browser: "Internet Explorer 7.0"
          platform: "Win XP SP2+"
          version: 7
          grade: "A"
        }
        {
          engine: "Gecko"
          browser: "Firefox 1.5"
          platform: "Win 98+ / OSX.2+"
          version: 1.8
          grade: "A"
        }
        {
          engine: "Gecko"
          browser: "Firefox 2"
          platform: "Win 98+ / OSX.2+"
          version: 1.8
          grade: "A"
        }
        {
          engine: "Gecko"
          browser: "Firefox 3"
          platform: "Win 2k+ / OSX.3+"
          version: 1.9
          grade: "A"
        }
        {
          engine: "Webkit"
          browser: "Safari 1.2"
          platform: "OSX.3"
          version: 125.5
          grade: "A"
        }
        {
          engine: "Webkit"
          browser: "Safari 1.3"
          platform: "OSX.3"
          version: 312.8
          grade: "A"
        }
        {
          engine: "Webkit"
          browser: "Safari 2.0"
          platform: "OSX.4+"
          version: 419.3
          grade: "A"
        }
        {
          engine: "Webkit"
          browser: "Safari 3.0"
          platform: "OSX.4+"
          version: 522.1
          grade: "A"
        }
      ]
      count = 0
      _.each browserList, (browser) ->
        Browsers.insert browser
        count++
      console.log( count + ' browsers inserted')