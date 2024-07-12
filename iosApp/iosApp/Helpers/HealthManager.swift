//
//  HealthManager.swift
//  iosApp
//
//  Created by Наталья Кизирова on 11.07.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import HealthKit

extension Date{
    static var startOfDay: Date {
        Calendar.current.startOfDay(for: Date())
    }
}

final class HealthManager: ObservableObject{
    
    let healthStore = HKHealthStore()
    let heartRateQuantity = HKUnit(from: "count/min")
    
    static let shared = HealthManager()
    
    @Published var value: Int = 0
    
    init(){
        let steps = HKQuantityType(.heartRate)
        let healthTypes: Set = [steps]
        Task {
            do {
                try await healthStore.requestAuthorization(toShare: [], read: healthTypes)
            } catch {
                print("error fetching health data")
            }
        }
    }
    
    func startHeartRateQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
        let watchPredicate = HKQuery.predicateForObjects(withDeviceProperty: HKDevicePropertyKeyModel, allowedValues: ["Watch"])
        
        let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
            query, samples, deletedObjects, queryAnchor, error in
            
            guard let samples = samples as? [HKQuantitySample] else {
                return
            }
            
            self.process(samples, type: quantityTypeIdentifier)
            
        }
        
        let query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!, predicate: watchPredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
        
        query.updateHandler = updateHandler
        
        healthStore.execute(query)
    }
    
    private func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
            var lastHeartRate = 0.0
            
            for sample in samples {
                if type == .heartRate {
                    lastHeartRate = sample.quantity.doubleValue(for: heartRateQuantity)
                }
                
                self.value = Int(lastHeartRate)
            }
        }
    
}
