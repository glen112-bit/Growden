//
//  User.swift
//  Growden
//
//  Created by Glen on 29-01-25.
//

import Foundation

struct User: Identifiable, Codable {
  var id: String
  var fullName: String
  var email: String
  
  var initial: String {
    let formatter = PersonNameComponentsFormatter()
    if let components = formatter.personNameComponents(from: fullName) {
      formatter.style = .abbreviated
      return formatter.string(from: components )
//      return "\(components.givenName?.first ?? "")"
    }
    return ""
  }
}

extension User {
  static var MOCK_USER: User {
    User(
      id: NSUUID().uuidString,
      fullName: "Glen MacLeod",
      email: "glen@example.com"
    )
  }
}
