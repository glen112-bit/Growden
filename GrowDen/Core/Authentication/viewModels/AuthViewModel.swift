//
//  AuthViewModel.swift
//  Growden
//
//  Created by Glen on 29-01-25.
//

import Foundation

//import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth
//class Global: ObservableObject
//{
  
  
  
//    static let shared = Global()
//
//    @Published var num = 10
//}
//
//class MyClass:ObservableObject
//{
//    @Published var mode = 1
//    let global = Global.shared    // << here !!
//
//// ...
//}
protocol AuthenticationFormProtocol {
  var formIsValid:Bool {get}
}


@MainActor
class  AuthViewModel: ObservableObject {
  @Published var userSession: FirebaseAuth.User?
  @Published var currentUser: User?
  @Published var currentUserId: String?
  

  
  init() {
    self.userSession = Auth.auth().currentUser
    Task {
      await fetchUser()
    }
  }
  func signIn(email: String, password: String) async throws {
    do{
      let result = try await Auth.auth().signIn(withEmail: email, password: password )
      self.userSession = result.user
      await fetchUser()
      print(result.user)
        //      await fetchUser()
    }
  }
  
  func createUser( email: String, password: String, fullName: String) async throws {
    do{
      let result = try await Auth.auth().createUser(withEmail: email, password: password)
      self.userSession = result.user
      let user = User(id: result.user.uid, fullName: fullName, email: email)
      let encodedUser = try Firestore.Encoder().encode(user)
      try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
      await fetchUser()
      print("createUser \(result)")
//    } catch {
//      print("something wrong: \(error.localizedDescription)")
    }
  }
  
  func signOut(){
    print("signOut")
    do{
      try? Auth.auth().signOut()
      self.currentUser = nil
      self.userSession = nil
//    }catch{
//      print("error to signout: \(error.localizedDescription)")
    }
  }
  
  func deleteAcount(){
    print("delete")
  }
  
  func fetchUser() async {
    print("your current user is:\(String(describing: self.currentUser))")
    guard let uid = Auth.auth().currentUser?.uid else {return}
    
    guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
    
    self.currentUser = try? snapshot.data(as: User.self)
  }
}
