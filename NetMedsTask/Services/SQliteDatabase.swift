//
//  SQliteDatabase.swift
//  NetMedsTask
//
//  Created by Vineet Singh on 01/09/20.
//  Copyright © 2020 Vineet Singh. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class SQliteDatabase: NSObject{
    
    static let shareInstance: SQliteDatabase = SQliteDatabase()
    
    func save(model: ItemListModel) {
                
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
        
        if let name = model.itemName{
            item.setValue(name, forKeyPath: "itemName")
        }
        if let price = model.minPrice{
            item.setValue(price, forKeyPath: "minPrice")
        }
        
        do {
            
            try managedContext.save()
            
        } catch let error as NSError {
            
            print("Could not save. \(error), \(error.userInfo)")
            
        }
    }
    
    func fetch(managedObjectArray: inout [NSManagedObject]){
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Item")
        
        do {
            managedObjectArray = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        
    }
    
    func delete(managedObject: NSManagedObject){
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        managedContext.delete(managedObject)
        
        print(managedContext)
        
        do {
            
            try managedContext.save()
            
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
    }
    
    
}
