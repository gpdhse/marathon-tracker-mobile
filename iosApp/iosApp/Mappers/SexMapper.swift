//
//  SexMapper.swift
//  iosApp
//
//  Created by Наталья Кизирова on 11.07.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import Shared

extension Sex{
    func convert() -> Shared.Sex {
        switch(self){
        case .MALE:
            return Shared.Sex.male
        case.FEMALE:
            return Shared.Sex.female
        }
    }
}
