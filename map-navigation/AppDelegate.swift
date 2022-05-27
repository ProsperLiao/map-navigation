//
//  AppDelegate.swift
//  map-navigation
//
//  Created by Hongxing Liao on 2022/5/28.
//

import UIKit
import GoogleMaps
import Keys

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        let keys = MapNavigationKeys()
        GMSServices.provideAPIKey(keys.googleMapsAPIKey)
        
        return true
    }
}
