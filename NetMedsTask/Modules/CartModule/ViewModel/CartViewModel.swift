//
//  CartViewModel.swift
//  NetMedsTask
//
//  Created by Vineet Singh on 31/08/20.
//  Copyright © 2020 Vineet Singh. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol TableViewCellDeleteFromCart {

    func deleteFromCartTapped(index: Int)
}

class CartViewModel: NSObject, TableViewCellDeleteFromCart {
    
    var itemsStored: [NSManagedObject] = [NSManagedObject]()
    
    var cartTableView: UITableView?
    
    var totalAmountlbl: UILabel?
    
    func deleteFromCartTapped(index: Int) {
        
        let managedObject = itemsStored[index]
        
        SQliteDatabase.shareInstance.delete(managedObject: managedObject)
        
        refreshTableView()
        
    }
    
    func refreshTableView(){
        
        SQliteDatabase.shareInstance.fetch(managedObjectArray: &itemsStored)
        
        calculateTotalAmount()
        
        cartTableView?.reloadData()
        
    }
    
    func calculateTotalAmount(){
        
        var totalPrice: Double = 0
        
        for i in itemsStored{
            
            if let price = i.value(forKey: "minPrice") as? Double{
                
                totalPrice += price
                
            }
            
        }
        
        totalAmountlbl?.text = "₹ \(totalPrice)"
        
    }
    
}

extension CartViewModel: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsStored.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier, for: indexPath) as? ItemListTableViewCell
        
        cell?.selectionStyle = .none
        
        let managedObject = itemsStored[indexPath.row]
        
        cell?.deleteFromCartCellDelegate = self
        
        cell?.index = indexPath
        
        cell?.isCartCell = true
        
        cell?.setupUIForCart()
        
        cell?.updateDataWithSQlite(managedObject)
        
        return cell ?? UITableViewCell()

    }
    
    
}

extension CartViewModel{
    
    func save(name: String) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let entity =
            NSEntityDescription.entity(forEntityName: "Item",
                                       in: managedContext)!
        
        let item = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
        
        item.setValue(name, forKeyPath: "itemName")
        
        do {
            
            try managedContext.save()
            itemsStored.append(item)
            
        } catch let error as NSError {
            
            print("Could not save. \(error), \(error.userInfo)")
            
        }
    }
    
    
}
