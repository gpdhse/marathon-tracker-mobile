//
//  MarathonViewModel.swift
//  iosApp
//
//  Created by Наталья Кизирова on 12.07.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import Shared
import CoreLocation

final class MarathonViewModel : ObservableObject {
    
    let marathonRepository: Shared.MarathonSocketRepository
    
    private var userId = ""
    
    init(repository: Shared.MarathonSocketRepository){
        marathonRepository = repository
    }
    
    func initSession(userId: String) {
        self.userId = userId
        Task{
            try await marathonRepository.doInitSession(userId: self.userId)
        }
    }
    
    func sendStatus(location: CLLocationCoordinate2D, pulse: Int){
        Task {
            try await marathonRepository.sendStatus(healthStatus:HealthStatus(userId: userId, pulse: Int32(pulse), longitude:Double(location.longitude), latitude: Double(location.latitude)))
        }
    }
    
    func disconnect(){
        Task{
            try await marathonRepository.closeSession()
        }
    }
    
    func sos(){
        Task{
            try await marathonRepository.sos()
        }
    }
    
}

extension MarathonViewModel {
    static func create() -> MarathonViewModel{
        MarathonViewModel(repository: createMarathonSocketRepository())
    }
}

func createMarathonSocketRepository() -> MarathonSocketRepository{
    MarathonSocketRepositoryImpl(marathonSocketService: createMarathonSockerService())
}

func createMarathonSockerService() -> MarathonSocketService{
    KtorMarathonSocketService(client: CreateHttpClientKt.createHttpClient())
}
