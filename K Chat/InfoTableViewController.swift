//
//  InfoTableViewController.swift
//  K Chat
//
//  Created by ភី ម៉ារ៉ាសុី on 8/19/16.
//  Copyright © 2016 ភី ម៉ារ៉ាសុី. All rights reserved.
//

import UIKit
import Firebase
class InfoTableViewController: UITableViewController{
    
    @IBOutlet weak var segField: UISegmentedControl!
    @IBOutlet weak var userName: UITextField!
    
    
    var ref = FIRDatabaseReference()
    var uid = NSString()
    override func viewDidLoad() {
        ref = FIRDatabase.database().reference()
        super.viewDidLoad()
        print(uid)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func eventAction(_ sender: AnyObject) {
        
        let valueRef = self.ref.child("User").child(uid as String)
        let lol = [
            "Name": self.userName.text!
        ]
        valueRef.setValue(lol)
        self.performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "loginSegue"){
            let tabBar = segue.destination as! UITabBarController
            let navi = tabBar.viewControllers![0] as! UINavigationController
            let destination = navi.topViewController as! HomeTableViewController
            let navi2 = tabBar.viewControllers![2] as! UINavigationController
            let destination2 = navi2.topViewController as! ProfileViewController
            let navi3 = tabBar.viewControllers![1] as! UINavigationController
            let destination3 = navi3.topViewController as! ChatTableViewController
            
            destination3.uid = uid
            destination2.uid = uid
            destination.uid = uid
            
            
            
        }

    }
}

