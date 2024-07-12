//
//  SignInScreen.swift
//  iosApp
//
//  Created by Наталья Кизирова on 10.07.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct SignInScreen: View{
    
    @ObservedObject var authViewModel: AuthViewModel
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @Binding var goToSignUp: Bool
    
    var body: some View {
        VStack {
            List {
                TextField("Email", text: $email)
                SecureField("Password", text: $password)
                Button("Sign in"){
                    authViewModel.signIn(email:email, password:password)
                }
                
                Button{
                    withAnimation{
                        goToSignUp.toggle()
                    }
                } label:{
                    Text("Go to sign up")
                }
            }
        }
    }
}
