//
//  ViewController.swift
//  ApiManager
//
//  Created by Арген on 11.06.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Session.shared.getUser { user in
            
        }
        
    }
 
}

