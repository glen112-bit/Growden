//
//  LoginView.swift
//  Growden
//
//  Created by Glen on 22-01-25.
//

import SwiftUI

struct LoginView: View {
  @State private var email = ""
  @State private var password = ""
  @EnvironmentObject var viewModel: AuthViewModel
  
    var body: some View {
      NavigationStack{
        VStack{
//          image
          Image("logo").resizable().scaledToFill().frame(width: 150, height: 150).cornerRadius(15).padding(.top, 25)
          
//          form filds
          VStack(spacing: 24){
            InputView(text: $email, title: "Email Adress", placeholder: "Email@example.com").autocapitalization(.none)
            
            InputView(text: $password, title: "Password", placeholder: "password",
                      isSecureField: true)
          }.padding(.horizontal).padding(.top, 25).padding(.bottom, 65)
          
//          sign in button
          Spacer()
          Button{
            Task {
              try await viewModel.signIn(email: email, password: password)
            }
//            print("Sign In")
          } label: {
            HStack {
              Text("Sign In").font(.headline).foregroundColor(.white).fontWeight(.semibold)
              Image(systemName: "chevron.right")
              }
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
              
          }
          .background(Color.blue)
          .disabled(!formIsValid)
          .opacity(formIsValid ? 1.0 : 0.5)
          .cornerRadius(18)
          .padding()
          Spacer()
//          sign out button
          NavigationLink {
            RegistrationView()
              .navigationBarBackButtonHidden(true)
            } label: {
              HStack(spacing: 3){
                Text("Dont have acount")
                Text("Sign Up").fontWeight(.bold)
              }
          }
          
        }
      }.background(.gray.opacity(0.4))
    }
}

extension LoginView: AuthenticationFormProtocol {
  var formIsValid: Bool{
    return !email.isEmpty
    && email.contains("@")
    && !password.isEmpty
    && password.count >= 6
  }
}


#Preview {
    LoginView()
}
