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
    
    init(pictureJson: PictureJSON) {
        self.author = pictureJson.author
        self.format = pictureJson.format
        self.height = pictureJson.height
        self.id = pictureJson.id
        self.post_url = pictureJson.post_url
        self.width = pictureJson.width
        self.size = String(format: "%d x %d", pictureJson.width, pictureJson.height)
        
        let pic = UIImage(named: "placeHolder")
        self.photo = pic
    }
    
    
}
