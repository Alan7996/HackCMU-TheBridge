//
//  TheBridgeEventTableViewController.swift
//  HackCMU-TheBridge
//
//  Created by 수현 on 9/8/17.
//  Copyright © 2017 AlanLee. All rights reserved.
//

import UIKit
import Kanna
import Alamofire
import WebKit

class TheBridgeEventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate {
    @IBOutlet var webView: UIWebView!
    @IBOutlet weak var eventTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "TheBridge Event List"
        
        self.eventTableView.delegate = self
        self.eventTableView.dataSource = self
        
        self.webView.delegate = self
        let urlString = "https://thebridge.cmu.edu/events"
        self.webView.loadRequest(NSURLRequest(url: NSURL(string: urlString)! as URL) as URLRequest!)
        
        //self.scrapeTheBridge()
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventTableView.dequeueReusableCell(withIdentifier: "theBridgeEventTableViewCell", for: indexPath as IndexPath) as! TheBridgeEventTableViewCell
        
        return cell
    }

    
    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let doc = webView.stringByEvaluatingJavaScript(from: "document.documentElement.outerHTML")! //get it as html
        //doc now has the 'processed HTML'
        self.parseHTML(html: doc)
    }
    
    func parseHTML(html: String) -> Void {
        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            // Search for nodes by CSS selector
            print(html)
            for event in doc.css("span[style^='color: rgb(73, 73, 73)']") {
                // Strip the string of surrounding whitespace
                let eventString = event.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                print(eventString)
            }
        }
    }
}

