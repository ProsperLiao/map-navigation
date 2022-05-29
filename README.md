# map-navigation
An exercise to use a map(google map) for navigation. This app is iOS 15.0 and above supported.


---
### How to Run this App
- run `cd ${PATH_OF_YOUR_SOURCE_ROOT}`
- run `gem install bundler` if you don't have bundler in your environment.
- run `bundle install` to install cocoapods and cocoapods-keys, which are specified in Gemfile.
- run `bundle pod install` to install dependencies specified in Podfile.
- The firs time your run bundle pod install, you'll be asked to provide the Google Maps API key ,  please provide your own Google Maps API Key.
- open `map-navigation.xcworkspace` with Xcode, if you run it on simultor, you need to simulate location with xcode debugger.


---
### Steps to Build this App
- [X] Initialize the project and clone to local.
- [X] Browse the Google Map SDK document.
- [X] `milestone` Download the sdk, and integrate it into this app, show the simplest map. 
    - [X] setup google cloud platform, enable billing, enable Google map sdk for ios
    - [X] create API key, secure the API key with App Bundle Identifier restriction and quota limit.
    - [X] use cocoapods to install the GoogleMaps sdk.
    - [X] add API key with cocoapods-keys plugin for obfuscation.
    - [X] integrate GoogleMaps view into the app for the simple usage.
        - get the API key in AppDelegate
        - use UIViewRepresentable to integrate the GMSMapView into SwiftUI

- [X] Construct the MVVM pattern.
- [X] Make the map started with locating at the user current location. 
- [X] Add feature that user can tap on the map to select a destination.
- [ ] `milestone` Add the start button, once it's clicked, navigate to the destination. 
    - [ ] traveled path in real time
- [ ] `milestone` Summary of the trip
    - [ ] A map showing the traveled path
    - [ ] Elapsed trip time
    - [ ] Total distance traveled

- [ ] Additional features
    - [ ] GPS signal loss notification
    - [ ] path recalculation
    - [ ] background usage?
    - [ ] local push notification when reaching the destination


### 
