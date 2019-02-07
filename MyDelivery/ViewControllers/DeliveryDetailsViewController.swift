//
//  DeliveryDetailsViewController.swift
//  MyDelivery
//
//  Created by Amjad Khan on 31/01/19.
//  Copyright © 2019 Conduent. All rights reserved.
//

import UIKit
import MapKit

class DeliveryDetailsViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var packageNameLabel: UILabel!
    @IBOutlet weak var packageImageView: UIImageView!
    
    var package: Package?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Delivery Details"
        
        addAnnotationOnMap()
        configureUI()
    }
    
    func addAnnotationOnMap() {
        
        guard let latitudeVal = package?.location.latitude, let longitudeVal = package?.location.longitude else {
            print("Not found latitude and longitude")
            return
        }
        
        // Create center
        let lattitude: CLLocationDegrees = latitudeVal
        let longitude: CLLocationDegrees = longitudeVal
        let location = CLLocationCoordinate2D(latitude: lattitude, longitude: longitude)
        
        // Zoom to location
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 200, longitudinalMeters: 200)
        mapView.setRegion(region, animated: true)
        
        // Add annotation on map
        let deliveryAnnotation = DeliveryAnnotation(title: package?.location.address, subtitle: nil, coordinate: location)
        mapView.addAnnotation(deliveryAnnotation)
    }
    
    func configureUI() {
        
        guard let description = package?.description, let address = package?.location.address else {
            return
        }
        self.packageNameLabel.text = description + " at " + address
        
        if let imageUrl = package?.imageUrl {
            self.packageImageView.contentMode = .scaleToFill
            self.packageImageView.loadImageUsingCacheWithURLString(imageUrl, placeHolder: UIImage(named: "package")) { (loadImageStatus) in
            }
        }
    }

}
