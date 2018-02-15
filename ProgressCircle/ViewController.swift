//
//  ViewController.swift
//  ProgressCircle
//
//  Created by Luis  Costa on 12/02/18.
//  Copyright © 2018 Luis  Costa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let progressBar = ProgressCircleView(frame: self.view.bounds)
        self.view.addSubview(progressBar)
        
        
        progressBar.animate(duration: 1.5)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

