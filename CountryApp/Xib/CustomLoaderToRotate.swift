//
//  CustomLoader.swift
//  CountryApp
//
//  Created by Yudiz Solutions Pvt. Ltd. on 12/09/23.
//
import Foundation
import UIKit

class CustomLoaderToRotate : UIView {
    
    @IBOutlet weak var centerView: UIView!
    
    var isAnimating : Bool = false
    var hidesWhenStopped : Bool = true
    lazy private var animationLayer : CALayer = {
        return CALayer()
    }()
    
    class func initwith() -> CustomLoaderToRotate {
        let obj = Bundle.main.loadNibNamed("CustomLoaderToRotate", owner: nil, options: nil)?.first as! CustomLoaderToRotate
        return obj
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let image = UIImage(named: "ic_loader_progress")!
        let frame : CGRect = CGRect(x: 20, y: 20, width: 40, height: 40)
        animationLayer.frame = frame
        animationLayer.contents = image.cgImage
        animationLayer.masksToBounds = true
        centerView.layer.addSublayer(animationLayer)
        addRotation(forLayer: animationLayer)
        pause(layer: animationLayer)
        self.isHidden = true
    }
    
    // MARK - Func
    private func addRotation(forLayer layer : CALayer) {
        let rotation : CABasicAnimation = CABasicAnimation(keyPath:"transform.rotation.z")
        rotation.duration = 1.0
        rotation.isRemovedOnCompletion = false
        rotation.repeatCount = HUGE
        rotation.fillMode = CAMediaTimingFillMode.forwards
        rotation.fromValue = NSNumber(value: 0.0)
        rotation.toValue = NSNumber(value: 3.14 * 2.0)
        layer.add(rotation, forKey: "rotate")
    }
    
    private func pause(layer : CALayer) {
        let pausedTime = layer.convertTime(CACurrentMediaTime(), from: nil)
        layer.speed = 0.0
        layer.timeOffset = pausedTime
        isAnimating = false
    }
    
    func startAnimating () {
        if isAnimating {
            return
        }
        if hidesWhenStopped {
            self.isHidden = false
        }
        resume(layer: animationLayer)
    }
    
    private func resume(layer : CALayer) {
        let pausedTime : CFTimeInterval = layer.timeOffset
        layer.speed = 1.0
        layer.timeOffset = 0.0
        layer.beginTime = 0.0
        let timeSincePause = layer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        layer.beginTime = timeSincePause
        isAnimating = true
    }
    
    func stopAnimating () {
        if hidesWhenStopped {
            self.isHidden = true
        }
        pause(layer: animationLayer)
    }
}
