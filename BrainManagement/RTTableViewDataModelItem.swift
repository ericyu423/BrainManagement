//
//  RTTableViewDataModelItem.swift
//  BrainManagement
//
//  Created by eric yu on 5/11/17.
//  Copyright © 2017 eric yu. All rights reserved.
//
import Foundation

//TODO: this should be struct

class RTTableViewDataModelItem {
    //more be added
    var label: String?
    var avatarImageURL: String?
    var authorName: String?
    var date: String?
    var title: String?
    var previewText: String?
    
    init?(data: [String: String]?) {
        if let data = data,let avatar = data["avatarImageURL"],let name = data["authorName"],let date = data["date"],let title = data["title"],let previewText = data["previewText"] {
            // self.avatarImageURL = avatar
            //self.authorName = name
            // self.date = date
            self.label = title
            // self.previewText = previewText
        } else {
            return nil
        }
    }
}
