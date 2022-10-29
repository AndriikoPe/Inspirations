//
//  AppDelegate.swift
//  Test
//
//  Created by Пермяков Андрей on 28.10.2022.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  var window: UIWindow?
  private(set) var appCoordinator: AppCoordinator?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [
      UIApplication.LaunchOptionsKey: Any
    ]?
  ) -> Bool {
    let window = UIWindow(frame: UIScreen.main.bounds)
    self.window = window

    let appCoordinator = AppCoordinator(window: window)
    self.appCoordinator = appCoordinator
    appCoordinator.start()
    
    return true
  }
}

