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
	static let model = Sh8model()	// singleton pattern
	var emails = [Mail]()
	
	func checkMail(username: String) {
		self.clearMail()
		let sh8emailRequestURL = "https://sh8.email/rest/mail/\(username)/list/?format=json"
		Alamofire.request(sh8emailRequestURL).responseArray { (response: DataResponse<[Mail]>) in
			let mailArray = response.result.value
			if let mailArray = mailArray {
				for mail in mailArray {
					self.emails.append(mail)
					print(mail.description)
				}
			}
		}
	}
	
	func clearMail() {
		self.emails = [Mail]()
	}
}
