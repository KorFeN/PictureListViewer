//
//  PictureJSON.swift
//  PictureListViewer
//
//  Created by Ssss on 2019-02-03.
//

import Foundation

struct PictureJSON : Codable {
    
    //MARK: Json members
    
    var author: String
    var format: String
    var id: Int
    var post_url: String
    var height: Int
    var width: Int
}
