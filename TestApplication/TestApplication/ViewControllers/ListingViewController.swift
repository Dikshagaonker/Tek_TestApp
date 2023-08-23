//
//  ListingViewController.swift
//  CameraFilter
//
//  Created by Diksha on 21/08/23.
//


struct MainData{
    let page, perPage, total, totalPages: Int?
    let data: [ListData]?
    let support: Support?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}

struct ListData{
    var id: Int?
    var email, firstName, lastName: String?
    var avatar: String?

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}

struct Support: Codable {
    var url: String?
    var text: String?
}

//------------------------------------------------------


import Foundation
import UIKit
import Alamofire
import SkyFloatingLabelTextField

class ListingViewController: UIViewController {
    
//    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var dataArr = [ListData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchData()
        self.setUpTableView()
    }
    
    func setUpTableView(){
        self.tableView.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCell")

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 80.0
        self.tableView.tableFooterView = UIView()
        self.tableView.reloadData()
    }
    
    func fetchData(){
        Alamofire.request(backendURL).responseJSON(completionHandler: {response in
            if response.result.isFailure{
                print("Failure")
                self.showAlert(title: "Something went wrong", havingSubtitle: "Please try again later")
                return
            }else{
                print("Success")
                do{
                    let responseJSON = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as! [String:Any]
                    print(responseJSON)
                    
                    if let err = responseJSON["err"] as? Int, err > 0{
                        self.showAlert(title: "Try again", havingSubtitle: responseJSON["errMsg"] as! String)
                        return
                    }else{
                        
                        if let dataArray = responseJSON["data"] as? [[String:Any]], dataArray.count > 0{
                            for data in dataArray{
                                var dataAccess = ListData()
                                dataAccess.id = data["id"] as? Int ?? 0
                                dataAccess.firstName = data["first_name"] as? String ?? ""
                                dataAccess.lastName = data["last_name"] as? String ?? ""
                                dataAccess.email = data["email"] as? String ?? ""
                                dataAccess.avatar = data["avatar"] as? String ?? ""
                                self.dataArr.append(dataAccess)
                            }
                            self.tableView.reloadData()
                        }
                    }
                    
                }catch{
                    print("Error")
                    self.showAlert(title: "Something went wrong", havingSubtitle: "Please try again later")
                    return

                }
            }
        })
    }
    
    @IBAction func didClickBtn(_ sender: Any) {
        self.dismiss(animated: true)
    }
}


extension ListingViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listData = self.dataArr[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell") as! ListTableViewCell
        cell.listdata = listData
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let listData = self.dataArr[indexPath.row]
        let vc = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
        vc.dataDetail = listData
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}


