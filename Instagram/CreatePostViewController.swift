//
//  CreatePostViewController.swift
//  Instagram
//
//  Created by Sijin Wang on 3/8/18.
//  Copyright © 2018 Sijin Wang. All rights reserved.
//

import UIKit
import RSKPlaceholderTextView

class CreatePostViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageBtn: UIButton!
    @IBOutlet weak var captionField: RSKPlaceholderTextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var backBtn: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicator.transform = transform
        activityIndicator.layer.cornerRadius = 10
        captionField.backgroundColor = .white
        captionField.placeholderColor = .black
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func imageBtnOnTap(_ sender: Any) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("camera is available")
            vc.sourceType = .camera
        }
        else {
            print("camera is not available so photo library is using instead")
            vc.sourceType = .photoLibrary
        }
        
        self.present(vc, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        let originImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        let frameSize = CGSize(width: imageBtn.frame.width, height: imageBtn.frame.height)
        let resizedImage = resize(image: editedImage, newSize: frameSize)
        self.imageBtn.setImage(resizedImage, for: .normal)
        dismiss(animated: true, completion: nil)
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        let resizeImageView = UIImageView(frame: rect)
        resizeImageView.contentMode = UIViewContentMode.scaleAspectFill
        resizeImageView.image = image
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    @IBAction func postOnTap(_ sender: Any) {
        self.activityIndicator.startAnimating()
        Post.postUserImage(image: imageBtn.currentImage, withCaption: captionField.text) { (success: Bool, error: Error?) in
            
            if success {
                self.activityIndicator.stopAnimating()
                UIViewPropertyAnimator(duration: 1, curve: .easeIn, animations: {
                    self.messageLabel.alpha = 1
                }).startAnimation()
                self.backBtn.title = "Back"
                print("uploaded!!!")
            }
            else {
                self.activityIndicator.stopAnimating()
                print(error?.localizedDescription)
            }
        }
    }
    
    func fadeViewInThenOut(view : UIView, delay: TimeInterval) {
        print("im here")
        let animationDuration = 0.25
        
        // Fade in the view
        UIView.animate(withDuration: animationDuration, animations: { () -> Void in
            view.alpha = 1
        }) { (Bool) -> Void in
            
            // After the animation completes, fade out the view after a delay
            
            UIView.animate(withDuration: animationDuration, delay: delay, options: [.curveEaseOut], animations: { () -> Void in
                view.alpha = 0
            }, completion: nil)
        }
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
