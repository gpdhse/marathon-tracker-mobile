//
//  Coordinates.swift
//  iosApp
//
//  Created by Наталья Кизирова on 12.07.2024.
//  Copyright © 2024 orgName. All rights reserved.
//

import Foundation
import CoreLocation

extension CLLocationCoordinate2D
{

    public var description : String
    {
        return "\(self.latitude);\(self.longitude)"
    }
}
