if Meteor.isClient
  Meteor.setInterval (->
    Browsers.insert
      engine: "Austin"
      browser: "Austin 3.0"
      platform: "Austin.4+"
      version: 522.1
      grade: "A"
  ), 1000