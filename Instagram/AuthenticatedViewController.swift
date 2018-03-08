//
//  AuthenticatedViewController.swift
//  Instagram
//
//  Created by Sijin Wang on 3/6/18.
//  Copyright © 2018 Sijin Wang. All rights reserved.
//

import UIKit

class AuthenticatedViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded correctly")
        // Do any additional setup after loading the view.
        let titleLabel = UILabel.init()
        titleLabel.text = "Instagram"
        titleLabel.font = UIFont.init(name: "Academy Engraved LET", size: 24)
        titleLabel.shadowColor = UIColor.black
        titleLabel.sizeToFit()
        titleLabel.textAlignment = .center
        self.navigationItem.titleView = titleLabel
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOut(_ sender: Any) {
        print("logout clicked")
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
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
