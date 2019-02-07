//
//  DeliveryTableView.swift
//  MyDelivery
//
//  Created by Amjad Khan on 31/01/19.
//  Copyright © 2019 Conduent. All rights reserved.
//

import UIKit

class DeliveryTableView: UITableView {

    var dataArray = [Package]()
    var selectedPackage: ((Package) -> Void)?
    
    // MARK: - Initializers
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        initialize()
    }
    
    func initialize() {
        
        //
        // Remove empty cells
        tableFooterView = UIView()
        
        //
        // Assigning delegates
        contentInset = UIEdgeInsets(top: 12, left: 0, bottom: 0, right: 0)
        separatorStyle = .none
        dataSource = self
        delegate = self
    }
}

extension DeliveryTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let package = dataArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: package.representingCell, for: indexPath) as! DeliveryTableViewCell
        cell.configureWithData(package: package)
        return cell
    }
}

extension DeliveryTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedPackage?(dataArray[indexPath.row])
    }
}
