import UIKit

class EditViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var cornerRadiusSlider: UISlider!
    @IBOutlet var pichGestureRecognizer: UIPinchGestureRecognizer!
    @IBOutlet var rotationGestureRecognizer: UIRotationGestureRecognizer!
    
    var image: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = image
        imageView.layer.masksToBounds = true
    }

    //MARK: Actions
    @IBAction func cornerRadiusSliderChangedValue(_ sender: Any) {
        setCornerRadius(imageView: self.imageView, radius: CGFloat(cornerRadiusSlider.value))
    }
    @IBAction func pinchGesture(_ sender: UIPinchGestureRecognizer) {
        zoomImageView(imageView: self.imageView, sender: sender)
    }
    
    
    @IBAction func rotationGesture(_ sender: UIRotationGestureRecognizer) {
        rotateImageView(imageView: self.imageView, sender: sender)
    }
    
    
    //MARK: Private Methods
    private func setCornerRadius(imageView: UIImageView, radius: CGFloat) {
        imageView.layoutIfNeeded()
        imageView.layer.cornerRadius = radius
    }
    
    private func rotateImageView(imageView: UIImageView, sender: UIRotationGestureRecognizer) {
        
        if sender.state == .began || sender.state == .changed {
            
            imageView.transform = (imageView.transform.concatenating(CGAffineTransform(rotationAngle: sender.rotation)))
            sender.rotation = 0
            
            if sender.state == .began {
                UIView.animate(withDuration: 0.3, animations: {
                    imageView.layer.opacity = 0.8
                })
            }
            
        }
        if sender.state == .ended {
            UIView.animate(withDuration: 0.3, animations: {
                imageView.layer.opacity = 1
            })
        }
    }
    
    private func zoomImageView(imageView: UIImageView, sender: UIPinchGestureRecognizer) {
        
        if sender.state == .began || sender.state == .changed {
            imageView.transform = imageView.transform.concatenating(CGAffineTransform(scaleX: sender.scale, y: sender.scale))
            sender.scale = 1
        }
    }
}
