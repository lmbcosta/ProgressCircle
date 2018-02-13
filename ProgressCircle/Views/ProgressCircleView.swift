//
//  ProgressCircleView.swift
//  ProgressCircle
//
//  Created by Luis  Costa on 12/02/18.
//  Copyright © 2018 Luis  Costa. All rights reserved.
//

import UIKit

class ProgressCircleView: UIView {
    
    typealias AnimationTypeLabel = CountingLabel.CounterAnimationType
    typealias CounterTypeLabel = CountingLabel.CounterType
    

    fileprivate var _startAngle: CGFloat = 0
    fileprivate var _endAngle: CGFloat = 2 * CGFloat.pi
    fileprivate var _radius: CGFloat = 20
    fileprivate var _clockwise: Bool = true
    fileprivate var _strokeColor: UIColor = UIColor.green
    fileprivate var _backgroundStrokeColor: UIColor = UIColor.lightGray
    fileprivate var _strokeLineWidth: CGFloat = 18
    
    fileprivate lazy var _label: CountingLabel = setupLabel()
    fileprivate var _labelFrame: CGRect = CGRect(x: 0, y: 0, width: 120, height: 48)
    
    fileprivate var _animationTypeLabel: AnimationTypeLabel = .linear
    fileprivate var _counterTypeLabel: CounterTypeLabel = .int
    
    // Constructors
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Open Properties
    open var startAngleInDegrees: CGFloat {
        set { _startAngle = newValue }
        get { return _startAngle }
    }
    
    open var endAngleInDegrees: CGFloat {
        set { _endAngle = newValue }
        get { return _endAngle }
    }
    
    open var clockwise: Bool {
        set { _clockwise = clockwise }
        get { return _clockwise }
    }
    
    open var radius: CGFloat {
        set { _radius = newValue }
        get { return _radius }
    }
    
    open var strokeColor: UIColor {
        set { _strokeColor = newValue }
        get { return _strokeColor }
    }
    
    open var strokeBackgroundColor: UIColor {
        set { _backgroundStrokeColor = newValue }
        get { return _backgroundStrokeColor }
    }
    
    open var textLabel: String? {
        set { _label.text = newValue }
        get { return _label.text }
    }
    
    open var fontLabel: UIFont {
        set { _label.font = newValue }
        get { return _label.font }
    }
    
    open var textAlignmentLabel: NSTextAlignment {
        set { _label.textAlignment = newValue  }
        get { return _label.textAlignment }
    }
    
    open var textColorLabel: UIColor {
        set { _label.textColor = newValue }
        get { return _label.textColor }
    }
    
    open var lineWidthStroke: CGFloat {
        set { _strokeLineWidth = newValue }
        get { return _strokeLineWidth }
    }
    
    open var animationTypeLabel: AnimationTypeLabel {
        set { self._animationTypeLabel = newValue }
        get { return _animationTypeLabel }
    }
    
    open var counterTypeLabel: CounterTypeLabel {
        set { self._counterTypeLabel = newValue }
        get { return _counterTypeLabel }
    }
}

// MARK: - Private Functions
extension ProgressCircleView {
    fileprivate func setupLabel() -> CountingLabel {
        let label = CountingLabel()
        label.font = UIFont.systemFont(ofSize: 40, weight: .medium)
        label.textAlignment = .center
        label.textColor = .green
        label.text = "0%"
        
        return label
    }
}

// MARK: - Private Functions
extension ProgressCircleView {
    func animate(duration: CFTimeInterval, withDelay: CFTimeInterval) {
        
        // Angles
        let startAngleRadians = startAngleInDegrees * CGFloat.pi * 2 / 360
        let endAngleRadians = endAngleInDegrees * CGFloat.pi * 2 / 360
        let startAngle = clockwise ? startAngleRadians : -1 * startAngleRadians
        let endAngle = clockwise ? endAngleRadians : -1 * endAngleRadians
        
        // Circular Path
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: clockwise)
        
        // Contour Layer
        let contourLayer = CAShapeLayer()
        contourLayer.path = circularPath.cgPath
        contourLayer.strokeColor = strokeBackgroundColor.cgColor
        contourLayer.lineWidth = lineWidthStroke
        contourLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(contourLayer)
        
        // Stroke Path
        let strokePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: clockwise)
        
        // Stroke Layer
        let strokeLayer = CAShapeLayer()
        strokeLayer.path = strokePath.cgPath
        strokeLayer.strokeEnd = 0
        strokePath.lineWidth = lineWidthStroke
        strokeLayer.strokeColor = strokeColor.cgColor
        self.layer.addSublayer(strokeLayer)
        
        // Animations
        DispatchQueue.main.asyncAfter(deadline: .now() + withDelay) { [weak self] in
            // Stroke animation
            let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
            strokeAnimation.toValue = 1
            strokeAnimation.duration = duration
            strokeAnimation.fillMode = kCAFillModeForwards
            strokeAnimation.isRemovedOnCompletion = false
            strokeLayer.lineCap = kCALineCapRound
            strokeLayer.add(strokeAnimation, forKey: "strokeAnimation")
            
            let startPercentage = (self?.startAngleInDegrees)! * 100 / 360
            let endPercentage = (self?.endAngleInDegrees)! * 100 / 360
            
            self?._label.count(fromValue: Float(startPercentage), to: Float(endPercentage), withDuration: duration, animationType: .easeOut, counterType: CountingLabel.CounterType.int)
        }
    }

}
