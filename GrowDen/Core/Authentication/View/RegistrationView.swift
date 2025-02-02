//
//  RegistrationView.swift
//  Growden
//
//  Created by Glen on 29-01-25.
//

import SwiftUI

struct RegistrationView: View {
  @State private var email = ""
  @State private var fullName = ""
  @State private var password = ""
  @State private var confirmPassword = ""
  @Environment(\.dismiss) var dismiss
  @EnvironmentObject var viewModel: AuthViewModel
//  @StateObject var viewModel: AuthViewModel
//  @ObservedObject var viewModel: AuthViewModel

  var body: some View {
    VStack{
      Image("logo").resizable().scaledToFill().frame(width: 150, height: 150).cornerRadius(15).padding(.top, 25)
      VStack(spacing: 24){
        InputView(text: $email,
                  title: "Email Adress",
                  placeholder: "email@adreess.com")
        .autocapitalization(.none)
        
        InputView(text: $fullName, title: "full name", placeholder: "full name").autocapitalization(.none)
        
        InputView(text: $password, title: "Password", placeholder: "password", isSecureField: true).autocapitalization(.none)
        
        ZStack( alignment: .trailing ) {
          InputView(text: $confirmPassword, title: "Password", placeholder: "Confirm your Password", isSecureField: true).autocapitalization(.none)
          if !password.isEmpty && !confirmPassword.isEmpty{
            if password == confirmPassword {
              Image(systemName: "checkmark.circle.fill")
                .imageScale(.large)
                .fontWeight(.bold)
                .foregroundColor(Color(.systemGreen))
            } else {
               Image(systemName: "xmark.circle.fill")
                .imageScale(.large)
                .fontWeight(.bold)
                .foregroundColor(Color(.systemRed))

            }
          }
        }
        Spacer()
        Button{
          Task {
            try await viewModel.createUser(email: email, password: password, fullName: fullName)
          }
        } label: {
          HStack{
            Text("SIGN UP").fontWeight(.semibold)
            Image(systemName: "chevron.right")
          }
          .foregroundColor(.white)
          .frame(width: UIScreen.main.bounds.width - 32, height: 48)
        }
        .background(.blue)
        .cornerRadius(18)
        .disabled(!formIsValid)
        .opacity(formIsValid ? 1.0 : 0.5)
        .padding()
        Spacer()
        Button{
          dismiss()
        } label: {
          HStack(spacing: 3){
                Text("Already have acount")
                Text("Sign In").fontWeight(.bold)
            
              }
          
        }

      }.padding(.horizontal).padding(.top, 25).padding(.bottom, 65)
    }
  }
}
extension RegistrationView: AuthenticationFormProtocol {
  var formIsValid: Bool{
    return !email.isEmpty
    && !fullName.isEmpty
    && email.contains("@")
    && !password.isEmpty
    && password.count >= 6
    && confirmPassword == password
    
  }
}
//#Preview {
//  RegistrationView( )
//}
struct RegistrationView_Preview: PreviewProvider {
  static var previews: some View {
    RegistrationView()
  }
}
