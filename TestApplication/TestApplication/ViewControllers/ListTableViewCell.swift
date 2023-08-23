//
//  ListTableViewCell.swift
//  TestApplication
//
//  Created by Diksha on 22/08/23.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var email: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    var listdata: ListData!{
        didSet{
            name.text = "\(listdata.firstName ?? "") \(listdata.lastName ?? "")"
            email.text = listdata.email ?? ""
            id.text = "\(listdata.id ?? 0)"
        }
    }
    
}
