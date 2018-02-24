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
    @IBOutlet weak var centerCircle: ProgressCircleView!
    @IBOutlet weak var bottomCircle: ProgressCircleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Top Circle
        topCircle.strokeColor = .red
        topCircle.backgroundStrokeColor = .lightGray
        topCircle.labelSize = CGSize(width: 100, height: 80)
        topCircle.labelFont = UIFont.systemFont(ofSize: 40, weight: .medium)
        topCircle.startPercentage = 25
        topCircle.endPercentage = 87
        topCircle.lineWidthStroke = 14
        
        // Center Circle
        centerCircle.strokeColor = .green
        centerCircle.backgroundStrokeColor = .darkGray
        centerCircle.labelSize = CGSize(width: 120, height: 80)
        centerCircle.labelFont = UIFont.systemFont(ofSize: 30, weight: .bold)
        centerCircle.startPercentage = 0
        centerCircle.endPercentage = 47
        centerCircle.lineWidthStroke = 14
        
        // Bottom Circle
        bottomCircle.strokeColor = .blue
        bottomCircle.backgroundStrokeColor = .lightGray
        bottomCircle.labelSize = CGSize(width: 30, height: 18)
        bottomCircle.labelFont = UIFont.systemFont(ofSize: 8, weight: .light)
        bottomCircle.startPercentage = 0
        bottomCircle.endPercentage = 100
        bottomCircle.lineWidthStroke = 8
    }
    
    // MARK: - Action
    @IBAction func buttonTapped(_ sender: Any) {
        // Top Circle
        topCircle.animate(duration: 1.3, animated: true, animationType: .easeIn, counter: .int)
        // Center Circle
        centerCircle.animate(duration: 1, animated: true, animationType: .easeOut, counter: .float)
        // Bottom Circle
        bottomCircle.animate(duration: 4, animated: true, animationType: .linear, counter: .int)
    }
}


