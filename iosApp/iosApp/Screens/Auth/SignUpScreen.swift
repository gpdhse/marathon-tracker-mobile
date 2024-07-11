//
//  SignUpScreen.swift
//  iosApp
//
//  Created by Наталья Кизирова on 10.07.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import Combine

struct SignUpScreen: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    
    @State private var email: String = ""
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var age: String = ""
    @State private var sex: Sex = .MALE
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var phone: String = ""
    
    @Binding var goToSignUp: Bool
    
    var body: some View {
        VStack {
            List {
                TextField("Email", text: $email)
                    .autocorrectionDisabled()
                
                TextField("Email", text: $name)
                    .keyboardType(.namePhonePad)
                
                TextField("Age", text: $age)
                    .keyboardType(.numberPad)
                    .onReceive(Just(age)) { newValue in
                        filterNumbers(newValue) { filtered in
                            self.age = filtered
                        }
                    }
                
                Picker(selection: $sex){
                    Text("Male").tag(Sex.MALE)
                    Text("Female").tag(Sex.FEMALE)
                } label: {
                    Text("Sex")
                        .foregroundStyle(.foreground)
                }.pickerStyle(.segmented)
                
                TextField("Height", text: $height)
                    .keyboardType(.numberPad)
                    .onReceive(Just(height)) { newValue in
                        filterNumbers(newValue) { filtered in
                            self.height = filtered
                        }
                    }
                
                TextField("Weight", text: $weight)
                    .keyboardType(.numberPad)
                    .onReceive(Just(weight)) { newValue in
                        filterNumbers(newValue) { filtered in
                            self.weight = filtered
                        }
                    }
                
                TextField("Email", text: $phone)
                    .keyboardType(.phonePad)
                
                SecureField("Password", text: $password)
                    .autocorrectionDisabled()
                Button("Sign up"){
                    Task {
                        await authViewModel.signUp(email:email, name:name, age:Int(age) ?? 0, sex: sex, height:Int(height) ?? 0, weight:Int(weight) ?? 0, phone:phone, password:password)
                    }
                }
                
                Button{
                    withAnimation{
                        goToSignUp.toggle()
                    }
                } label: {
                    Text("Go to sign in")
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        }
    }
    
    func filterNumbers(_ str: String, action: (String) -> Void){
        let filtered = str.filter { "0123456789".contains($0) }
        if filtered != str {
            action(filtered)
        }
    }
}
