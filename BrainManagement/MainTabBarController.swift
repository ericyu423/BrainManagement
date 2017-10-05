//
//  MainTabBarController.swift
//  BrainManagement
//
//  Created by eric yu on 5/9/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit


class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nc1: UINavigationController = {
            
            let nc = UINavigationController(rootViewController: ViewController())
              //nc.tabBarItem.selectedImage = #imageLiteral(resourceName: "eye_selected")
              nc.tabBarItem.image = #imageLiteral(resourceName: "eye_unselected")
            return nc
        }()
        
        let nc2: UINavigationController = {
            let nc = UINavigationController(rootViewController: SettingsTableViewController())
           // nc.tabBarItem.selectedImage = #imageLiteral(resourceName: "graph_selected")
            nc.tabBarItem.image  = #imageLiteral(resourceName: "graph_uneslected")
            
            return nc
        }()
        
             let nc3: UINavigationController = {
                let nc = UINavigationController(rootViewController: SettingsTableViewController(style: UITableViewStyle.grouped))
            //nc.tabBarItem.selectedImage = #imageLiteral(resourceName: "gear_selected")
            nc.tabBarItem.image  = #imageLiteral(resourceName: "gear_unselected")
        
            return nc
        }()
        
  
        
        tabBar.tintColor = .black
        
        viewControllers = [nc1,nc2,nc3]
   
        
    }
    
}
