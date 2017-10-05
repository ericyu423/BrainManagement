//
//  SettingsTableViewController.swift
//  BrainManagement
//
//  Created by eric yu on 5/12/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    let sections: [String] = ["Suggestions","Table Settings"]

    
    
    
    let setttingsArray: [[String]] = [["Message Developer"],
        
        
        [
        "Morning Routine",
        "Day Routine",
        "Evening Routie"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tableView.register(SettingsTableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        self.tableView.delegate = self
        self.tableView.dataSource = self

  
    }

}

extension SettingsTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return setttingsArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return setttingsArray[section].count
        
    }

    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        cell.textLabel?.text = setttingsArray[indexPath.section][indexPath.row]
        cell.accessoryType = .disclosureIndicator
        

        return cell
    }
}

