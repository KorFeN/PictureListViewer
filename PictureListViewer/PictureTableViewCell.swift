//
//  PictureTableViewCell.swift
//  PictureListViewer
//
//  Created by Ssss on 2019-02-01.
//

import UIKit

class PictureTableViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var formatLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
