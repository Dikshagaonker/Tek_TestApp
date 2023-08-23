//
//  ErrorClass.swift
//  CameraFilter
//
//  Created by Diksha on 21/08/23.
//

import Foundation
import UIKit

class ErrorClass {

    func checkIfError(_ target: UIViewController, responseJSON: [String: Any]) -> Bool{
        if let err = responseJSON["err"] as? Int, err > 0, let errMsg = responseJSON["errMsg"] as? String, errMsg != ""{
            target.showAlert(title: "Error", havingSubtitle: errMsg)
            return true
        } else{
            return false
        }
    }
    
    func checkIfErrorGoBack(_ target: UIViewController, responseJSON: [String: Any]) -> Bool{
        if let err = responseJSON["err"] as? Int, err > 0, let errMsg = responseJSON["errMsg"] as? String, errMsg != "", let errTitle = responseJSON["errTitle"]  as? String{
            target.showAlert(title: errTitle, havingSubtitle: errMsg, perform: {[weak target] in
                target?.navigationController?.popViewController(animated: true)
            })
            return true
        } else{
            return false
        }
    }
    
    func checkIfErrorAndPerform(_ target: UIViewController, responseJSON: [String: Any], perform:(() -> Void)? = nil) -> Bool{
        if let errMsg = responseJSON["errMsg"] as? String, errMsg != "", let errTitle = responseJSON["errTitle"]  as? String{
            target.showAlert(title: errTitle, havingSubtitle: errMsg, perform: {
                if let completion = perform{
                  completion()
                }
            })
            return true
        } else{
            return false
        }
    }
}
