//
//  MailFetcher.swift
//  sh8email
//
//  Created by Hun Jae Lee on 1/17/17.
//  Copyright © 2017 이강산. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

class Sh8model {
	var username: String?
	var emails = [Mail]()
	
	/**
		sets current sh8model's username
	*/
	func setUsername(as username: String) {
		self.username = username
	}
	
	/**
		checks sh8.email of current username and puts mail into emails list
	*/
	func checkMail() {
		// call json
		let sh8emailRequestURL = "https://sh8.email/rest/mail/\(username)/list/?format=json"
		Alamofire.request(sh8emailRequestURL).responseArray { (response: DataResponse<[Mail]>) in
			let mailArray = response.result.value
			
			// if mail exists in mailbox, put them in current mail list
			if let mailArray = mailArray {
				for mail in mailArray {
					self.emails.append(mail)
					print(mail.description)
				}
			}
		}
	}
}
