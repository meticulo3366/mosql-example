if Meteor.isClient
  BrowsersCount = new Meteor.Collection 'browsers-count'
  Meteor.startup ->
    Meteor.subscribe 'browsers_count'
    Session.setDefault 'browsers_count', 'Waiting on Subsription'

  Meteor.setInterval (->
    Browsers.insert
      engine: "Austin"
      browser: "Austin 3.0"
      platform: "Austin.4+"
      version: 522.1
      grade: "A"
  ), 1000

  Deps.autorun (->
    browsers = BrowsersCount.findOne()
    unless browsers is undefined
      Session.set 'browsers_count', browsers.count
  )

  Template.browsers.count = ->
    return Session.get 'browsers_count'