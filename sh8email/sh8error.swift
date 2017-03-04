//
//  sh8error.swift
//  sh8email
//
//  Created by Hun Jae Lee on 2/16/17.
//  Copyright © 2017 이강산. All rights reserved.
//

enum Sh8error: Error {
	case usernameNotSet
	case secretcodeNotGiven
	case wrongSecretCode
}
