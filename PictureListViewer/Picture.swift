//
//  picture.swift
//  PictureListViewer
//
//  Created by Ssss on 2019-02-01.
//

import UIKit

class Picture {
    
    //MARK: Properties
    var photo: UIImage
    var author: String?
    var size: String
    var format: String
    
    
    //MARK: Initialization
    
    init?(photo: UIImage, author: String?, size: String, format: String) {
        
        //Make sure there is an image, otherwise return nil
        guard photo.size.width > 0 else {
            return nil
        }
        
        guard !size.isEmpty else {
            return nil
        }
        
        guard !format.isEmpty else {
            return nil
        }
        
        self.photo = photo
        self.author = author
        self.size = size
        self.format = format
        
    }
    
    
}
