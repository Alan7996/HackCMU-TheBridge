//
//  TheBridgeEventTableViewController.swift
//  HackCMU-TheBridge
//
//  Created by 수현 on 9/8/17.
//  Copyright © 2017 AlanLee. All rights reserved.
//

import UIKit
import Kanna
import WebKit

class TheBridgeEventViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate {
    @IBOutlet var webView: UIWebView!
    @IBOutlet weak var eventTableView: UITableView!
    
    var eventsArray:[[String]] = [[], [], [], []]
    
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
        return eventsArray[0].count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = eventTableView.dequeueReusableCell(withIdentifier: "theBridgeEventTableViewCell", for: indexPath as IndexPath) as! TheBridgeEventTableViewCell
        
        cell.eventNameLabel.text = eventsArray[0][indexPath.row]
        cell.eventDateLabel.text = eventsArray[1][indexPath.row]
        cell.eventPlaceLabel.text = eventsArray[2][indexPath.row]
        cell.eventTypeLabel.text = eventsArray[3][indexPath.row]
        
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
            var n = 0
            for event in doc.css("span[style^='color: rgb(73, 73, 73); display: block; font-size: 18px; font-weight: 600; white-space: nowrap; text-overflow: ellipsis; overflow: hidden; width: 90%; position: absolute;']") {
                // Strip the string of surrounding whitespace
                let eventNameString = event.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                if eventNameString != "" {
                    eventsArray[0].append(eventNameString)
//                    print(eventNameString)
                    
                    n += 1
                }
            }
            
            // Reset counter
            n = 0
            
            for event in doc.css("div[style^='white-space: nowrap; text-overflow: ellipsis; overflow: hidden;']") {
                // Strip the string of surrounding whitespace
                let eventDateString = event.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                if eventDateString != "" {
                    eventsArray[1].append(eventDateString)
//                    print(eventDateString)
                    
                    n += 1
                }
            }
            
            // Reset counter
            n = 0
            
            for event in doc.css("div[style^='font-style: italic; white-space: nowrap; text-overflow: ellipsis; overflow: hidden;']") {
                // Strip the string of surrounding whitespace
                var eventPlaceString = event.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                if eventPlaceString != "" {
                    if eventPlaceString == "Email will be sent to those that sign up for further details on where to meet on campus before leaving" {
                        eventPlaceString = "TBA"
                    }
                    eventsArray[2].append(eventPlaceString)
//                    print(eventPlaceString)
                    
                    n += 1
                }
            }
            
            // Reset counter
            n = 0
            
            for event in doc.css("span[style^='position: relative; top: -8px;']") {
                // Strip the string of surrounding whitespace
                let eventTypeString = event.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                
                if eventTypeString != "" {
                    eventsArray[3].append(eventTypeString)
//                    print(eventTypeString)
                    
                    n += 1
                }
            }
            
            print(eventsArray)
        }
        
        self.eventTableView.reloadData()
    }
}

