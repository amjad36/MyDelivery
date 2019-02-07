//
//  DeliveryAnnotation.swift
//  MyDelivery
//
//  Created by Amjad Khan on 07/02/19.
//  Copyright © 2019 Conduent. All rights reserved.
//

import Foundation
import MapKit

class DeliveryAnnotation: NSObject, MKAnnotation {
    
    var title: String?
    var subtitle: String?
    var coordinate: CLLocationCoordinate2D
    
    init(title: String?, subtitle: String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.subtitle = subtitle
        self.coordinate = coordinate
    }
}
