//
//  AuthViewModel.swift
//  iosApp
//
//  Created by Наталья Кизирова on 11.07.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import Shared

final class AuthViewModel : ObservableObject {
    
    private let repository: AuthRepository
    
    private let platform = Shared.IOSPlatform()
    
    @Published private(set) var user: User? = nil
    
    @AppStorage("access_token") var accessToken: String = ""
    
    @AppStorage("is_authenticated") var isAuthenticated: Bool = false
    
    init(repository: AuthRepository){
        self.repository = repository
    }
    
    func signIn(email: String, password: String) {
        Task{
            if let token = try? await repository.signIn(email:email, password:password, deviceId:platform.deviceId){
                
                await MainActor.run {
                    self.accessToken = token.accessToken
                    
                    KeychainHelper.shared.save(token.refreshToken.data(using: .utf8) ?? Data(), service: "refresh_token", account: "account")
                }
                
                authenticate()
            }
        }
    }
    
    func signUp(email: String, name: String, age:Int, sex: Sex, height: Int, weight: Int, phone: String, password: String) {
        Task{
            if let token = try? await repository.signUp(email: email, name: name, age: Int32(age), sex: sex.convert(), height: Int32(height), weight: Int32(weight), phone: phone, password: password, deviceId: platform.deviceId) {
                
                await MainActor.run {
                    self.accessToken = token.accessToken
                    
                    KeychainHelper.shared.save(token.refreshToken.data(using:.utf8) ?? Data(), service: "refresh_token", account: "account")
                }
                
                print(accessToken)
                authenticate()
            }
        }
    }
    
    func authenticate() {
        let accessToken = self.accessToken
        print(accessToken)
        print(isAuthenticated)
        Task{
            let user = try? await repository.authenticate(accessToken: accessToken)
            
            print(user ?? "")
            
            await MainActor.run {
                self.user = user
            }
            
            await MainActor.run{
                if self.user != nil {
                    isAuthenticated = true
                } else {
                    isAuthenticated = false
                }
            }
        }
    }
    
    func refresh() {
        Task{
            if let refreshToken = String(data:KeychainHelper.shared.read(service: "refresh_token", account: "account") ?? Data(), encoding: .utf8) {
                if let token = try? await repository.refresh(refreshToken: refreshToken){
                    await MainActor.run{
                        self.accessToken = token.accessToken
                        
                        KeychainHelper.shared.save(token.refreshToken.data(using: .utf8) ?? Data(), service: "service", account: "account")
                    }
                    authenticate()
                }
            }
        }
    }
    
}

extension AuthViewModel {
    static func create() -> AuthViewModel {
        AuthViewModel(repository: createAuthRepository())
    }
}

func createAuthRepository() -> AuthRepository{
    AuthRepositoryImpl(authService: createAuthService())
}

func createAuthService() -> AuthService{
    KtorAuthService(client: CreateHttpClientKt.createHttpClient())
}
