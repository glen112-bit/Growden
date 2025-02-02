//
//  ProfileView.swift
//  Growden
//
//  Created by Glen on 29-01-25.
//

import SwiftUI

struct ProfileView: View {
  @EnvironmentObject var viewModel: AuthViewModel
  
    var body: some View {
      List {
        if let user = viewModel.currentUser {
          Section{
          HStack {
            Text(user.initial )
              .font(.title)
              .fontWeight(.semibold)
              .foregroundColor(.white)
              .frame(width: 72, height: 72)
              .background(Color(.systemGray3))
              .clipShape(Circle())
            VStack(alignment: .leading, spacing: 4){
              Text(user.fullName)
                .font(.subheadline)
                .fontWeight(.semibold)
                .padding(.top, 4)
              Text(user.email)
                .font(.footnote)
                .accentColor(.gray)
            }
          }
        }
        Section("General"){
          HStack {
            SetingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
            Spacer()
            Text("1.0.0")
              .font(.subheadline)
              .foregroundColor(Color(.systemGray))
          }
          
        }
        Section("Acount"){
          Button {
            print("Sign Out")
            viewModel.signOut()
          } label: {
            SetingsRowView(imageName: "arrow.left.circle.fill", title: "Sign Out", tintColor: .red)
          }
          Button {
            print("Delete acount")
          } label: {
            SetingsRowView(imageName: "xmark.circle.fill", title: "Delete Acount", tintColor: .red)
          }
          
        }
      }

        }
  }
}

#Preview {
    ProfileView()
}
