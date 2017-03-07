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

class ViewController: UIViewController {
	var username: String?
	
	// MARK: Outlets
	@IBOutlet var emailField: CustomTextField!
	@IBOutlet var checkEmailButton: UIButton!
	@IBOutlet var viewInstructionsButton: UIButton!
	@IBAction func unwindToMain(segue: UIStoryboardSegue) {}

	// MARK: VIEW
    override func viewDidLoad() {
        super.viewDidLoad()
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
	@IBAction func checkMailButtonTapped(_ sender: Any) {
		username = emailField.text!
		if (username == "") {
			let alert = UIAlertController(title: "Error!", message: "이메일 주소를 입력해주세요.", preferredStyle: UIAlertControllerStyle.alert)
			alert.addAction(UIAlertAction(title: "Close", style: UIAlertActionStyle.default, handler: nil))
			self.present(alert, animated: true, completion: nil)
		} else {
            self.performSegue(withIdentifier: "showEmailTableView", sender: nil)
		}
	}
    
    // MARK: Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navVC = segue.destination as? UINavigationController{
            if let vc = navVC.visibleViewController as? Sh8mailTableViewController{
                vc.username = username
				vc.navigationItem.title = "\(username!)@sh8.email"
            }
        }
    }
}

