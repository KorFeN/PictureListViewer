//
//  API.swift
//  PictureListViewer
//
//  Created by Ssss on 2019-02-05.
//

import Alamofire
import Kingfisher
import SwiftyJSON
import Foundation

class API {

    //MARK: Functions
    
    func requestJsonArray(url: String, completion: @escaping(_ pictureArray: [PictureJSON]) -> Void) {
        
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
                                _ = picArr += [jsonPic]
                            }
                        }
                    default:
                        print("Error with Alamofire response status: \(status)")
                    }
                    
                }
                completion(picArr)
        }
    }
    
    func setImage(imageView: UIImageView, picture: Picture) {
        
        //Loads image of correct size corresponding to imageView from picsum and caches the image to memory/disk
        imageView.kf.setImage(with: URL(string: String(format: "https://picsum.photos/%f/%f?image=%d", imageView.frame.size.width, imageView.frame.size.height, picture.id!)))
    }
}
