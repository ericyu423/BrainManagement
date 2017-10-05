//
//  TimeManagementView.swift
//  BrainManagement
//
//  Created by eric yu on 5/13/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit

class TimeManagementView: UIViewController {
    let scrollView: UIScrollView = {
        let sv = UIScrollView()
        return sv
    }()
    let contentView: UIView = {
        let cv = UIView()
        cv.backgroundColor = .orange
        return cv
    }()
    
    let button: UIButton = {
        let b = UIButton()
        return b
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

   
    
    func layouts(){
        view.addSubview(scrollView)
        scrollView.anchor(top: topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: bottomLayoutGuide.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addSubview(button)
        
        scrollView.addSubview(contentView)
        
        contentView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        
    }
}
