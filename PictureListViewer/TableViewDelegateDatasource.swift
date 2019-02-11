//
//  TableViewDelegate.swift
//  PictureListViewer
//
//  Created by Ssss on 2019-02-07.
//

import Foundation
import UIKit

class TableViewDelegateDatasource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    var pictures = [Picture]()
    
    //MARK: Initialization
    
    override init() {
        super.init()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PictureTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PictureTableViewCell else {
            fatalError("Could not cast TableViewCell to PictureTableViewCell")
        }
        
        // Configure the cell...
        let pictureObj = self.pictures[indexPath.row]
        
        //Sets placeholder image, then ASync download of image and sets it when completed
        cell.pictureImageView.image = pictureObj.photo
        API().setImage(imageView: cell.pictureImageView, picture: pictureObj)
        
        cell.authorLabel.text = pictureObj.author
        cell.sizeLabel.text = pictureObj.size
        cell.formatLabel.text = pictureObj.format
        
        return cell
    }
}


