//
//  RTTableViewModel.swift
//  BrainManagement
//
//  Created by eric yu on 5/11/17.
//  Copyright © 2017 eric yu. All rights reserved.
//

import UIKit

protocol RTTableViewDataModelDelegate: class {
    func didRecieveDataUpdate(data: [RTTableViewDataModelItem])
    func didFailDataUpdateWithError(error: Error)
}


class RTTableViewDataModel{
    
    weak var delegate: RTTableViewDataModelDelegate?

    private func handleError(error: Error) {
        
    }
    
    
    func requestData() {
        // code to request data from API or local JSON file will go here
        
        var response: [AnyObject]?
        var error: Error?
        if let error = error {
            // handle error
        } else if let response = response {
            // parse response to [DRHTableViewDataModelItem]
            setDataWithResponse(response: response)
        }
    }
    
    private func setDataWithResponse(response: [AnyObject]) {
        var data = [RTTableViewDataModelItem]()
        for item in response {
            if let rtTableViewDataModelItem = RTTableViewDataModelItem(data: item as? [String: String]) {
                data.append(rtTableViewDataModelItem)
            }
        }
        delegate?.didRecieveDataUpdate(data: data)
        
        
    }
    
    
}
