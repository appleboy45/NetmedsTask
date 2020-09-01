//
//  CartViewController.swift
//  NetMedsTask
//
//  Created by Vineet Singh on 31/08/20.
//  Copyright © 2020 Vineet Singh. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CartViewController: UIViewController{
    
    var viewModel: CartViewModel = CartViewModel()
    
    let tableView: UITableView = {
        
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        return tv
        
    }()
    
    let paymentView: UIView = {
       
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    
    }()
    
    let totalLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.text = "Total Amount to Pay :"
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
        return lbl
    }()
    
    let totalPriceLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.text = "₹ 0"
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.setContentHuggingPriority(UILayoutPriority.defaultLow, for: .horizontal)
        return lbl
    }()
    
    private let payBtn: UIButton = {
        
        let btn = UIButton()
        btn.setTitle("Pay", for: .normal)
        btn.backgroundColor = .green
        btn.layer.cornerRadius = 7
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override func viewDidLoad() {
        
        hideNavigationBar()
        
        initializeSetup()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.cartTableView = tableView
        viewModel.totalAmountlbl = totalPriceLbl
        
        viewModel.refreshTableView()
        
    }
    
    @objc func updateTableView(){
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    
    }
    
    func hideNavigationBar(){
        
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.navigationBar.isHidden = true
        navigationController?.navigationController?.navigationBar.isHidden = true
    }
    
    func initializeSetup() {
        
        view.addSubview(tableView)
        view.addSubview(paymentView)
        paymentView.addSubview(totalLbl)
        paymentView.addSubview(totalPriceLbl)
        paymentView.addSubview(payBtn)
        
        tableView.register(ItemListTableViewCell.self, forCellReuseIdentifier: Constants.tableViewCellIdentifier)
        tableView.dataSource = viewModel
        
        tableView.backgroundColor = AppColors.themeColor
        
        paymentView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        paymentView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        paymentView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        paymentView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: paymentView.topAnchor).isActive = true
        
        totalLbl.leftAnchor.constraint(equalTo: paymentView.leftAnchor, constant: 16).isActive = true
        totalLbl.topAnchor.constraint(equalTo: paymentView.topAnchor, constant: 16).isActive = true
        totalLbl.rightAnchor.constraint(equalTo: payBtn.leftAnchor, constant: -16).isActive = true
        
        totalPriceLbl.leftAnchor.constraint(equalTo: totalLbl.leftAnchor).isActive = true
        totalPriceLbl.rightAnchor.constraint(equalTo: totalLbl.rightAnchor, constant: 16).isActive = true
        totalPriceLbl.topAnchor.constraint(equalTo: totalLbl.bottomAnchor, constant: 16).isActive = true
        
        payBtn.rightAnchor.constraint(equalTo: paymentView.rightAnchor,constant: -16).isActive = true
        payBtn.heightAnchor.constraint(equalToConstant: 36).isActive = true
        payBtn.widthAnchor.constraint(equalToConstant: 65).isActive = true
        payBtn.topAnchor.constraint(equalTo: paymentView.topAnchor, constant: 16).isActive = true
        
        payBtn.addTarget(self, action: #selector(payBtnTapped), for: .touchUpInside)
        
    }
    
    @objc func payBtnTapped(){
        
        let vc = PaymentDetailsViewController()
        vc.totalPrice = totalPriceLbl.text
        
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
}
