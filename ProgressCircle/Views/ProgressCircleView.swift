//
//  ProgressCircleView.swift
//  ProgressCircle
//
//  Created by Luis  Costa on 12/02/18.
//  Copyright © 2018 Luis  Costa. All rights reserved.
//

import UIKit

typealias AnimationTypeLabel = CountingLabel.CounterAnimationType
typealias CounterTypeLabel = CountingLabel.CounterType

@IBDesignable
public class ProgressCircleView: UIView {
    
    fileprivate var _startPercentage: CGFloat = 0
    fileprivate var _endPercentage: CGFloat = 75
    fileprivate var _radius: CGFloat!
    fileprivate var _clockwise: Bool = true
    fileprivate var _label: CountingLabel = CountingLabel()
    fileprivate var _strokeColor: UIColor = UIColor.green
    fileprivate var _backgroundStrokeColor: UIColor = UIColor.lightGray
    fileprivate var _strokeLineWidth: CGFloat = 20
    fileprivate var _labelFrame: CGRect = CGRect(x: 0, y: 0, width: 200, height: 100)
    fileprivate var _labelFont: UIFont = UIFont.systemFont(ofSize: 80, weight: .medium)
    fileprivate var _animationTypeLabel: AnimationTypeLabel = .linear
    fileprivate var _counterTypeLabel: CounterTypeLabel = .int
    
    // Constructors
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // Open Properties
    
    open var fontLabel: UIFont {
        set { self._labelFont = newValue }
        get { return _labelFont }
    }

    open var frameLabel: CGRect {
        set { _labelFrame = newValue }
        get { return _labelFrame }
    }
    
    @IBInspectable
    open var startPercentage: CGFloat {
        set { _startPercentage = newValue }
        get { return _startPercentage }
    }
    
    @IBInspectable
    open var endPercentage: CGFloat {
        set { _endPercentage = newValue }
        get { return _endPercentage }
    }

// Only available clockwise for now
//    @IBInspectable
//    open var clockwise: Bool {
//        set { _clockwise = clockwise }
//        get { return _clockwise }
//    }
    
    @IBInspectable
    open var radius: CGFloat {
        set { _radius = newValue }
        get { return _radius }
    }
    
    @IBInspectable
    open var strokeColor: UIColor {
        set {
            _label.textColor = newValue
            _strokeColor = newValue
        }
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
}

// MARK: - Private Functions
extension ProgressCircleView {
    
    fileprivate func setupView() {
        self._radius = frame.width/2 - CGFloat(32)
        self._label.textAlignment = .center
        self._label.textColor = strokeColor
        self._label.frame = CGRect(x: 0, y: 0, width: 200, height: 100)
        self._label.font = UIFont.systemFont(ofSize: 80, weight: .medium)
        self._label.textColor = strokeColor
        self._label.center = self.center
        self.addSubview(_label)
    }
}

// MARK: - Private Functions
extension ProgressCircleView {
    func animate(duration: CFTimeInterval, animated: Bool, animationType: AnimationTypeLabel?, counter: CounterTypeLabel?) {
        
        
        // BackEndPath
        let backgroundPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        let backgroundLayer = CAShapeLayer()
        backgroundLayer.path = backgroundPath.cgPath
        backgroundLayer.strokeColor = strokeBackgroundColor.cgColor
        backgroundLayer.lineWidth = lineWidthStroke
        backgroundLayer.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(backgroundLayer)
        
        let startAngleRadians = startPercentage * 2 * CGFloat.pi / 100 - (CGFloat.pi / 2)
        
        let endAngleRadians = endPercentage * 2 * CGFloat.pi / 100 - (CGFloat.pi / 2)
        
        // Circular Path
        let circularPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngleRadians, endAngle: endAngleRadians, clockwise: true)
        
        // Contour Layer
        let contourLayer = CAShapeLayer()
        contourLayer.path = circularPath.cgPath
        contourLayer.strokeColor = strokeColor.cgColor
        contourLayer.lineWidth = lineWidthStroke
        contourLayer.fillColor = UIColor.clear.cgColor
        contourLayer.strokeEnd = animated ? 0 : 1
        self.layer.addSublayer(contourLayer)
        
        if animated {
            // Animations
            let strokeAnimation = CABasicAnimation(keyPath: "strokeEnd")
            strokeAnimation.toValue = 1
            strokeAnimation.duration = duration
            strokeAnimation.fillMode = kCAFillModeForwards
            strokeAnimation.isRemovedOnCompletion = false
            contourLayer.lineCap = kCALineCapRound
            contourLayer.add(strokeAnimation, forKey: "strokeAnimation")
            
            let counter = counter ?? _counterTypeLabel
            let typeAnimation = animationType ?? _animationTypeLabel
            
            _label.count(fromValue: Float(startPercentage), to: Float(endPercentage) - Float(startPercentage), withDuration: duration, animationType: typeAnimation, counterType: counter)
        } else {
            _label.text = "\(Int(endPercentage - startPercentage))%"
        }
    }
    
}
