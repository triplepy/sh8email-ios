//
//  Mail.swift
//  ios
//
//  Created by 이강산 on 2016. 9. 25..
//  Copyright © 2016년 이강산. All rights reserved.
//

import Foundation
import ObjectMapper
import AlamofireObjectMapper

class Mail: Mappable {
    var pk: Int?
    var recipient: String?
    var sender: String?
    var subject: String?
    var contents: String?
    var recipDate: String?
    var isSecret: Bool?
    var isRead: Bool?
	
	var description: String {
		return "\(self.sender) (\(self.recipDate))\n\(self.subject)\n\(self.contents)"
	}
	
    required init?(map: Map) {
    
    }
    
    func mapping(map: Map) {
        pk          <- map["pk"]
        recipient   <- map["recipient"]
        sender      <- map["sender"]
        subject     <- map["subject"]
        contents    <- map["contents"]
        recipDate   <- map["recipDate"]
        isSecret    <- map["isSecret"]
        isRead      <- map["isRead"]
    }
	
}
