//
//  CustomTabBarController.swift
//  NetMedsTask
//
//  Created by Vineet Singh on 31/08/20.
//  Copyright © 2020 Vineet Singh. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    @objc let layerGradient = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        
        setupControllers()
    }
    
    func setupControllers(){
        
        let itemListVC = ItemListViewController()
        let cartVC = CartViewController()
        
        self.tabBar.barTintColor = .white
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], for: .normal)
        
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -20)
        
        let icon1 = UITabBarItem(title: "Items", image: nil, selectedImage: nil)
        
        let icon2 = UITabBarItem(title: "Cart", image: nil, selectedImage: nil)
        
        let navigationController1 = UINavigationController(rootViewController: itemListVC)
        let navigationController2 = UINavigationController(rootViewController: cartVC)

        navigationController1.tabBarItem = icon1
        navigationController2.tabBarItem = icon2
        
        self.viewControllers = [navigationController1, navigationController2]
        
    }
    
    override var selectedIndex: Int {
        didSet {
            
            guard let selectedViewController = self.viewControllers?[selectedIndex] else {
                return
            }
            
            selectedViewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)], for: .normal)
            
            guard let viewControllers = viewControllers else {
                return
            }

            for viewController in viewControllers {

                if viewController == selectedViewController {

                    let selected =
                        [NSAttributedString.Key.foregroundColor: UIColor.orange, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]

                    viewController.tabBarItem.setTitleTextAttributes(selected, for: .normal)

                } else {

                    let normal =
                        [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]

                    viewController.tabBarItem.setTitleTextAttributes(normal, for: .normal)

                }
            }
            
        }
    }
    
    override var selectedViewController: UIViewController? {
        didSet {

            guard let viewControllers = viewControllers else {
                return
            }

            for viewController in viewControllers {

                if viewController == selectedViewController {

                    let selected =
                        [NSAttributedString.Key.foregroundColor: UIColor.orange, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20)]

                    viewController.tabBarItem.setTitleTextAttributes(selected, for: .normal)

                } else {

                    let normal =
                        [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)]

                    viewController.tabBarItem.setTitleTextAttributes(normal, for: .normal)

                }
            }
        }
    }
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        return true;
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
}

extension UITabBar {
    
    override open func sizeThatFits(_ size: CGSize) -> CGSize {
        super.sizeThatFits(size)

        guard let window = UIApplication.shared.keyWindow else {
            var sizeThatFits = super.sizeThatFits(size)
            sizeThatFits.height = 79
            return sizeThatFits
        }
        var sizeThatFits = super.sizeThatFits(size)
        sizeThatFits.height = window.safeAreaInsets.bottom + 60
        return sizeThatFits
        
    }
}


