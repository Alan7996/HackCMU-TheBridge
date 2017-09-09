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
    
    var row = 0
    
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
        
        cell.layer.borderWidth = 2.0
        cell.layer.borderColor = UIColor.black.cgColor
        cell.separatorInset = UIEdgeInsets.zero
        
        return cell
    }

    // method to run when table view cell is tapped
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        row = indexPath.row
        performSegue(withIdentifier: "orgWebSegue", sender: nil)
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
            
            if let docu = Kanna.HTML(html: doc.innerHTML!, encoding: String.Encoding.utf8) {
                let bodyNode = docu.body
                
                if let inputNodes = bodyNode?.xpath("//a[contains(@href,'/organization/')]/@href") {
                    for node in inputNodes {
                        orgArray[1].append(node.content!)
                    }
                }
            }

            
            print(orgArray)
        }
        self.orgTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            if identifier == "orgWebSegue" {
                let webViewViewController = segue.destination as! WebViewViewController
                
                webViewViewController.urlString = "https://thebridge.cmu.edu" + orgArray[1][row]
            }
        }
    }
    
    @IBAction func backBtnPressed2(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
