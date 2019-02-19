//
//  RandomViewController.swift
//  PictureListViewer
//
//  Created by Ssss on 2019-02-19.
//

import UIKit
import NVActivityIndicatorView

class RandomViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var randomUIButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    static let activityData = ActivityData()
    var indicatorView: NVActivityIndicatorView!
    
    //MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    //MARK: Actions
    
}
