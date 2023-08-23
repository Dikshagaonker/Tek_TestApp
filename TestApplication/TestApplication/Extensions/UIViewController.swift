//
//  UIViewController.swift
//  CameraFilter
//
//  Created by Diksha on 21/08/23.
//

import Foundation
import UIKit
import Alamofire
import SkyFloatingLabelTextField

class MyTapGestureRecognizer: UITapGestureRecognizer {
    var action : (()->Void)? = nil
    var label = String()
}

var isLoaderVisible = false

//UIViewController
extension UIViewController{

    func showAlert(title: String,havingSubtitle subtitle:String, perform:(() -> Void)? = nil){
        let alert = UIAlertController.init(title: title, message: subtitle, preferredStyle: .alert)
        let ok = UIAlertAction.init(title: "OK", style: .default, handler: {(action: UIAlertAction) in
            alert.dismiss(animated: true, completion: nil)
            if let completion = perform{
                completion()
            }
        })
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}


//UILabel
extension UILabel{
    func tapGesture(action : @escaping ()->Void ){
        let tap = MyTapGestureRecognizer(target: self , action: #selector(self.tap(_:)))
        tap.action = action
        tap.numberOfTapsRequired = 1
        
        self.addGestureRecognizer(tap)
        self.isUserInteractionEnabled = true
        
    }
    
    @objc func tap(_ sender: MyTapGestureRecognizer) {
        sender.action!()
    }
}

//UIImage
extension UIImage {
  convenience init?(url: URL?) {
    guard let url = url else { return nil }
            
    do {
      self.init(data: try Data(contentsOf: url))
    } catch {
      print("Cannot load image from url: \(url) with error: \(error)")
      return nil
    }
  }
}



class CounterManager {
    static let shared = CounterManager()
    
    private let userDefaults = UserDefaults.standard
    private let counterKey = "appCounter"
    
    private init() {}
    
    func incrementCounter() {
        var currentCount = userDefaults.integer(forKey: counterKey)
        currentCount += 1
        userDefaults.set(currentCount, forKey: counterKey)
    }
    
    func getCounter() -> Int {
        return userDefaults.integer(forKey: counterKey)
    }
}
