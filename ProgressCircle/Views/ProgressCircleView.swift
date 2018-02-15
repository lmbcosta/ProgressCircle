//
//  ProgressCircleView.swift
//  ProgressCircle
//
//  Created by Luis  Costa on 12/02/18.
//  Copyright © 2018 Luis  Costa. All rights reserved.
//

import UIKit

@IBDesignable
class ProgressCircleView: UIView {
    
    typealias AnimationTypeLabel = CountingLabel.CounterAnimationType
    typealias CounterTypeLabel = CountingLabel.CounterType
    
    
    fileprivate var _startAngle: CGFloat = 0
    fileprivate var _endAngle: CGFloat = 270
    fileprivate var _radius: CGFloat!
    fileprivate var _clockwise: Bool = true
    fileprivate var _strokeColor: UIColor = UIColor.green
    fileprivate var _backgroundStrokeColor: UIColor = UIColor.lightGray
    fileprivate var _strokeLineWidth: CGFloat = 20
    
    fileprivate lazy var _label: CountingLabel = setupLabel()
    fileprivate var _labelFrame: CGRect = CGRect(x: 0, y: 0, width: 120, height: 48)
    
    fileprivate var _animationTypeLabel: AnimationTypeLabel = .linear
    fileprivate var _counterTypeLabel: CounterTypeLabel = .int
    
    // Constructors
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // Open Properties
    
    @IBInspectable
    open var startAngleInDegrees: CGFloat {
        set { _startAngle = newValue }
        get { return _startAngle }
    }
    
    @IBInspectable
    open var endAngleInDegrees: CGFloat {
        set { _endAngle = newValue }
        get { return _endAngle }
    }
    
    @IBInspectable
    open var clockwise: Bool {
        set { _clockwise = clockwise }
        get { return _clockwise }
    }
    
    @IBInspectable
    open var radius: CGFloat {
        set { _radius = newValue }
        get { return _radius }
    }
    
    @IBInspectable
    open var strokeColor: UIColor {
        set { _strokeColor = newValue }
        get { return _strokeColor }
    }
    
    @IBInspectable
    open var strokeBackgroundColor: UIColor {
        set { _backgroundStrokeColor = newValue }
        get { return _backgroundStrokeColor }
    }
    
    @IBInspectable
    open var textLabel: String? {
        set { _label.text = newValue }
        get { return _label.text }
    }
    
    @IBInspectable
    open var fontLabel: UIFont {
        set { _label.font = newValue }
        get { return _label.font }
    }
    
    @IBInspectable
    open var textAlignmentLabel: NSTextAlignment {
        set { _label.textAlignment = newValue  }
        get { return _label.textAlignment }
    }
    
    @IBInspectable
    open var textColorLabel: UIColor {
        set { _label.textColor = newValue }
        get { return _label.textColor }
    }
    
    @IBInspectable
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
    
    fileprivate func setupView() {
        self._radius = frame.width/2 - CGFloat(32)
        
    }
    
    fileprivate func setupLabel() -> CountingLabel {
        let label = CountingLabel()
        label.frame = CGRect(x: 0, y: 0, width: 240, height: 100)
        label.center = self.center
        label.font = UIFont.systemFont(ofSize: 80, weight: .medium)
        label.textAlignment = .center
        label.textColor = .green
        label.text = "0%"
        self.addSubview(label)
        return label
    }
}

// MARK: - Private Functions
extension ProgressCircleView {
    func animate(duration: CFTimeInterval) {
        
        // BackEndPath
        let backgroundPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        let backgroundLayer = CAShapeLayer()
        backgroundLayer.path = backgroundPath.cgPath
        backgroundLayer.strokeColor = strokeBackgroundColor.cgColor
        backgroundLayer.lineWidth = lineWidthStroke
        backgroundLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(backgroundLayer)
        
        let startAngleRadians = (startAngleInDegrees - 90) * CGFloat.pi * 2 / 360
        let endAngleRadians = (endAngleInDegrees - 90) * CGFloat.pi * 2 / 360 * 1
        
        // Circular Path
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngleRadians, endAngle: endAngleRadians, clockwise: true)

        // Contour Layer
        let contourLayer = CAShapeLayer()
        contourLayer.path = circularPath.cgPath
        contourLayer.strokeColor = strokeColor.cgColor
        contourLayer.lineWidth = lineWidthStroke
        contourLayer.fillColor = UIColor.clear.cgColor
        contourLayer.strokeEnd = 0
        self.layer.addSublayer(contourLayer)
        
        
        // Animations
        let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
        strokeAnimation.toValue = 1
        strokeAnimation.duration = duration
        strokeAnimation.fillMode = kCAFillModeForwards
        strokeAnimation.isRemovedOnCompletion = false
        contourLayer.lineCap = kCALineCapRound
        contourLayer.add(strokeAnimation, forKey: "strokeAnimation")
        
        
        let startPercentage = Float(0) * 100 / 360
        let endPercentage = Float(270) * 100 / 360
        
        self._label.count(fromValue: startPercentage, to: endPercentage, withDuration: duration, animationType: .linear, counterType: .int)
    }
    
}
