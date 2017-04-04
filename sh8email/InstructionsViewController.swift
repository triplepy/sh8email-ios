//
//  InstructionsViewController.swift
//  sh8email
//
//  Created by Hun Jae Lee on 1/6/17.
//  Copyright © 2017 이강산. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController {
    
	@IBAction func returnToMainButton(_ sender: Any) {
		self.performSegue(withIdentifier: "unwindToMain", sender: self)
	}
    
}
