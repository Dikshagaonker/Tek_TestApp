//
//  ApiClass.swift
//  CameraFilter
//
//  Created by Diksha on 21/08/23.
//

import Foundation
import Alamofire

class ApiClass {
    
    var AFManager = SessionManager()
    
    func apiCall(target: UIViewController, parameters:[String: Any], showLoader: Bool = true, backendURI: String = backendURL, shouldHideLoader: Bool = true, completion: @escaping ( _ responseData: [String: Any]) -> ()){
        print(parameters)
//        if showLoader{
//            target.showProgressLoader()
//        }
        let errJSON: [String: String] = ["errTitle": "Something went wrong","errMsg": "Please try again later"]
        AFManager.request(backendURI).responseJSON(completionHandler: {response in
            switch response.result{
            case .failure(_):
//                if showLoader{
//                    target.hideProgressLoader()
//                }
                completion(errJSON)
            case .success(_):
                do{
                    var responseJSON = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! [String: Any]
                    print(responseJSON)
//                    if showLoader && shouldHideLoader{
//                        target.hideProgressLoader()
//                    }
                    if let errMsg = responseJSON["errMsg"] as? String, errMsg != ""{
                        responseJSON["errTitle"] = responseJSON["errTitle"] as? String ?? "Error"
                    }
                    completion(responseJSON)
                } catch{
//                    if showLoader{
//                        target.hideProgressLoader()
//                    }
                    completion(errJSON)
                }
            }
        })
    }
    
    func apiCallDecode(target: UIViewController, parameters:[String: Any], showLoader: Bool = true, backendURI: String = backendURL, completion: @escaping ( _ responseData: [String: Any], _ responseString: Data?) -> ()){
        print(parameters)
//        if showLoader{
//            target.showProgressLoader()
//        }
        let errJSON: [String: String] = ["errTitle": "Something went wrong","errMsg": "Please try again later"]
        Alamofire.request(backendURI).responseJSON(completionHandler: {response in
            
            switch response.result{
            case .failure(_):
//                if showLoader{
//                    target.hideProgressLoader()
//                }
                completion(errJSON, nil)
            case .success(_):
                do{
                    var responseJSON = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! [String: Any]
                    print(responseJSON)
//                    if showLoader{
//                        target.hideProgressLoader()
//                    }
                    if let errMsg = responseJSON["errMsg"] as? String, errMsg != ""{
                        responseJSON["errTitle"] = responseJSON["errTitle"] as? String ?? "Error"
                    }
                    completion(responseJSON, response.data!)
                } catch{
//                    if showLoader{
//                        target.hideProgressLoader()
//                    }
                    completion(errJSON, nil)
                }
            }
        })
    }
}
