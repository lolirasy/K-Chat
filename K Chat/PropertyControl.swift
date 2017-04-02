//
//  PropertyControl.swift
//  Khmer-Social News
//
//  Created by ភី ម៉ារ៉ាសុី on 8/5/16.
//  Copyright © 2016 ភី ម៉ារ៉ាសុី. All rights reserved.
//

import UIKit
class PropertyControl {
   static let propertyControl = PropertyControl()
    
    func setButton(_ Button: [UIButton]){
        
        for button in Button {
            button.backgroundColor = UIColor.clear
            button.layer.cornerRadius = button.frame.size.height / 2
            button.layer.masksToBounds = true
            button.layer.borderWidth = 1
            
            //  button.titleLabel?.backgroundColor = UIColor.clearColor()
            button.layer.borderColor = UIColor.white.cgColor
            
        }

        
    }
    func setImage(_ image: UIImageView){
        image.layer.cornerRadius = image.frame.size.height / 2
        image.layer.masksToBounds = true
        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    
    func setTextFeild(_ TextField: [UITextField]){
        //  textField.backgroundColor = UIColor.whiteColor()
        for textField in TextField {
        
        
        
        textField.textColor = UIColor.white
        textField.adjustsFontSizeToFitWidth = true
        textField.layer.cornerRadius = textField.frame.size.height / 2
        textField.layer.masksToBounds = true
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.white.cgColor
            
        
        }
    }
    

    
    
    
}
