//
//  AuthScreen.swift
//  iosApp
//
//  Created by Наталья Кизирова on 10.07.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct AuthScreen: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    
    @State private var goToSignUp: Bool = false
    
    var body: some View {
        if goToSignUp {
            SignUpScreen(authViewModel: authViewModel, goToSignUp: $goToSignUp)
        } else{
            SignInScreen(authViewModel: authViewModel, goToSignUp: $goToSignUp)
        }
    }
}
