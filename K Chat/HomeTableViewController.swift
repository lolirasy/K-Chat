//
//  HomeTableViewController.swift
//  K Chat
//
//  Created by ភី ម៉ារ៉ាសុី on 8/13/16.
//  Copyright © 2016 ភី ម៉ារ៉ាសុី. All rights reserved.
//

import UIKit
import Firebase
import Material
class HomeTableViewController: UITableViewController{
    var ref = FIRDatabaseReference()
    var user = NSMutableArray()
    var userId = NSMutableArray()
    var uid = NSString()
    var index = Int()
    var imageArray = NSMutableArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()

    }
    override func viewWillAppear(_ animated: Bool) {
        self.user.removeAllObjects()
        self.imageArray.removeAllObjects()
        self.userId.removeAllObjects()
        super.viewWillAppear(true)
        ref.child("User").observe(.childAdded) { (snap: FIRDataSnapshot) in
            let snapshot = snap.value as? NSDictionary
            if let name = snapshot?["Name"] as? String{
                if snap.key == self.uid as String {
                    
                }
                else{
                self.userId.add(snap.key)
                self.user.add(name)
                self.getImage(snap.key)
                self.tableView.reloadData()
                }
            }
            
        }
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    
    }
    func getImage(_ string: String){
        ref.child("User").child(string).child("Profile").observe(.value) { (snap:FIRDataSnapshot) in
            let snapshot = snap.value as? NSDictionary
            if let image = snapshot?["Profile"] as? String{
                self.imageArray.add(image)
                self.tableView.reloadData()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        index = (indexPath as NSIndexPath).row
        print(userId[index])
       self.performSegue(withIdentifier: "chatSegue", sender: self)
        
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chatSegue" {
            let destination = segue.destination as! ChatViewController
            destination.uid = uid
            destination.uidPartner = userId[index] as! NSString
            destination.hidesBottomBarWhenPushed = true
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeTableViewCell
        if userId.count > -1 {
            if imageArray.count > 0{
        if imageArray[(indexPath as NSIndexPath).row] as! String == "xd"{
            cell.imageView?.image = UIImage(named:"male")
            }
        else{
            cell.imageView?.image = ImageService.imageService.convertBase64ToImage(imageArray[indexPath.row] as! String)
            }
            }
       // cell.backgroundColor = UIColor.lightGrayColor()
        //cell.pulseColor = MaterialColor.lightGreen.base
        cell.myLabel.text = (self.user[(indexPath as NSIndexPath).row] as! String)
        }
        return cell;
    }
    
}
