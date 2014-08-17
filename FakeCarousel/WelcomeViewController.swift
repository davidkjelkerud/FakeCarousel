//
//  WelcomeViewController.swift
//  FakeCarousel
//
//  Created by David Kjelkerud on 8/16/14.
//  Copyright (c) 2014 David Kjelkerud. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var welcomeOneImageView: UIImageView!
    @IBOutlet weak var welcomeTwoImageView: UIImageView!
    @IBOutlet weak var welcomeThreeImageView: UIImageView!
    @IBOutlet weak var welcomeFourImageView: UIImageView!
    @IBOutlet weak var continueFormContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        
        var imageViewWidth = welcomeOneImageView.frame.width + welcomeTwoImageView.frame.width + welcomeThreeImageView.frame.width + welcomeFourImageView.frame.width
        
        scrollView.contentSize = CGSize(width: imageViewWidth, height: welcomeOneImageView.image.size.height)
        
        continueFormContainer.alpha = 0.0
        println("center y: \(continueFormContainer.center.y)")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        UIView.animateWithDuration(0.1, animations: {
            self.continueFormContainer.center.y = 530

            self.continueFormContainer.alpha = 0
            self.pageControl.alpha = 1
        })
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        var page = Int(scrollView.contentOffset.x / 320)
        self.pageControl.currentPage = page
        
        if (page == 3) {
            UIView.animateWithDuration(0.2, animations: {
                self.continueFormContainer.alpha = 1.0
                self.continueFormContainer.center.y -= 30
                self.pageControl.alpha = 0
            })
        }
        
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
