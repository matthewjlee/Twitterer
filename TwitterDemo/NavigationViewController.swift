//
//  NavigationViewController.swift
//  TwitterDemo
//
//  Created by Matthew Lee on 3/4/17.
//  Copyright © 2017 Matthew Lee. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let image = UIImage(named: "TwitterLogo")
        //navigationItem.titleView = UIImageView(image: image)
        //self.navigationController?.navigationBar.setBackgroundImage(backgroundImage: UIImageView(image: image), for: )
        self.navigationController?.navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
