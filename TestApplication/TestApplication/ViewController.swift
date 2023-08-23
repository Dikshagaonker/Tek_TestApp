//
//  ViewController.swift
//  TestApplication
//
//  Created by Diksha on 22/08/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.label.tapGesture {
            self.didClickLabel()
        }
        
        let counterValue = CounterManager.shared.getCounter()
        self.counterLabel.text = "App Loaded \(counterValue) times"
    }
    
    func didClickLabel(){
        let vc = ListingViewController(nibName: "ListingViewController", bundle: nil)
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
}

