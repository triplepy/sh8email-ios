//
//  ShowSh8EmailViewController.swift
//  sh8email
//
//  Created by Hun Jae Lee on 2/27/17.
//  Copyright © 2017 이강산. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireObjectMapper

class Sh8mailDetailViewController: UIViewController {
	// email data
	var email: Mail?
	
	// MARK: UIOutlets
	@IBOutlet var subjectLabel: UILabel!
	@IBOutlet var senderLabel: UILabel!
	@IBOutlet var recipDateLabel: UILabel!
	@IBOutlet var contentView: UIWebView!
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		request(email!)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	func request(_ email: Mail) {
		if (email.isSecret!) {
			// show UIAlert for password
			var inputTextField: UITextField?
			let passwordPrompt = UIAlertController(title: "Enter Password", message: "You have selected to enter your password.", preferredStyle: UIAlertControllerStyle.alert)
			passwordPrompt.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: { (action) -> Void in
				// go up one segue
				
			}))
			passwordPrompt.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (action) -> Void in
				// call json using password
				let password = inputTextField?.text!
				self.requestDataAndSetFields(for: email, using: password!)
			}))
			passwordPrompt.addTextField(configurationHandler: {(textField: UITextField!) in
				textField.placeholder = "Password"
				textField.isSecureTextEntry = true
				inputTextField = textField
			})
			present(passwordPrompt, animated: true, completion:  { (action) -> Void in
				print("present")
			})
		} else {
			self.requestDataAndSetFields(for: email)
		}
		
	}
	
	func requestDataAndSetFields(for email: Mail) {
		let emailRequestURL = "https://sh8.email/rest/mail/\(email.recipient!)/\(email.pk!)/"
		Alamofire.request(emailRequestURL).responseObject { (response: DataResponse<Mail>) in
			guard let email = response.result.value else {
				print("< ERR! > Did not receive data!")
				return
			}
			print("<SYSTEM> Received data!")
			print(email.description)
			DispatchQueue.main.async {
				self.setFields(using: email)
			}
		}
	}
	
	func requestDataAndSetFields(for email: Mail, using secretCode: String) {
		let emailRequestURL = "https://sh8.email/rest/mail/\(email.recipient!)/\(email.pk!)/"
		let parameters = ["secret_code" : secretCode]
		Alamofire.request(emailRequestURL, method: .post, parameters: parameters).responseObject { (response: DataResponse<Mail>) in
			guard let email = response.result.value else {
				print("< ERR! > Did not receive data!")
				return
			}
			print("<SYSTEM> Received data!")
			print(email.description)
			DispatchQueue.main.async {
				self.setFields(using: email)
			}
		}
	}

	
	/**
		refreshes the UI elements using given `Mail`.
		- Parameter mail: the `Mail` object to set up the UI fields
	*/
	func setFields(using mail: Mail) {
		subjectLabel.text = mail.subject
		senderLabel.text = mail.sender
		recipDateLabel.text = mail.recipDate
		contentView.loadHTMLString(mail.contents!, baseURL: nil)
	}
	
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
