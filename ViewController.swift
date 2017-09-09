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

class ViewController: UIViewController {
    @IBOutlet weak var eventsBtn: UIButton!
    @IBOutlet weak var orgBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsBtn.layer.cornerRadius = 5
        eventsBtn.layer.borderWidth = 1
        eventsBtn.layer.borderColor = UIColor.black.cgColor
            
        orgBtn.layer.cornerRadius = 5
        orgBtn.layer.borderWidth = 1
        orgBtn.layer.borderColor = UIColor.black.cgColor
    }
}
