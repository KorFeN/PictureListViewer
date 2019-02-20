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
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!
    @IBOutlet var imageTapRecogniser: UITapGestureRecognizer!
    
    static let activityData = ActivityData(type: NVActivityIndicatorType.ballRotateChase)
    
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
    @IBAction func imageTapped(_ sender: UITapGestureRecognizer) {
        //CODE FOR WHEN IMAGE GETS TAPPED
    }
    
    @IBAction func randomImageButtonClick(_ sender: Any) {
        
        //Fade out image
        UIView.transition(with: self.imageView, duration: 0.5, options: .transitionCrossDissolve, animations: {self.imageView.image = nil}, completion: nil)
        loadingIndicator.startAnimating()
        
        API().getRandomImage(imageView: imageView) { (image: UIImage) in
            
            let start = self.imageView.center
            self.imageView.center.y = self.imageView.center.y - self.imageView.frame.height
            self.imageView.image = image
            
            UIView.animateKeyframes(withDuration: 1, delay: 0, options: .calculationModeCubic, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.3, animations: {
                    self.imageView.center = start
                    })
                UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.2, animations: {
                    self.imageView.center.y += self.imageView.frame.height / 7
                })
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.3, animations: {
                    self.imageView.center.y -= self.imageView.frame.height / 5
                })
                UIView.addKeyframe(withRelativeStartTime: 0.8, relativeDuration: 0.2, animations: {
                    self.imageView.center = start
                })
                }, completion: nil)
            
            self.loadingIndicator.stopAnimating()
        }
    }
}
