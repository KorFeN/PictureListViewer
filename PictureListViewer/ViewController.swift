//
//  ViewController.swift
//  PictureListViewer
//
//  Created by Ssss on 2019-02-01.
//

import UIKit

class ViewController: UIViewController {

    //MARK:Properties
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var formatLabel: UILabel!
    
    
    var picture: Picture?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //show data which was passed to View
        pictureImageView.image = picture?.photo
        authorLabel.text = picture?.author
        sizeLabel.text = picture?.size
        formatLabel.text = picture?.format
    }


}

