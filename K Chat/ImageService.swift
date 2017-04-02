//
//  ImageService.swift
//  K Chat
//
//  Created by ភី ម៉ារ៉ាសុី on 8/17/16.
//  Copyright © 2016 ភី ម៉ារ៉ាសុី. All rights reserved.
//

import UIKit
class ImageService{
    static let imageService = ImageService()
    
    
    func convertImageToBase64(_ image: UIImage) -> String {
        
        let imageData = UIImageJPEGRepresentation(image, 0.4)
        let base64String = imageData!.base64EncodedString(options: .lineLength64Characters)
        
        return base64String
        
    }
    func convertBase64ToImage(_ base64String: String) -> UIImage {
        
        let decodedData = Data(base64Encoded: base64String, options: NSData.Base64DecodingOptions.ignoreUnknownCharacters)!
        
        let decodedimage = UIImage(data: decodedData)
        
        return decodedimage!
        
    }
    
}
