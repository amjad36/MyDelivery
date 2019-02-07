//
//  Package.swift
//  MyDelivery
//
//  Created by Amjad Khan on 31/01/19.
//  Copyright © 2019 Conduent. All rights reserved.
//

import Foundation

struct Location: Codable {
    let latitude: Double
    let longitude: Double
    let address: String
    
    enum CodingKeys: String, CodingKey {
        case latitude = "lat"
        case longitude = "lng"
        case address
    }
}

struct Package: Codable {
    let id: Int
    let description: String
    let imageUrl: String
    let location: Location
}

extension Package: RepresentingCell {
    var representingCell: String {
        return "DeliveryTableViewCell"
    }
}

