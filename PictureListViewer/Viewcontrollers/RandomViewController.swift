import UIKit
import NVActivityIndicatorView

class RandomViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var randomUIButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var loadingIndicator: NVActivityIndicatorView!
    @IBOutlet var imageTapRecogniser: UITapGestureRecognizer!
    
    //MARK: Initialization
    override func viewDidLoad() {
        super.viewDidLoad()

        getRandomImage()
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "showEditSegue" {
            guard let editViewController = segue.destination as? EditViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            editViewController.image = self.imageView.image
        }
    }
    

    //MARK: Actions
    @IBAction func randomImageButtonClick(_ sender: Any) {
        
        getRandomImage()
    }
    
    
    //MARK: Private Methods
    private func getRandomImage() {
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
