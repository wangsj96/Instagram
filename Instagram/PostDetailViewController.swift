//
//  PostDetailViewController.swift
//  Instagram
//
//  Created by Sijin Wang on 3/11/18.
//  Copyright © 2018 Sijin Wang. All rights reserved.
//

import UIKit
import Parse

class PostDetailViewController: UIViewController {

    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!
    @IBOutlet weak var postDateLabel: UILabel!
    var post: PFObject!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let dateCreated = post.createdAt! as NSDate
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "EEE, MMM d, h:mm a"
        let dateString = NSString(format: "Posted On: %@", dateFormat.string(from: dateCreated as Date)) as String
        self.postDateLabel.text = dateString
        
        let caption = post["caption"] as! String
        captionLabel.text = caption
        
        let imageFile = post["media"] as! PFFile
        let imageData = try? imageFile.getData()
        self.postImageView.image = UIImage(data: imageData!)
        print(dateString)
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
