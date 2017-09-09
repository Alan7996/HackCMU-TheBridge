//
//  WebViewViewController.swift
//  HackCMU-TheBridge
//
//  Created by 수현 on 9/9/17.
//  Copyright © 2017 AlanLee. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class WebViewViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    
    var urlString = "https://thebridge.cmu.edu/"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.webView.delegate = self
        self.webView.loadRequest(NSURLRequest(url: NSURL(string: urlString)! as URL) as URLRequest!)
    }
    
    @IBAction func backBtnPressed3(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
