//
//  sh8helper.swift
//  sh8email
//
//  Created by Hun Jae Lee on 2/16/17.
//  Copyright © 2017 이강산. All rights reserved.
//

import Foundation
import Kanna

/// contains helper methods for sh8email.
class Sh8helper {
	
	/**
		Converts given date into human-readable string
		- parameter dateStr: the date string to convert. Assumes `yyyy-MM-dd'T'HH:mm:ss.SSSZ` format.
		- returns: the converted string, in `yyyy-MM-dd HH:mm` format.
	*/
	static func convertDate(_ dateStr: String) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
		guard let date = dateFormatter.date(from: dateStr) else {
			return dateStr
		}
		dateFormatter.locale = NSLocale.current
		dateFormatter.dateStyle = .short
		dateFormatter.timeStyle = .short
		dateFormatter.doesRelativeDateFormatting = true
		let timeStamp = dateFormatter.string(from: date)
		#if DEBUG
			print(timeStamp)
		#endif
		return timeStamp
	}

	/**
		Extracts content from string containing HTML tags
		- parameter str: the string with HTML tags in it
		- returns: the extracted content
	*/
	static func convertHtml(_ str: String) -> String {
		if let doc = HTML(html: str, encoding: .utf8) {
			guard let txt = doc.text else {
				return str
			}
			return doc.text!
		} else {
			return str
		}
	}
	
	/**
		Prettifies buttons by changing border attributes.
		- Parameters:
			- button: the target `UIButton`
			- radius: the `cornerRadius` to set
			- width: the `borderWidth` to set
			- color: the `CGColor` to set this button color as
	*/
    static func changeButtonBorder(button: UIButton, radius: CGFloat, width : CGFloat, color: UIColor) {
        button.layer.cornerRadius = radius
        button.layer.borderWidth = width
        button.layer.borderColor = color.cgColor
    }
    
}
