//
//  RTTableViewCell.swift
//  BrainManagement
//
//  Created by eric yu on 5/11/17.
//  Copyright © 2017 eric yu. All rights reserved.
//
import UIKit

class RTTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
        
       // self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        
        fatalError("init(coder:) has not been implemented")
    }
    
   var routineLabel:UILabel! = {
        var label = UILabel()
        //label.text = "test"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var selectedButton: UIButton! = {
        let button = UIButton()
        
        button.setTitle("Done", for: UIControlState.normal)
        
        return button
    }()
    
    var selectedView: LineView! = {
        let sv = LineView()
        sv.backgroundColor = .clear
   
        return sv
    }()
    
    
   
    
    

    func configureWithItem(item: String, cross: Bool?){
        
        self.routineLabel.text = item
        
        if cross == true {
            self.selectedView.crossOff()
        }
        
    }
    
    func layout(){
        self.addSubview(routineLabel)
        routineLabel.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 10, paddingBottom: 12, paddingRight: bounds.width * 1/5, width: 0, height: 0)
        
        self.addSubview(selectedView)
        
        selectedView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 10, paddingBottom: 12, paddingRight: 10, width: 0, height: 0)
        
        
       
    }
}


