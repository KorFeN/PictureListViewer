//
//  PictureTableViewController.swift
//  PictureListViewer
//
//  Created by Ssss on 2019-02-01.
//

import UIKit
import Alamofire
import SwiftyJSON

class PictureTableViewController: UITableViewController {

    //MARK: Properties
    var pictures = [Picture]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        API().requestJsonArray(url: "https://picsum.photos/list") { (pictureArray: [PictureJSON]) in
            guard pictureArray.count != 0 else { return }
            self.picturesAdd(picList: pictureArray)
            self.tableView.reloadData()
        }
        
        
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "PictureTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PictureTableViewCell else {
            fatalError("Could not cast TableViewCell to PictureTableViewCell")
        }
        
        // Configure the cell...
        let pictureObj = pictures[indexPath.row]
        
        //Sets placeholder image, then ASync download of image and sets it when completed
        cell.pictureImageView.image = pictureObj.photo
        API().setImage(imageView: cell.pictureImageView, picture: pictureObj)
        
        cell.authorLabel.text = pictureObj.author
        cell.sizeLabel.text = pictureObj.size
        cell.formatLabel.text = pictureObj.format

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "showImageSegue" {
            guard let pictureViewController = segue.destination as? DetailViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let selectedPictureCell = sender as? PictureTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            guard let indexPath = tableView.indexPath(for: selectedPictureCell) else {
                fatalError("selected cell is not displayed by table")
            }
            
            let selectedPicture = pictures[indexPath.row]
            pictureViewController.picture = selectedPicture
        }
    }
    
    //MARK: Private Methods
    
    private func picturesAdd(picList: [PictureJSON]){
        if (!picList.isEmpty){
          for jsonpic in picList {
            let pic = Picture(pictureJson: jsonpic)
            self.pictures += [pic]
            }
        }
    }
    
    private func picturesAdd(picList: [Picture]){
        if (!picList.isEmpty){
            self.pictures += picList
        }
    }

}
