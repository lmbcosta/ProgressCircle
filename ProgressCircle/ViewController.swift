//
//  ViewController.swift
//  ProgressCircle
//
//  Created by Luis  Costa on 12/02/18.
//  Copyright © 2018 Luis  Costa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var topCircle: ProgressCircleView!
    @IBOutlet weak var middleCircle: ProgressCircleView!
    @IBOutlet weak var bottomCircle: ProgressCircleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topCircle.strokeColor = .red
        topCircle.strokeBackgroundColor = .lightGray
        let labelFrame = CGRect(x: 0, y: 0, width: 100, height: 80)
        topCircle.frameLabel = labelFrame
        topCircle.fontLabel = UIFont.systemFont(ofSize: 40, weight: .medium)
        topCircle.startPercentage = 25
        topCircle.endPercentage = 87
        topCircle.lineWidthStroke = 14
        
        middleCircle.strokeColor = .green
        middleCircle.strokeBackgroundColor = .darkGray
        middleCircle.frameLabel = CGRect(x: 0, y: 0, width: 120, height: 80)
        middleCircle.fontLabel = UIFont.systemFont(ofSize: 30, weight: .bold)
        middleCircle.startPercentage = 0
        middleCircle.endPercentage = 47
        middleCircle.lineWidthStroke = 14
        
        bottomCircle.strokeColor = .blue
        bottomCircle.strokeBackgroundColor = .lightGray
        bottomCircle.frameLabel = CGRect(x: 0, y: 0, width: 30, height: 18)
        bottomCircle.fontLabel = UIFont.systemFont(ofSize: 8, weight: .light)
        bottomCircle.startPercentage = 0
        bottomCircle.endPercentage = 100
        bottomCircle.lineWidthStroke = 8
    }
    
    // MARK: - Action
    @IBAction func buttonTapped(_ sender: Any) {
        // Top Circle
        topCircle.animate(duration: 1.3, animated: true, animationType: .easeIn, counter: .int)
        // Middle Circle
        middleCircle.animate(duration: 1, animated: true, animationType: .easeOut, counter: .float)
        // Bottom Circle
        bottomCircle.animate(duration: 4, animated: true, animationType: .linear, counter: .int)
    }
}


