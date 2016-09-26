//
//  ViewController.swift
//  ios
//
//  Created by 이강산 on 2016. 9. 15..
//  Copyright © 2016년 이강산. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class ViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var titles = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        let params: Parameters = [
            "recipient":"test"
        ]
    
        Alamofire.request("https://sh8.email/rest/mail/test/list/",method:.post, parameters: params, encoding: URLEncoding.httpBody).responseArray { (response: DataResponse<[Mail]>) in
            let mailResponse = response.result.value
            
            if mailResponse?.count != nil {
                if let mailResponse = mailResponse {
                    for mail in mailResponse {
                        self.titles.append(mail.sender!)
                    }
                }
                
                self.tableView.beginUpdates()
                self.tableView.insertRows(at: [IndexPath(row: self.titles.count-1, section: 0)], with: .automatic)
                self.tableView.endUpdates()

            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "Cell")
        cell.textLabel?.text = titles[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if(self.tableView.responds(to: #selector(setter: UITableViewCell.separatorInset))) {
            self.tableView.separatorInset = UIEdgeInsets.zero
        }
        
        if(responds(to: #selector(setter: UIView.layoutMargins))) {
            self.tableView.layoutMargins = UIEdgeInsets.zero
        }
        
        if(cell.responds(to: #selector(setter: UIView.layoutMargins))) {
            cell.layoutMargins = UIEdgeInsets.zero
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

