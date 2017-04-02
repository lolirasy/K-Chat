//
//  ChatTableViewController.swift
//  K Chat
//
//  Created by ភី ម៉ារ៉ាសុី on 8/16/16.
//  Copyright © 2016 ភី ម៉ារ៉ាសុី. All rights reserved.
//

import UIKit
import Firebase
class ChatTableViewController: UITableViewController {
    var index = Int()
    var uid = NSString()
    var uidPartner = NSMutableArray()
    var namePartner = NSMutableArray()
    var ref = FIRDatabaseReference()
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        uidPartner.removeAllObjects()
        namePartner.removeAllObjects()
        

        super.viewWillAppear(true)
        ref.child("User").child(uid as String).child("Chat").observe(.childAdded) { (snapshot:FIRDataSnapshot) in
            let partner = snapshot.key
            self.uidPartner.add(partner)
            self.getName(partner)
        }
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        
        
        
        
        
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        index = (indexPath as NSIndexPath).row
        self.performSegue(withIdentifier: "chatSegue", sender: self)
        
        

    }
    
    
    func getName(_ string: String){
        self.ref.child("User").child(string).observe(.value) { (snap:FIRDataSnapshot) in
            let snapshot = snap.value as? NSDictionary
            if let name = snapshot?["Name"] as? String{
            self.namePartner.add(name)
                
                self.tableView.reloadData()
            }
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.namePartner.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatTableViewCell
        if namePartner.count > 0{
        if let text = self.namePartner[(indexPath as NSIndexPath).row] as? String{
        cell.myLabel.text = text
        }
        }
        return cell
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chatSegue" {
            let destination = segue.destination as! ChatViewController
            destination.uid = uid
            destination.uidPartner = uidPartner[index] as! NSString
            destination.hidesBottomBarWhenPushed = true
            
        }
    }
    
    
}
