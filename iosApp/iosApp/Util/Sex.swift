//
//  Sex.swift
//  iosApp
//
//  Created by Наталья Кизирова on 11.07.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation

enum Sex: String, CaseIterable, Identifiable {
    case MALE, FEMALE
    var id: Self { self }
}
