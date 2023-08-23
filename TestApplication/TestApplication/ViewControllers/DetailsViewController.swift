//
//  DetailsViewController.swift
//  TestApplication
//
//  Created by Diksha on 22/08/23.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var firstName: UILabel!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var itemId: UILabel!
    
    var dataDetail: ListData?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.prefillData()

        // Do any additional setup after loading the view.
    }

    func prefillData(){
        self.itemId.text = "\(dataDetail?.id ?? 0)"
        self.firstName.text = dataDetail?.firstName ?? ""
        self.lastName.text = dataDetail?.lastName ?? ""
        self.email.text = dataDetail?.email ?? ""
        self.avatarImageView.image = UIImage(url: URL(string: dataDetail?.avatar ?? ""))
    }

    @IBAction func didClickDone(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
