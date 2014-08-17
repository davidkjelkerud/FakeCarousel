//
//  SignInViewController.swift
//  FakeCarousel
//
//  Created by David Kjelkerud on 8/16/14.
//  Copyright (c) 2014 David Kjelkerud. All rights reserved.
//

import UIKit
import QuartzCore

class SignInViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var formContainerView: UIView!
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loadingView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingView.hidden = true
        
        // Set form element to scale 0 so we can animate them
        formContainerView.transform = CGAffineTransformMakeScale(0, 0)
        buttonContainerView.transform = CGAffineTransformMakeScale(0, 0)        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        UIView.animateWithDuration(0.4, animations: {
            self.formContainerView.transform = CGAffineTransformMakeScale(1, 1)
            self.buttonContainerView.transform = CGAffineTransformMakeScale(1, 1)
        })
    }

    func keyboardWillShow(notification: NSNotification!) {
        println("Keyboard will show")
        
        var userInfo = notification.userInfo
        var beganKbRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as NSValue).CGRectValue()
        var endKbRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as NSValue).CGRectValue()
        
        println("keyboard began frame: \(beganKbRect.origin.y)")
        println("keyboard end frame: \(endKbRect.origin.y)")

        
        if (beganKbRect.origin.y == 568) {
            formContainerView.center.y -= 100
            buttonContainerView.center.y -= 250
        }
    }
    
    func keyboardWillHide(notification: NSNotification!) {
        println("Keyboard will hide")
        
        formContainerView.center.y += 100
        buttonContainerView.center.y += 250
    }

    @IBAction func onClickBack(sender: AnyObject) {
        navigationController.popViewControllerAnimated(true)
    }

    @IBAction func onClickSignIn(sender: AnyObject) {
        if (self.emailTextField.text.isEmpty || self.passwordTextField.text.isEmpty) {
            UIAlertView(title: "DATA IS REQUIRED YO", message: "Enter your email and password to sign in.", delegate: nil, cancelButtonTitle: "OK").show()
        } else {
            login()
        }
    }

    func login() {
        //show loading view
        loadingView.hidden = false
        view.endEditing(true)
        
        delay(2) {
            if self.emailTextField.text == "user" && self.passwordTextField.text == "password" {
                self.performSegueWithIdentifier("welcomeSegue", sender: self)
            } else {
                self.loadingView.hidden = true
                
                UIAlertView(title: "Oops", message: "Wrong password", delegate: nil, cancelButtonTitle: "OK").show()
            }
        }
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func onPan(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
