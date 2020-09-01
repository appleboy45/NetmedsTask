//
//  PaymentDetailsViewController.swift
//  NetMedsTask
//
//  Created by Vineet Singh on 02/09/20.
//  Copyright © 2020 Vineet Singh. All rights reserved.
//

import Foundation
import UIKit

class PaymentDetailsViewController: UIViewController {
    
    let orderSuccessLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.text = "Payment is Successful"
        lbl.textColor = .green
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let totalPriceLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.text = "Order Amount : ₹ 0"
        lbl.textColor = .black
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var totalPrice: String?
    
    override func viewDidLoad() {
        
        initializeSetup()
        
    }
    
    func initializeSetup() {
        
        view.backgroundColor = .white
        
        view.addSubview(orderSuccessLbl)
        view.addSubview(totalPriceLbl)
        
        orderSuccessLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        orderSuccessLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16).isActive = true
        orderSuccessLbl.topAnchor.constraint(equalTo: view.topAnchor, constant: 80).isActive = true
        
        totalPriceLbl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        totalPriceLbl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 16).isActive = true
        totalPriceLbl.topAnchor.constraint(equalTo: orderSuccessLbl.bottomAnchor, constant: 50).isActive = true
        
        if let totalPrice = totalPrice{
            totalPriceLbl.text = "Order Amount : ₹ \(totalPrice)"
        }
        
    }
    
    
}
