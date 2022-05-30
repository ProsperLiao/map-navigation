# map-navigation
An exercise to use a map(google map) for navigation. It have the features of navigating your for a destination, drawing your travel path, calculating your traveled time and traveled distance.
You should have a Google Maps Platform API Key to run this app. Check the official document. [Google Maps Platform](https://developers.google.com/maps)
This app is iOS 15.0 and above supported.



## How to Run this App
- run `cd ${PATH_OF_YOUR_SOURCE_ROOT}`
- run `gem install bundler` if you don't have bundler in your environment.
- run `bundle install` to install cocoapods and cocoapods-keys, which are specified in Gemfile.
- run `bundle exec pod install` to install dependencies specified in Podfile.
- The firs time your run bundle pod install, you'll be asked to provide the Google Maps API key ,  please provide your own Google Maps API Key.
- open `map-navigation.xcworkspace` with Xcode, if you run it on simultor, you need to simulate location with xcode debugger.



## Steps to Build this App
- [x] Initialize the project and clone to local.
- [x] Browse the Google Map SDK document.
- [x] `milestone` Download the sdk, and integrate it into this app, show the simplest map. 
    - [x] setup google cloud platform, enable billing, enable Google map sdk for ios
    - [x] create API key, secure the API key with App Bundle Identifier restriction and quota limit.
    - [x] use cocoapods to install the GoogleMaps sdk.
    - [x] add API key with cocoapods-keys plugin for obfuscation.
    - [x] integrate GoogleMaps view into the app for the simple usage.
        - get the API key in AppDelegate
        - use UIViewRepresentable to integrate the GMSMapView into SwiftUI

- [x] Construct the MVVM pattern.
- [x] Make the map started with locating at the user current location. 
- [x] Add feature that user can tap on the map to select a destination.
- [x] `milestone` Add the start button, once it's clicked, navigate to the destination. 
    - [x] Add Alamofire for network request
    - [x] traveled path in real time
- [x] `milestone` Summary of the trip
    - [x] A map showing the traveled path
    - [x] Elapsed trip time
    - [x] Total distance traveled

- [x] Additional features
    - [x] GPS signal loss notification
    - [x] path recalculation

