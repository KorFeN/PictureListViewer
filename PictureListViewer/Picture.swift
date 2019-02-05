//
//  picture.swift
//  PictureListViewer
//
//  Created by Ssss on 2019-02-01.
//

import UIKit
import Foundation

struct Picture {
    
    //MARK: Properties
    var photo: UIImage?
    var author: String?
    var size: String?
    var format: String?
    var id: Int?
    var post_url: String?
    var height: Int?
    var width: Int?
    
    
    
    
    //MARK: Initialization
    
    init?(photo: UIImage, author: String?, size: String, format: String, id: Int) {
        
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
        
        self.id = id
        self.photo = photo
        self.author = author
        self.size = size
        self.format = format
        
    }
    
    init(pictureJson: PictureJSON) {
        self.author = pictureJson.author
        self.format = pictureJson.format
        self.height = pictureJson.height
        self.id = pictureJson.id
        self.post_url = pictureJson.post_url
        self.width = pictureJson.width
        self.size = "\(String(describing: self.width)) x \(String(describing: self.height))"
    }
    
    
}
