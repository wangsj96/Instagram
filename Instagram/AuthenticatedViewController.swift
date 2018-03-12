//
//  AuthenticatedViewController.swift
//  Instagram
//
//  Created by Sijin Wang on 3/6/18.
//  Copyright © 2018 Sijin Wang. All rights reserved.
//

import UIKit
import Parse

class AuthenticatedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts: [PFObject]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        fetchPosts()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOut(_ sender: Any) {
        print("logout clicked")
        NotificationCenter.default.post(name: NSNotification.Name("didLogout"), object: nil)
    }
    
    func fetchPosts() {
        // construct PFQuery
        let query = Post.query()
        query?.order(byDescending: "createdAt")
        query?.includeKey("author")
        query?.includeKey("_created_at")
        query?.limit = 20
        
        // fetch data asynchronously
        query?.findObjectsInBackground(block: { (posts:[PFObject]?, error: Error?) in
            if let posts = posts {
                self.posts = posts
//                print(posts)
                self.tableView.reloadData()
            }
            else {
                print(error?.localizedDescription)
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoFeed", for: indexPath) as! PostCell
        let post = posts[indexPath.row]
        cell.captionLabel.text = (post["caption"] as! String)
        let imageFile = post["media"] as! PFFile
        let imageData = try? imageFile.getData()
        cell.postImageView.image = UIImage(data: imageData!)
        cell.selectionStyle = .none
        return cell;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            let cell = sender as! UITableViewCell
            if let indexPath = tableView.indexPath(for: cell) {
                let post = posts[indexPath.row]
                let detailViewController = segue.destination as! PostDetailViewController
                detailViewController.post = post
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: false)
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
