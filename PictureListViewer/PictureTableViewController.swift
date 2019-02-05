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
        
        getPictureJSONListFromURL(url: "https://picsum.photos/list") { (pictureArray: [PictureJSON]) in
            guard pictureArray.count != nil else { return }
            self.picturesAdd(picList: pictureArray)
        }
        
        
        
        //110 x 80

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        //Load sample cells
        loadSampleCells()
        
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
        cell.pictureImageView.image = pictureObj.photo
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
            guard let pictureViewController = segue.destination as? ViewController else {
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
    
    //MARK: Networking
    
    func getPictureJSONListFromURL(url: String, completion: @escaping(_ pictureArray: [PictureJSON]) -> Void) {
        
        //Prepare an array to fill and then return.
        var picArr = [PictureJSON]()
        
        var headers = Alamofire.SessionManager.defaultHTTPHeaders
        headers["User-Agent"] = "iPhone"
        
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: headers)
            .responseJSON { (response) in
            
            //Get status code of HTTP request
            if let status = response.response?.statusCode {
                
                
                //Status code 200, standard response for HTTP requests if no error encountered.
                switch(status){
                case 200:
                    guard let data = response.data else { return }
                    let decoder = JSONDecoder()
                    guard let jsonArray = try? JSON(data: data) else { return }
                    
                    for jsonObject in jsonArray.arrayValue {
                        if let jsonPic = try? decoder.decode(PictureJSON.self, from: jsonObject.rawData()) {
                            let jsonPic = picArr += [jsonPic]
                        }
                    }
                default:
                    print("Error with Alamofire response status: \(status)")
                }
                
            }
            completion(picArr)
        }
    }

    
    //MARK: Private Methods
    
    private func loadSampleCells() {
        
        let sample1 = UIImage(named: "sample1")
        let sample2 = UIImage(named: "sample2")
        let sample3 = UIImage(named: "sample3")
        
        
        guard let picture1 = Picture(photo: sample1!, author: "authorstr", size: "sizestr", format: "frmatstr", id: 0) else {
            fatalError("Could not instantiate picture1")
        }
        
        guard let picture2 = Picture(photo: sample2!, author: "authorstr", size: "sizestr", format: "formatstr", id: 0) else {
            fatalError("Could not instantiate picture2")
        }
        
        guard let picture3 = Picture(photo: sample3!, author: "authorstr", size: "sizestr", format: "formatstr", id: 0) else {
            fatalError("Could not instantiate picture3")
        }
        
        pictures += [picture1, picture2, picture3]
    }
    
    private func picturesAdd(picList: [PictureJSON]){
        if (!picList.isEmpty){
          for jsonpic in picList {
            let pic = Picture(pictureJson: jsonpic)
            pictures += [pic]
            }
        }
    }
    
    private func picturesAdd(picList: [Picture]){
        if (!picList.isEmpty){
            pictures += picList
        }
    }

}
