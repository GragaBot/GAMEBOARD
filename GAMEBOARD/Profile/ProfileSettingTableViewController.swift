//
//  ProfileSettingTableViewController.swift
//  GAMEBOARD
//
//  Created by T on 4/28/18.
//  Copyright © 2018 T. All rights reserved.
//

import UIKit

class ProfileSettingTableViewController: UITableViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var changeProfileImage: UIButton!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.email.text = Profile.currentUser?.email
        
        profileImage.clipsToBounds = true
        profileImage.layer.cornerRadius = profileImage.bounds.size.height/2
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.borderWidth = 3
        self.username.text = Profile.currentUser?.username
        if let profileUrl = Profile.currentUser?.profilePicUrl{
            let data = try? Data(contentsOf: profileUrl)
            profileImage.image = UIImage(data: data!)
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
/*
    @IBAction func changeUserName(_ sender: Any) {
        Profile.currentUser?.username = self.username.text!
        Profile.currentUser?.sync(onSuccess: {}, onError: {
            error in
            print(error.localizedDescription)
        })
        
    }*/
    @IBAction func changeUserName(_ sender: Any) {
        Profile.currentUser?.username = self.username.text!
        Profile.currentUser?.sync(onSuccess: {}, onError: {
            error in
            print(error.localizedDescription)
        })
    }
    
    @IBAction func changeImage(_ sender: Any) {
       
        presentImagePickerView()
    }
    func presentImagePickerView() {
        Config.showPlainLoading(withStatus: nil)
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: {
            Config.dismissPlainLoading()
        })
    }
    
    func setImage(withImage image: UIImage) {
       
        self.profileImage.image = image
        
    }
    
    func uploadImage(withImage image: UIImage) {
        let imageData = UIImageJPEGRepresentation(image, 0.7)!
        
        API.userAPI.uploadCurrentUserProfileImage(imageData: imageData, onSuccess: {
                print("Upload Success")
            })
        
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        var selectedImage: UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            selectedImage = editedImage
        }
        else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            selectedImage = originalImage
        }
        if let finalImage = selectedImage {
            self.setImage(withImage: finalImage)
            picker.dismiss(animated: true, completion: {
                self.uploadImage(withImage: finalImage)
            })
        }
        
    }
    

}
