//
//  ItemListViewModel.swift
//  NetMedsTask
//
//  Created by Vineet Singh on 31/08/20.
//  Copyright © 2020 Vineet Singh. All rights reserved.
//

import Foundation
import UIKit

protocol TableViewCellAddToCart {

    func addToCartTapped(index: Int)
}

class ItemListViewModel: NSObject {

    var models: [ItemListModel] = [ItemListModel]()
    var filterData: [ItemListModel] = [ItemListModel]()
    
    var isSearching:Bool = false
    
    init(model: [ItemListModel]? = nil) {
        if let inputModel = model {
            models = inputModel
        }
    }
    
}

extension ItemListViewModel {
    
    func fetchItemList(completion: @escaping (Result<[ItemListModel], Error>) -> Void) {
        NetworkManager.shared.get(urlString: APIClient().itemListURL, completionBlock: { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .failure(let error):
                print ("failure", error)
            case .success(let dta) :
                
                let decoder = JSONDecoder()
                do
                {
                    self.models = try decoder.decode([ItemListModel].self, from: dta)
                    completion(.success(try decoder.decode([ItemListModel].self, from: dta)))
                } catch let error{
                    print(error)
                }
            }
        })
    }
}

extension ItemListViewModel:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return isSearching ? filterData.count : models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier, for: indexPath) as? ItemListTableViewCell
        
        cell?.selectionStyle = .none
        
        let model = isSearching ? filterData[indexPath.row] : models[indexPath.row]
        
        cell?.cellDelegate = self
        cell?.index = indexPath
        
        cell?.updateDataWithModel(model)
        
        return cell ?? UITableViewCell()
    }
    
}

extension ItemListViewModel: TableViewCellAddToCart{
    
    func addToCartTapped(index: Int) {
        
        let model = models[index]
        
        SQliteDatabase.shareInstance.save(model: model)
        
        
    }
    
}
