//
//  SwiftUIAuth.swift
//  Growden
//
//  Created by Glen on 22-01-25.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}

@main
struct GrowDenApp: App {
//  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  @StateObject var viewModel = AuthViewModel()
  @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
  
  
  var body: some Scene {
    WindowGroup{
      ContentView()
        .environmentObject(viewModel)
        }
    }
}


