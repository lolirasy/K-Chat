//
//  ViewController.swift
//  Khmer-Social News
//
//  Created by ភី ម៉ារ៉ាសុី on 7/28/16.
//  Copyright © 2016 ភី ម៉ារ៉ាសុី. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var btnRegister: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setButton(btnLogin)
        setButton(btnRegister)
        
        
        
        
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.alpha = 0.7
        
        
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let background = UIImageView(frame: CGRect(x: 0,y: 0,width: width,height: height))
        background.image = UIImage(named: "background2")
        background.contentMode = UIViewContentMode.scaleAspectFill
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.alpha = 0.5
        //always fill the view
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        imageView.addSubview(blurEffectView)
        background.addSubview(blurEffectView)
        
        //  self.view.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed

        self.view.addSubview(background)
        self.view.sendSubview(toBack: background)
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background.png")!)
        NotificationCenter.default.addObserver(self,
                                                         selector: #selector(ViewController.clearBlurEffect(_:)),
                                                         name: NSNotification.Name(rawValue: "popUpDidClose"),
                                                         object: nil
            
            
        )
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    func setButton(_ button: UIButton){
        button.backgroundColor = UIColor.clear
        button.layer.cornerRadius = button.frame.size.width / 2
        button.layer.masksToBounds = true
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        
        //button.layer.borderColor = CGColor(UIColor.whiteColor())
      //  button.layer.opacity = 0.2
        
    }
    @IBAction func buttonClicked(_ sender: UIButton){
        switch sender {
        case btnRegister:
            animateButton(btnRegister)
        case btnLogin:
            animateButton(btnLogin)
           // delay(1000)
            
        default:
            break;
        }
        if !UIAccessibilityIsReduceTransparencyEnabled() {
            // self.view.backgroundColor = UIColor.clearColor()
            
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            //always fill the view
            blurEffectView.frame = self.view.bounds
            blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            blurEffectView.alpha = 0.7
            
            self.view.addSubview(blurEffectView) //if you have more UIViews, use an insertSubview API to place it where needed
        } else {
            // self.view.backgroundColor = UIColor.blackColor()
        }

        
    }
    func clearBlurEffect(_ sender: Notification) {
        DispatchQueue.main.async { [unowned self] in
            for subview in self.view.subviews as [UIView] {
                if let v = subview as? UIVisualEffectView {
                    v.removeFromSuperview()
                    self.reverseAnimate(self.btnLogin)
                    self.reverseAnimate(self.btnRegister)
                    //self.view.backgroundColor = UIColor.clearColor()
                }
            }
        }
    }
    func reverseAnimate(_ button: UIButton){
        
        
        UIView.animate(withDuration: 0.5, animations: {
            button.frame = CGRect(x: button.frame.origin.x, y: button.frame.origin.y + 25, width: button.frame.size.width, height: button.frame.size.height)
            button.layer.opacity = 10
            //self.performSegueWithIdentifier("loginSegue", sender: self)
        })

    }

    func animateButton(_ button: UIButton){
        UIView.animate(withDuration: 0.5, animations: {
            button.frame = CGRect(x: button.frame.origin.x, y: button.frame.origin.y - 25, width: button.frame.size.width, height: button.frame.size.height)
            button.layer.opacity = 0.1
            //self.performSegueWithIdentifier("loginSegue", sender: self)
        })
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

