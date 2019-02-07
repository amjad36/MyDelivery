//
//  DeliveryNetworkController.swift
//  MyDelivery
//
//  Created by Amjad Khan on 31/01/19.
//  Copyright © 2019 Conduent. All rights reserved.
//

import Foundation

class DeliveryNetworkController {
    
    let endPoint = "/deliveries"
    
    func loadDeliveries(completion: @escaping (_ packages: [Package]?, _ error: NSError?) -> Void) {
        let networkController: NetworkController = NetworkController()
        networkController.loadRequest(urlStr: Constants.BaseUrl + endPoint) { (data: Data?, error: Error?) in
            guard let data = data else {
                completion(nil, nil)
                return
            }
            do {
                let packages = try JSONDecoder().decode([Package].self, from: data)
                completion(packages, nil)
            }
            catch {
                Logger.debugLog(error)
                completion(nil, nil)
            }
        }
    }
    
}
