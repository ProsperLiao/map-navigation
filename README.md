# map-navigation
An exercise to use a map(google map) for navigation. 

### How to Use
- run `gem install bundler` if you don't have bundler in your environment.
- run `bundle install` to install cocoapods and cocoapods-keys, which are specified in Gemfile.
- run `bundle pod install` to install dependencies specified in Podfile.
- when asked, provide your own Google Maps API Key.


### Steps to Build this App
- [X] Initialize the project and clone to local.
- [X] Browse the Google Map SDK document.
- [ ] `milestone` Download the sdk, and integrate it into this app show the simplest map. 
    - [ ] setup google cloud platform, enable billing, enable Google map sdk for ios
    - [ ] create API key, secure the API key with App Bundle Identifier restriction and quota limit.
    - [X] use cocoapods to install the GoogleMaps sdk.
    - [X] add API key with cocoapods-keys plugin for obfuscation.
    - [ ] integrate GoogleMaps view into the app for the simple usage.
    
- [ ] Add feature that user can tap on the map to select a destination.
- [ ] `milestone` Add the start button, once it's clicked, navigate to the destination. 
    - [ ] traveled path in real time
- [ ] `milestone` Summary of the trip
    - [ ] A map showing the traveled path
    - [ ] Elapsed trip time
    - [ ] Total distance traveled

- [ ] Additional features
    - [ ] GPS signal loss notification
    - [ ] path recalculation
