//
//  ProfileViewController.swift
//  Khmer-Social News
//
//  Created by ភី ម៉ារ៉ាសុី on 8/11/16.
//  Copyright © 2016 ភី ម៉ារ៉ាសុី. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UITableViewController {
   
    var uid = NSString()
    var ref = FIRDatabaseReference()
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var dateBirth: UILabel!
    @IBOutlet weak var nickName: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = FIRDatabase.database().reference()
        textView.layer.borderWidth = 3
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.masksToBounds = true
        textView.backgroundColor = UIColor.clear
        
        
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 150 / 3
        
         }
    override func viewWillAppear(_ animated: Bool) {
        ref.child("User").child(uid as String).child("Profile").observe(.value) { (snap:FIRDataSnapshot) in
            let snapshot = snap.value as? NSDictionary
            if let name = snapshot?["Name"] as? String{
             self.navigationItem.title = name
                self.nickName.text = name
            }
            if let gen = snapshot?["Gender"] as? String{
                self.genderLabel.text = gen
                
            }
            if let dob = snapshot?["DoB"] as? String{
                self.dateBirth.text = dob
                
            }
            if let info = snapshot?["Info"] as? String{
                self.textView.text = info
            }
            if let image = snapshot?["Profile"] as? String{
                if image == "xd"{
                    if self.genderLabel.text! == "Male"{
                    self.imageView.image = UIImage(named: "male")
                    }else{
                        self.imageView.image = UIImage(named:"female")
                    }
                }
                else{
                    self.imageView.image = ImageService.imageService.convertBase64ToImage(image)
                }
            }

        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "editProfile" {
            let destination = segue.destination as! EditProfileViewController
            destination.uid = uid
            
    }
    
    
    
  }
}
