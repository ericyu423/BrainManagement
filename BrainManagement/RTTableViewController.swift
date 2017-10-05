//
//  RoutineDataProvider.swift
//  BrainManagement
//
//  Created by eric yu on 5/9/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit


protocol RTTableViewControllerDelegate {
    func didTouchTable()
}


/*class RTTableViewController: UIViewController, UITableViewDelegate,UITableViewDataSource{*/
    
class RTTableViewController: UITableViewController,MainViewDelegate{
    //var pv: UIViewController?
    var delegate: RTTableViewControllerDelegate?
 
    /*
    lazy var viewController: UIViewController = {
        let vc = ViewController()
        vc.delegate = self
        
        return vc
        
    }()*/
    let headerTitle = "Routine"
   
    
   
    //fileprivate var dataArray = [RTTableViewDataModelItem]()
   // fileprivate var dataArray = ["Clean my room","1 hr writing BrainManagement","1 hour reading functional programming","1 hour leaning RESTful APIs"]
   
    
    fileprivate var dataArray = ["Clean My Room","Udemy C# With Unity","Program APP","Function Programming study","RESTful Related Programming","https://www.youtube.com/watch?v=xa93cjIeuY0","https://www.youtube.com/watch?v=XFvs6eraBXM"]
    fileprivate var dataArrayCrossOff:[Bool]? = [true,true,true,false,false]
   
    func setRoutines(routine: [String]){
        
      self.dataArray = routine
        tableView.reloadData()
    
    
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
    
  
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        
        tableView.register(RTTableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 100
        self.tableView.delegate = self
        self.tableView.dataSource = self

     
    }
}

extension RTTableViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? RTTableViewCell
        
        
        cell?.selectedView.crossOff()

        //drawIt()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
     override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //new error with update to new xcode
        
        /*
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? RTTableViewCell {
            cell.configureWithItem(item: dataArray[indexPath.item],cross: dataArrayCrossOff?[indexPath.row])
            return cell
        }*/
        
        return UITableViewCell() //unwarp failed return empty cell
    }

     override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return headerTitle
    }
 

     override func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        delegate?.didTouchTable()
    }
    
 
}


extension RTTableViewController {
    //add check box
    
   
    
    
    
}



