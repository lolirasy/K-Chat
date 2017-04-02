//
//  AlertService.swift
//  Khmer-Social News
//
//  Created by ភី ម៉ារ៉ាសុី on 8/1/16.
//  Copyright © 2016 ភី ម៉ារ៉ាសុី. All rights reserved.
//

import UIKit

class AlertService: NSObject {
    static let alertService = AlertService()
    func errorAlert(_ title: String, message: String) -> UIAlertController {
        
        // Called upon login error to let the user know login didn't work.
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        return alert
    }
    
    
    
   
    func okCancelAlert(_ title: String, message: String)-> UIAlertController{
        
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: {
            
            (ACTION: UIAlertAction) in
            
            
    
        
        })
        let action2 = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(action2)
        return alert

    }
    
    
    
    
}
