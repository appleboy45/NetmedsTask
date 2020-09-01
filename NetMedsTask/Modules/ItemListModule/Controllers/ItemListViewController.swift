//
//  ItemListViewController.swift
//  NetMedsTask
//
//  Created by Vineet Singh on 31/08/20.
//  Copyright © 2020 Vineet Singh. All rights reserved.
//

import UIKit

class ItemListViewController: UIViewController {
    
    var viewModel = ItemListViewModel()
        
    var tableView: UITableView = {
        
        var tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.backgroundColor = .clear
        return tv
        
    }()
    
    var searchBar:UISearchBar = {
        let srch = UISearchBar()
        srch.placeholder = "Search"
        return srch
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeSetup()
        
        setupSearchBar()
        
        callAPI()
        
        hideNavigationBar()
        
    }
    
    func hideNavigationBar(){
        
        navigationController?.navigationController?.navigationBar.isHidden = true
        navigationController?.setToolbarHidden(true, animated: false)
        navigationController?.navigationBar.isHidden = true
    }
    
    func setupSearchBar(){
        searchBar.frame =  CGRect(x: 0, y: 0, width: view.bounds.width - 44.0, height: 44.0)
        searchBar.delegate = self
        searchBar.barTintColor = UIColor.white
        searchBar.tintColor = UIColor.white
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "Search"
        
        if #available(iOS 13, *){
            searchBar.searchTextField.backgroundColor = .white
            searchBar.searchTextField.textColor = .black
        }
        
        tableView.tableHeaderView = searchBar
    }
    
    func callAPI(){
        
        viewModel.fetchItemList { [weak self] models in
            DispatchQueue.main.async {
                self?.updateUI()
            }
        }
    }
    
    func updateUI() {
        tableView.reloadData()
    }
    
    func initializeSetup() {
        
        view.addSubview(tableView)
        
        tableView.register(ItemListTableViewCell.self, forCellReuseIdentifier: Constants.tableViewCellIdentifier)
        tableView.dataSource = viewModel
        
        tableView.backgroundColor = AppColors.themeColor
        
        tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        
    }
    
}

extension ItemListViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        self.tableView.setContentOffset(CGPoint(x: 0, y: 44), animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        viewModel.isSearching = false
        self.tableView.reloadData()
        self.tableView.setContentOffset(CGPoint(x: 0, y: 44), animated: true)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        //reloading here
        if searchBar.text == nil || searchBar.text == ""{
            viewModel.isSearching = false
            searchBar.setShowsCancelButton(false, animated: true)
            view.endEditing(true)
            self.tableView.reloadData()
            self.tableView.setContentOffset(CGPoint(x: 0, y: 44), animated: true)
            return
        }
        else {
            viewModel.isSearching = true
            viewModel.filterData = viewModel.models.filter({
                return ($0.itemName?.localizedCaseInsensitiveContains(searchText))!})
            self.tableView.reloadData()
        }
    }
}
