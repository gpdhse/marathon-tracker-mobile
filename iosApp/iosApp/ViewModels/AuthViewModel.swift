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
    
    func signIn(email: String, password: String) async {
        let token = try? await repository.signIn(email:email, password:password, deviceId:platform.deviceId)
        accessToken = token?.accessToken ?? ""
        if let refreshToken = token?.refreshToken{
            KeychainHelper.shared.save(refreshToken.data(using: .utf8) ?? Data(), service: "refresh_token", account: "account")
        }
        await authenticate()
    }
    
    func signUp(email: String, name: String, age:Int, sex: Sex, height: Int, weight: Int, phone: String, password: String) async {
        let token = try? await repository.signUp(email: email, name: name, age: Int32(age), sex: sex.convert(), height: Int32(height), weight: Int32(weight), phone: phone, password: password, deviceId: platform.deviceId)
        accessToken = token?.accessToken ?? ""
        if let refreshToken = token?.refreshToken{
            KeychainHelper.shared.save(refreshToken.data(using:.utf8) ?? Data(), service: "refresh_token", account: "account")
        }
        await authenticate()
    }
    
    func authenticate() async {
        user = try? await repository.authenticate(accessToken: accessToken)
        if user != nil {
            isAuthenticated = true
        } else {
            isAuthenticated = false
        }
    }
    
    func refresh() async {
        if let refreshToken = String(data:KeychainHelper.shared.read(service: "refresh_token", account: "account") ?? Data(), encoding: .utf8) {
            let token = try? await repository.refresh(refreshToken: refreshToken)
            user = try? await repository.authenticate(accessToken: token?.accessToken ?? "")
        }
        await authenticate()
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
