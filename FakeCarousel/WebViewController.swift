//
//  WebViewController.swift
//  FakeCarousel
//
//  Created by David Kjelkerud on 8/16/14.
//  Copyright (c) 2014 David Kjelkerud. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: UIWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        var url = NSURL.URLWithString("https://www.dropbox.com/terms?mobile=1")
        var request = NSURLRequest(URL: url)
        webView.loadRequest(request)
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onClickBack(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
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
