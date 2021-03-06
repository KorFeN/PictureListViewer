import UIKit

class DetailViewController: UIViewController {

    //MARK:Properties
    @IBOutlet weak var pictureImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var formatLabel: UILabel!
    @IBOutlet weak var backUIButton: UIButton!
    
    
    var picture: Picture?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let uPic = picture {
            
            //show data which was passed to View
            authorLabel.text = uPic.author
            sizeLabel.text = uPic.size
            formatLabel.text = uPic.format
            pictureImageView.image = uPic.photo
            self.title = uPic.author
            API().setImage(imageView: pictureImageView, picture: uPic)
        }else {
            fatalError("Picture object passed to DetailedView was nil.")
        }
    }    
}

