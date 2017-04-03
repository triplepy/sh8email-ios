//
//  sh8mailTableViewController.swift
//  sh8email
//
//  Created by Hun Jae Lee on 1/20/17.
//  Copyright © 2017 이강산. All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class Sh8mailTableViewController: UITableViewController {
	var username: String?
	var emails: [Mail] = []

	override func viewWillAppear(_ animated: Bool) {
		self.checkEmail()
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		print("<SYSTEM> Checking email for \(username)...")

		// Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
	@IBAction func refreshButtonTapped(_ sender: Any) {
		self.checkEmail()
	}
	
	func checkEmail() {
        self.emails = []
		let sh8emailRequestURL = "https://sh8.email/rest/mail/\(username!)/list/"
		Alamofire.request(sh8emailRequestURL).responseArray { (response: DataResponse<[Mail]>) in
			self.emails = []
			guard let mailArray = response.result.value else {
				print("< ERR! > Did not receive data for username \"\(self.username!)\"")
				return
			}
			
			if mailArray.count == 0 {
				let alert = UIAlertController(title: "\(self.username!)@sh8.email", message: "수신된 메일이 없습니다.", preferredStyle: UIAlertControllerStyle.alert)
				alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: { (action) -> Void in
					self.performSegue(withIdentifier: "noEmailReturnUnwindSegue", sender: self)
				}))
				self.present(alert, animated: true, completion: nil)
			}

			print("<SYSTEM> Received data for username \"\(self.username!)\"")
			for mail in mailArray {
				self.emails.append(mail)
				
				print(mail.description)
			}
			
			DispatchQueue.main.async {
				self.tableView.reloadData()
			}
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
}

// MARK: - Table view data source
extension Sh8mailTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emails.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sh8mailCell", for: indexPath) as! sh8mailTableViewCell
        
        let mail = emails[indexPath.row]
        
        cell.senderLabel.text = mail.sender
        cell.recipDateLabel.text = Sh8helper.convertDate(mail.recipDate!)
        cell.subjectLabel.text = mail.subject
        cell.contentsLabel.text = Sh8helper.convertHtml(mail.contents!)
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected row: \(indexPath.row),  sender: \(self.emails[indexPath.row].sender)")
    }
	
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "showEmail" {
			let nextScene = segue.destination as! Sh8mailDetailViewController
			if let indexPath = self.tableView.indexPathForSelectedRow {
				let email = emails[indexPath.row]
				nextScene.email = email
				
				// setup back button http://stackoverflow.com/questions/28471164/how-to-set-back-button-text-in-swift
				let backItem = UIBarButtonItem()
				backItem.title = "Back"
				navigationItem.backBarButtonItem = backItem
				navigationItem.title = "\(username!)@sh8.email"
				print(emails[indexPath.row])

			}
		}
	}
}
