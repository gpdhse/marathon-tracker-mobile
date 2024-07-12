//
//  MainView.swift
//  iosApp
//
//  Created by Наталья Кизирова on 11.07.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI

struct MainScreen: View {
    
    @ObservedObject var authViewModel: AuthViewModel
    
    @State private var joinedMarathon = false
    
    var body: some View {
        if joinedMarathon {
            CurrentMarathonScreen(authViewModel: authViewModel, joinedMarathon: $joinedMarathon)
        } else {
            Button {
                joinedMarathon.toggle()
            } label: {
                Text("Join marathon")
            }
        }
    }
    
    
}
