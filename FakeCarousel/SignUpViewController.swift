//
//  SignUpViewController.swift
//  FakeCarousel
//
//  Created by David Kjelkerud on 8/16/14.
//  Copyright (c) 2014 David Kjelkerud. All rights reserved.
//

import UIKit
import WebKit

class SignUpViewController: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var buttonContainerView: UIView!
    @IBOutlet weak var termsCheckButton: UIButton!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var formContainerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    
        scrollView.delegate = self
    
        // Set form element to scale 0 so we can animate them
        formContainerView.transform = CGAffineTransformMakeScale(0, 0)
        buttonContainerView.transform = CGAffineTransformMakeScale(0, 0)
        
        // Subscribe to keyboard events
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
            scrollView.center.y -= 80
            scrollView.contentInset.bottom = CGFloat(540)
            buttonContainerView.center.y -= 110
        }
    }

    func keyboardWillHide(notification: NSNotification!) {
        scrollView.center.y += 80
        scrollView.contentInset.bottom = CGFloat(20)
        buttonContainerView.center.y += 110
    }
    
    @IBAction func onClickBack(sender: AnyObject) {
        navigationController.popViewControllerAnimated(true)
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func onClickTermsCheck(sender: AnyObject) {
        termsCheckButton.selected = !termsCheckButton.selected
    }

    @IBAction func onClickCreateButton(sender: AnyObject) {
        if (self.firstNameTextField.text.isEmpty || self.lastNameTextField.text.isEmpty || self.emailTextField.text.isEmpty || self.passwordTextField.text.isEmpty) {
            
            UIAlertView(title: "MOAR DATA", message: "Enter your first name, last name, email and password to create an account.", delegate: nil, cancelButtonTitle: "OK").show()
        } else if (self.termsCheckButton.selected == false) {
            UIAlertView(title: "Agree to terms of service", message: "You need to agree to the terms of service before you create an account", delegate: nil, cancelButtonTitle: "OK").show()
        } else {
            createAccount()
        }
        
    }
    
    func createAccount() {
        //show loading view
        view.endEditing(true)
        self.performSegueWithIdentifier("createWelcomeSegue", sender: self)
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
