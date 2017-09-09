//
//  TheBridgeOrgViewController.swift
//  HackCMU-TheBridge
//
//  Created by 수현 on 9/9/17.
//  Copyright © 2017 AlanLee. All rights reserved.
//

import UIKit
import Kanna
import WebKit

class TheBridgeOrgViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIWebViewDelegate {
    @IBOutlet var webView: UIWebView!
    @IBOutlet weak var orgTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.orgTableView.delegate = self
        self.orgTableView.dataSource = self
        self.orgTableView.separatorStyle = UITableViewCellSeparatorStyle.none
        
        self.webView.delegate = self
        let urlString = "https://thebridge.cmu.edu/organizations"
        self.webView.loadRequest(NSURLRequest(url: NSURL(string: urlString)! as URL) as URLRequest!)
    }
    
    // number of rows in table view
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orgArray[0].count
    }
    
    // create a cell for each table view row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = orgTableView.dequeueReusableCell(withIdentifier: "theBridgeOrgTableViewCell", for: indexPath as IndexPath) as! TheBridgeOrgTableViewCell
        
        cell.orgNameLabel.text = orgArray[0][indexPath.row]
        //cell.orgInfoLabel.text = orgArray[1][indexPath.row]
        
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.black.cgColor
        cell.separatorInset = UIEdgeInsets.zero
        
        return cell
    }

    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        let doc = webView.stringByEvaluatingJavaScript(from: "document.documentElement.outerHTML")! //get it as html
        //doc now has the 'processed HTML'
        print(doc)
        self.parseHTML(html: doc)
    }
    
    func parseHTML(html: String) -> Void {
        if let doc = Kanna.HTML(html: html, encoding: String.Encoding.utf8) {
            // Search for nodes by CSS selector
//            print(html)
            var n = 0
            let bodyNode = doc.body
            
            if let inputNodes = bodyNode?.xpath("//div") {
                for node in inputNodes {
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
            print(orgArray)
        }
        self.orgTableView.reloadData()
    }
    
    @IBAction func backBtnPressed2(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
