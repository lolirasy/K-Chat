//
//  EditProfileViewController.swift
//  K Chat
//
//  Created by ភី ម៉ារ៉ាសុី on 8/15/16.
//  Copyright © 2016 ភី ម៉ារ៉ាសុី. All rights reserved.
//

import UIKit
import Firebase

class EditProfileViewController: UITableViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    var uid = NSString()
    
    @IBOutlet weak var dob: UITextField!
    @IBOutlet weak var nickName: UITextField!
  
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var genderSegment: UISegmentedControl!
    @IBOutlet weak var imageView: UIImageView!
    var string64Image = "xd"
    var ref = FIRDatabaseReference()
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        textView.layer.borderWidth = 3
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.masksToBounds = true
        textView.backgroundColor = UIColor.clear
        
        
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 150 / 3

        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(EditProfileViewController.imageShow))
        imageView.isUserInteractionEnabled = true
        
        self.imageView.addGestureRecognizer(tap)
        

        
    }
    func imageShow(){
        present(imagePicker, animated: true, completion: nil)

    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingImage image: UIImage,
                               editingInfo: [String : AnyObject]?) {
        
        imageView.image = image
        string64Image = ImageService.imageService.convertImageToBase64(image)
        
        imagePicker.dismiss(animated: true, completion: nil)
  
    }

    
    @IBAction func btnSave_Clicked(_ sender: AnyObject) {
        var gen = "";
        
        let userRef = ref.child("User").child(uid as String).child("Profile")
        if genderSegment.selectedSegmentIndex == 0 {
            gen = "Male"
        }
        else {
            gen = "Female"
        }
        
        let userDict = [
            "Name": self.nickName.text!,
            "Profile": string64Image,
            "Gender": gen,
            "DoB": self.dob.text!,
            "Info": self.textView.text!
        
        ]
        
        userRef.setValue(userDict)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        ref.child("User").child(uid as String).child("Profile").observe(.value) { (snap:FIRDataSnapshot) in
        
            let snapshot = snap.value as? NSDictionary
            if let name = snapshot?["Name"] as? String{
                self.navigationItem.title = name
                self.nickName.text = name
            }
            if let image = snapshot?["Profile"] as? String{
                if image == "xd"{
                    
                    self.imageView.image = UIImage(named: "male")
                }
                else{
                    self.imageView.image = ImageService.imageService.convertBase64ToImage(image)
                }
            }
            if let gen = snapshot?["Gender"] as? String{
                if gen == "Male" {
                    self.genderSegment.selectedSegmentIndex = 0
                    
                }else{
                    self.genderSegment.selectedSegmentIndex = 1
                }

                
            }

            if let dob = snapshot?["DoB"] as? String{
                self.dob.text = dob
                
            }
            if let info = snapshot?["Info"] as? String{
                self.textView.text = info
            }
        }

    }
    
    
    
}
