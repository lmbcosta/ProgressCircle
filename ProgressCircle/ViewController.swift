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
        progressBar.strokeColor = .red
        progressBar.strokeBackgroundColor = .lightGray
        
        let labelFrame = CGRect(x: 0, y: 0, width: 220, height: 100)
        progressBar.frameLabel = labelFrame
        progressBar.fontLabel = UIFont.systemFont(ofSize: 80, weight: .medium)
        progressBar.startPercentage = 50
        progressBar.endPercentage = 90
        
        self.view.addSubview(progressBar)
        
        progressBar.animate(duration: 1, animated: true, animationType: .easeIn , counter: .int)
    }
}

