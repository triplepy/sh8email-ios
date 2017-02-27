//
//  ShowSh8EmailViewController.swift
//  sh8email
//
//  Created by Hun Jae Lee on 2/27/17.
//  Copyright © 2017 이강산. All rights reserved.
//

import UIKit

class Sh8mailDetailViewController: UIViewController {
	var email: Mail?
	
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
		
		print(email?.description)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	// TODO: - add read email API call
	func readEmail() {
		
	}
	
	// TODO: - add password query UIAlert for secure email
	

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
