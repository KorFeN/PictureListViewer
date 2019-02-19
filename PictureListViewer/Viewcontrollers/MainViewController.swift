//
//  MainViewController.swift
//  PictureListViewer
//
//  Created by Ssss on 2019-02-07.
//

import UIKit

class MainViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    let tableViewDelegateDS = TableViewDelegateDatasource()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Browser"
        self.tableView.delegate = tableViewDelegateDS
        self.tableView.dataSource = tableViewDelegateDS
        // Do any additional setup after loading the view
        
        //Downloads PictureJSON array ASync, and then adds them to picture array as Picture objects.
        API().requestJsonArray(url: "https://picsum.photos/list") { (pictureArray: [PictureJSON]) in
            guard pictureArray.count != 0 else { return }
            self.picturesAdd(picList: pictureArray)
            self.tableView.reloadData()
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
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
         
            let selectedPicture = tableViewDelegateDS.pictures[indexPath.row]
            pictureViewController.picture = selectedPicture
        }
    }
    
    //MARK: Private Methods
    
    private func picturesAdd(picList: [PictureJSON]){
        if (!picList.isEmpty){
            for jsonpic in picList {
                let pic = Picture(pictureJson: jsonpic)
                self.tableViewDelegateDS.pictures += [pic]
            }
        }
    }
        
    private func picturesAdd(picList: [Picture]){
        if (!picList.isEmpty){
            self.tableViewDelegateDS.pictures += picList
        }
    }
}

