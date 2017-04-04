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
	// MARK: - Environment
	var username: String?
	
	// MARK: - Outlets
	@IBOutlet var emailField: CustomTextField!
	@IBOutlet var checkEmailButton: UIButton!
	@IBOutlet var viewInstructionsButton: UIButton!
	@IBAction func unwindToMain(segue: UIStoryboardSegue) {}

	// MARK: - View
    override func viewDidLoad() {
        super.viewDidLoad()
        Sh8helper.changeButtonBorder(button: self.checkEmailButton, radius: 3, width : 1, color: UIColor.clear)
        Sh8helper.changeButtonBorder(button: self.viewInstructionsButton, radius: 3, width : 1, color: UIColor.clear)
	}
	
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        
        let border = CALayer()
        let width = CGFloat(1.0)
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: emailField.frame.size.height - width, width:  emailField.frame.size.width, height: emailField.frame.size.height)
        
        border.borderWidth = width
        emailField.layer.addSublayer(border)
        emailField.layer.masksToBounds = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// MARK: - Actions
	@IBAction func usernameEntered(_ sender: Any) {
		checkMailButtonTapped(self)
	}
    
	
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
	
	@IBAction func unwindToSh8MainView(segue: UIStoryboardSegue) {
	
	}
    
    // MARK: - Prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navVC = segue.destination as? UINavigationController{
            if let vc = navVC.visibleViewController as? Sh8mailTableViewController{
                vc.username = username
				vc.navigationItem.title = "\(username!)@sh8.email"
            }
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

