//
//  ViewController.swift
//  HackCMU-TheBridge
//
//  Created by 수현 on 9/8/17.
//  Copyright © 2017 AlanLee. All rights reserved.
//

import UIKit
import Kanna
import WebKit

var eventsArray:[[String]] = [[], [], [], [], []]
var orgArray:[[String]] = [[], []]

class ViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var eventsBtn: UIButton!
    @IBOutlet weak var orgBtn: UIButton!
    @IBOutlet weak var webView1: UIWebView!
    
    var urlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsBtn.layer.cornerRadius = 5
        eventsBtn.layer.borderWidth = 1
        eventsBtn.layer.borderColor = UIColor.black.cgColor
            
        orgBtn.layer.cornerRadius = 5
        orgBtn.layer.borderWidth = 1
        orgBtn.layer.borderColor = UIColor.black.cgColor
        
        self.webView1.delegate = self
        urlString = "https://thebridge.cmu.edu/events"
//        self.webView1.loadRequest(NSURLRequest(url: NSURL(string: urlString)! as URL) as URLRequest!)
    }
    /*
    func webViewDidFinishLoad(_ webView: UIWebView) {
        //doc now has the 'processed HTML'
        let doc = webView.stringByEvaluatingJavaScript(from: "document.documentElement.outerHTML")! //get it as html
        if urlString == "https://thebridge.cmu.edu/events" {
            self.parseHTML(html: doc)
        }
        if urlString == "https://thebridge.cmu.edu/organizations" {
            print(doc)
            self.parseHTML2(html: doc)
        }
    }
    
    func parseHTML(html: String) -> Void {
        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            // Search for nodes by CSS selector
//            print(html)
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
        urlString = "https://thebridge.cmu.edu/organizations"
//        self.webView1.loadRequest(NSURLRequest(url: NSURL(string: urlString)! as URL) as URLRequest!)
    }
    
    func parseHTML2(html: String) -> Void {
        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            // Search for nodes by CSS selector
            print(html)
            let bodyNode = doc.body
//            print(bodyNode!.content)
            if let inputNodes = bodyNode?.xpath("//div") {
                for node in inputNodes {
//                    print(node.content!)
                    if node.content! != "" && node.content!.hasPrefix(" ") {
                        if node.content!.hasPrefix(" Organizations") == false {
                            if node.content!.hasSuffix("Load More") == false {
                                if node.content!.hasPrefix(" (") == false {
                                    if node.content!.characters.count <= 30 {
                                        if orgArray[0].contains(node.content!) == false {
                                            orgArray[0].append(node.content!)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            print(orgArray)
            /*
             if let inputNodes = bodyNode?.xpath("//p") {
             for node in inputNodes {
             print(node.content!)
             }
             }*/
            /*
             for org in doc.css("div[style^='color: rgb(255, 255, 255); background-color: rgb(188, 188, 188); display: inline-flex; align-items: center; justify-content: center; font-size: 37.5px; border-top-left-radius: 50%; border-top-right-radius: 50%; border-bottom-right-radius: 50%; border-bottom-left-radius: 50%; height: 75px; width: 75px; position: absolute; top: 9px; left: 13px; margin: 8px; background-size: 55px; -webkit-user-select: none;']") {
             // Strip the string of surrounding whitespace
             let orgNameString = org.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
             
             if orgNameString != "" {
             orgArray[0].append(orgNameString)
             //                    print(orgNameString)
             
             n += 1
             }
             }
             
             // Reset counter
             n = 0
             */
            /*for org in doc.css("p[class^='DescriptionExcerpt']") {
             print(org.text!)
             // Strip the string of surrounding whitespace
             let orgInfoString = org.text!.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
             
             if orgInfoString != "" {
             orgArray[1].append(orgInfoString)
             //                    print(orgInfoString)
             
             n += 1
             }
             }*/
        }
    }
*/
}
