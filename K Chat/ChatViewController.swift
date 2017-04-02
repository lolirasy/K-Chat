//
//  ChatViewController.swift
//  K Chat
//
//  Created by ភី ម៉ារ៉ាសុី on 8/11/16.
//  Copyright © 2016 ភី ម៉ារ៉ាសុី. All rights reserved.
//

import UIKit
import JSQMessagesViewController
import Firebase
class ChatViewController: JSQMessagesViewController {
    var outgoingBubbleImageView: JSQMessagesBubbleImage!
    var incomingBubbleImageView: JSQMessagesBubbleImage!
    var messages = [JSQMessage]()
    var ref = FIRDatabaseReference()
    var uid: NSString = ""
    var uidPartner: NSString = ""
    
    var usersTypingQuery: FIRDatabaseQuery!
    var userIsTypingRef: FIRDatabaseReference!// 1
    fileprivate var localTyping = false // 2
    var isTyping: Bool {
        get {
            return localTyping
        }
        set {
            // 3
            localTyping = newValue
            userIsTypingRef.setValue(newValue)
        }
    }
    
    
    fileprivate func setupBubbles() {
        let factory = JSQMessagesBubbleImageFactory()
        outgoingBubbleImageView = factory?.outgoingMessagesBubbleImage(
            with: UIColor.jsq_messageBubbleBlue())
        incomingBubbleImageView = factory?.incomingMessagesBubbleImage(
            with: UIColor.jsq_messageBubbleLightGray())
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "K Chat"
        tabBarController?.hidesBottomBarWhenPushed = true
        senderId = uid as String
        senderDisplayName = ""
        ref = FIRDatabase.database().reference()
        setupBubbles()
        collectionView!.collectionViewLayout.incomingAvatarViewSize = CGSize.zero
        collectionView!.collectionViewLayout.outgoingAvatarViewSize = CGSize.zero
        
    }
    override func collectionView(_ collectionView: JSQMessagesCollectionView!,
                                 avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return nil
    }
    
    
    
    func addMessage(_ id: String, text: String) {
        let message = JSQMessage(senderId: id, displayName: "", text: text)
        messages.append(message!)
    }
    
    
    
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!,
                                 messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let message = messages[indexPath.item] // 1
        if message.senderId == senderId { // 2
            return outgoingBubbleImageView
        } else { // 3
            return incomingBubbleImageView
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath)
            as! JSQMessagesCollectionViewCell
        
        let message = messages[(indexPath as NSIndexPath).item]
        
        if message.senderId == senderId {
            cell.textView!.textColor = UIColor.white
        } else {
            cell.textView!.textColor = UIColor.black
        }
        
        return cell
    }
    
    
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        let senderRef = self.ref.child("User").child(uid as String).child("Chat").child(uidPartner as String).childByAutoId()
        let recieverRef = self.ref.child("User").child(uidPartner as String).child("Chat").child(uid as String).childByAutoId()
        let msg = [
            "senderId":senderId as NSString,
            "senderText":text as NSString
        ]
        senderRef.setValue(msg)
        recieverRef.setValue(msg)
        self.finishSendingMessage(animated: true)
        self.finishSendingMessage()
        isTyping = false
        
    }
    
    
    func observeMessages(){
      let chatRef =  self.ref.child("User").child(uid as String).child("Chat").child(uidPartner as String).queryLimited(toLast: 25)
        chatRef.observe(.childAdded) { (snap:  FIRDataSnapshot) in
            let snapshot = snap.value as? NSDictionary
            if let string = snapshot?["senderId"] as? String{
                if let text = snapshot?["senderText"] as? String{
                    self.addMessage(string, text: text)
                }
            }
            self.collectionView.reloadData()
            self.finishReceivingMessage(animated: true)
            self.finishReceivingMessage()
            
            
        }
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        observeTyping()
        observeMessages()
    }
    fileprivate func observeTyping() {
        let typingIndicatorRef = self.ref.child("typingIndicator")
        userIsTypingRef = typingIndicatorRef.child(senderId)
        userIsTypingRef.onDisconnectRemoveValue()
        
        // 1
        usersTypingQuery = typingIndicatorRef.queryOrderedByValue().queryEqual(toValue: true)
        
        // 2
        usersTypingQuery.observe(.value) { (data: FIRDataSnapshot) in
            
            // 3 You're the only typing, don't show the indicator
            if data.childrenCount == 1 && self.isTyping {
                return
            }
            
            // 4 Are there others typing?
            self.showTypingIndicator = data.childrenCount > 0
            self.scrollToBottom(animated: true)
        }
        
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!,
                                 messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    override func textViewDidChange(_ textView: UITextView) {
        super.textViewDidChange(textView)
        // If the text is not empty, the user is typing
        isTyping = textView.text != ""
    }
}
