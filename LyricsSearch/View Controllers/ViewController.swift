//
//  ViewController.swift
//  LyricsSearch
//
//  Created by William Sjahrial on 2022/7/15.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Welcome"
    }

    @IBAction func startButtonTapped(_ sender: Any) {
        performSegue(withIdentifier: "SearchSegue", sender: nil)
    }
    
}

