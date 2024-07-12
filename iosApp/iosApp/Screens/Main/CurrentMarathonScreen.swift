//
//  CurrentMarathonScreen.swift
//  iosApp
//
//  Created by Наталья Кизирова on 12.07.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import SwiftUI
import HealthKit

struct CurrentMarathonScreen: View {
    @ObservedObject var healthManager = HealthManager.shared
    @ObservedObject var locationManager = LocationManager.shared

    @ObservedObject var authViewModel: AuthViewModel
    
    @ObservedObject var viewModel = MarathonViewModel.create()
    
    @Binding var joinedMarathon: Bool
    
    var body: some View {
        VStack{
            List{
                HStack{
                    Text("Current pulse")
                        .font(.title)
                    Spacer()
                    Text(String(healthManager.value))
                        .font(.headline)
                }
                
                HStack{
                    Text("Current location")
                        .font(.title)
                    Spacer()
                    Text(String(locationManager.userLocation?.coordinate.description ?? "No location"))
                        .font(.headline)
                }
            }
            Button{
                viewModel.sos()
            } label: {
                Text("SOS")
            }
            
            Button{
                viewModel.disconnect()
                joinedMarathon.toggle()
            } label:{
                Text("Disconnect")
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear{
            guard let id = authViewModel.user?.id else { return }
            viewModel.initSession(userId: id)
            
            let _ = healthManager.$value.sink { value in
                guard let coordinate = locationManager.userLocation?.coordinate else { return }
                viewModel.sendStatus(location: coordinate, pulse: value)
            }
            
            let _ = locationManager.$userLocation.sink { value in
                guard let value = value else { return }
                viewModel.sendStatus(location: value.coordinate, pulse: healthManager.value)
            }
        }
    }
}
