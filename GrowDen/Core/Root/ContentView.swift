//
//  ContentView.swift
//  Growden
//glen@mail.com
//  Created by Glen on 22-01-25.
//

import SwiftUI
import FirebaseFirestore
import Firebase
//import FirebaseApp
import FirebaseAuth



struct ContentView: View {
  @EnvironmentObject var viewModel: AuthViewModel
//  @ObservedObject var viewModel: AuthViewModel
//init() {
//    FirebaseApp.configure()
//  }
  var body: some View {
    Group {
        if viewModel.userSession != nil {
          ProfileView()
         } else {
           LoginView()
         }
      }
   }
}

#Preview {
    ContentView()
}

