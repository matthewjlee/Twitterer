//
//  LoginViewController.swift
//  TwitterDemo
//
//  Created by Matthew Lee on 2/11/17.
//  Copyright © 2017 Matthew Lee. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class LoginViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loginButton.layer.cornerRadius = 5
        //loginButton.layer.borderWidth = 1
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onLoginButton(_ sender: Any) {
        let client = TwitterClient.sharedInstance
        
        client?.login(success: { 
            print("I've logged in!")
            self.performSegue(withIdentifier: "loginSegue", sender: nil)
        }, failure: { (error) in
            print("error: error.localizedDescription")
        })
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
