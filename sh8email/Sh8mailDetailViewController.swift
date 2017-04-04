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
	
	/**
		Sets up and sends request for given `Mail` object.
		- Parameter email: the `Mail` object to send request and set up this UIView's fields.
	*/
	private func request(_ email: Mail) {
		if (email.isSecret!) {
			// show UIAlert for password
			var inputTextField: UITextField?
			let passwordPrompt = UIAlertController(title: "Encrypted Email", message: "Please enter the password to the email", preferredStyle: UIAlertControllerStyle.alert)
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
	
	/**
		Fetches given `Mail`'s details.
		- Parameters:
			- email: the `Mail` object to fetch details of.
	*/
	private func requestDataAndSetFields(for email: Mail) {
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
	
	/**
		Fetches given `Mail`'s details.
		- Parameters:
			- email: the `Mail` object to fetch details of.
			- secretCode: the `String` to unlock this email with.
	*/
	private func requestDataAndSetFields(for email: Mail, using secretCode: String) {
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
		- Parameter mail: the `Mail` object to set up the UI fields with
	*/
	private func setFields(using mail: Mail) {
		subjectLabel.text = mail.subject
		senderLabel.text = mail.sender
		recipDateLabel.text = mail.recipDate
		contentView.loadHTMLString(mail.contents!, baseURL: nil)
	}
}

// MARK: - UIWebViewDelegate
extension Sh8mailDetailViewController: UIWebViewDelegate {
	// Opens link separately in Safari, not within the UIWebview
	// Source:
	func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
		if navigationType == UIWebViewNavigationType.linkClicked {
			UIApplication.shared.open(request.url!, options: [:], completionHandler: { (completed: Bool) in
				
			})
			return false
		}
		return true
	}
}
