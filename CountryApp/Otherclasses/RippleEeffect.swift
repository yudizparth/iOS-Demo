//
//  RippleEeffect.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 28/09/23.
//

import UIKit

class RippleView: UIView {

    // MARK: - Properties

    var rippleColor: UIColor = UIColor.blue.withAlphaComponent(0.5)
    var rippleRadius: CGFloat = 50.0

    // MARK: - Init

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    private func commonInit() {
        // Add tap gesture recognizer
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        addGestureRecognizer(tapGesture)
    }

    // MARK: - Touch Handling

    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
        // Get the tap location
        let tapLocation = sender.location(in: self)

        // Create a ripple layer
        let rippleLayer = CAShapeLayer()
        let rippleSize = rippleRadius * 2
        let ripplePath = UIBezierPath(ovalIn: CGRect(x: tapLocation.x - rippleRadius, y: tapLocation.y - rippleRadius, width: rippleSize, height: rippleSize))

        rippleLayer.path = ripplePath.cgPath
        rippleLayer.fillColor = rippleColor.cgColor
        rippleLayer.opacity = 0.5
        layer.addSublayer(rippleLayer)

        // Animate the ripple effect
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 0
        scaleAnimation.toValue = 1
        scaleAnimation.duration = 0.3
        rippleLayer.add(scaleAnimation, forKey: nil)

        // Remove the ripple layer after the animation completes
        DispatchQueue.main.asyncAfter(deadline: .now() + scaleAnimation.duration + 0.1) {
            rippleLayer.removeFromSuperlayer()
        }
    }
}



