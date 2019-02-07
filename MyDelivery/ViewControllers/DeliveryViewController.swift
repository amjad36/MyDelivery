//
//  ViewController.swift
//  MyDelivery
//
//  Created by Amjad Khan on 31/01/19.
//  Copyright © 2019 Conduent. All rights reserved.
//

import UIKit
import SVProgressHUD

class DeliveryViewController: UIViewController {

    @IBOutlet weak var tableView: DeliveryTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getData()
    }
    
    func getData() {
        
        let deliveryNetworkController = DeliveryNetworkController()
        SVProgressHUD.show()
        deliveryNetworkController.loadDeliveries { (packages, error) in
            SVProgressHUD.dismiss()
            guard let packages = packages else { return }
            self.tableView.dataArray = packages
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DeliveryDetailsViewController {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                destination.package = self.tableView.dataArray[indexPath.row]
            }
        }
    }
    
}

