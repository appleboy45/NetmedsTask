//
//  ItemListTableViewCell.swift
//  NetMedsTask
//
//  Created by Vineet Singh on 31/08/20.
//  Copyright © 2020 Vineet Singh. All rights reserved.
//

import UIKit
import CoreData

class ItemListTableViewCell: UITableViewCell {
    
    var index: IndexPath?
    
    var cellDelegate: TableViewCellAddToCart?
    
    var deleteFromCartCellDelegate: TableViewCellDeleteFromCart?
    
    var isCartCell: Bool = false
    
    private let itemNameLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.text = ""
        lbl.numberOfLines = 0
        lbl.textColor = .black
        lbl.font = UIFont.boldSystemFont(ofSize: 16)
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    private let itemPriceLbl: UILabel = {
        
        let lbl = UILabel()
        lbl.text = ""
        lbl.textColor = .black
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    private let addToCartBtn: UIButton = {
        
        let btn = UIButton()
        btn.setTitle("Add to Cart", for: .normal)
        btn.backgroundColor = .orange
        btn.layer.cornerRadius = 7
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(itemNameLbl)
        addSubview(itemPriceLbl)
        addSubview(addToCartBtn)
        
        //itemNameLbl Constraint
        itemNameLbl.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        itemNameLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 16).isActive = true
        itemNameLbl.rightAnchor.constraint(equalTo: self.addToCartBtn.leftAnchor, constant: -16).isActive = true
        
        itemPriceLbl.leftAnchor.constraint(equalTo: self.itemNameLbl.leftAnchor).isActive = true
        itemPriceLbl.rightAnchor.constraint(equalTo: self.itemNameLbl.rightAnchor, constant: 16).isActive = true
        itemPriceLbl.topAnchor.constraint(equalTo: self.itemNameLbl.bottomAnchor, constant: 16).isActive = true
        itemPriceLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true

        addToCartBtn.rightAnchor.constraint(equalTo: self.rightAnchor,constant: -16).isActive = true
        addToCartBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addToCartBtn.widthAnchor.constraint(equalToConstant: 120).isActive = true
        addToCartBtn.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addToCartBtn.addTarget(self, action: #selector(addToCartTapped), for: .touchUpInside)
        
    }
    
    func setupUIForCart(){
        
        addToCartBtn.setTitle("Delete", for: .normal)
        addToCartBtn.backgroundColor = .red
        
    }
    
    @objc func addToCartTapped(){
        
        if isCartCell{
            if let row = index?.row{
                deleteFromCartCellDelegate?.deleteFromCartTapped(index: row)
            }
        }
        else if let row = index?.row{
            cellDelegate?.addToCartTapped(index: row)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateDataWithModel(_ model:ItemListModel?) {
        itemNameLbl.text = model?.itemName ?? ""
        if let price = model?.minPrice{
            itemPriceLbl.text = "₹ \(price)"
        }
        
    }
    
    func updateDataWithSQlite(_ managedObject:NSManagedObject) {
        itemNameLbl.text = managedObject.value(forKeyPath: "itemName") as? String
        if let price = managedObject.value(forKeyPath: "minPrice") as? Double{
            itemPriceLbl.text = "₹ \(price)"
        }
        
    }
    
}
