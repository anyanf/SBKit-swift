//
//  UIViewExtensions.swift
//  ankang
//
//  Created by ankang on 2023/7/5.
//

import UIKit


// MARK: - Properties
public extension UIView {

    /// Border color of view; also inspectable from Storyboard.
    @IBInspectable var sb_borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            guard let color = newValue else {
                layer.borderColor = nil
                return
            }
            // Fix React-Native conflict issue
            guard String(describing: type(of: color)) != "__NSCFType" else { return }
            layer.borderColor = color.cgColor
        }
    }

    /// Border width of view; also inspectable from Storyboard.
    @IBInspectable var sb_borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    /// Corner radius of view; also inspectable from Storyboard.
    @IBInspectable var sb_cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = true
            layer.cornerRadius = abs(CGFloat(Int(newValue * 100)) / 100)
        }
    }

    /// Height of view.
    var sb_height: CGFloat {
        get {
            return frame.size.height
        }
        set {
            frame.size.height = newValue
        }
    }

    /// Check if view is in RTL format.
    var sb_isRightToLeft: Bool {
        if #available(tvOS 10.0, *) {
            return effectiveUserInterfaceLayoutDirection == .rightToLeft
        } else {
            return false
        }
    }

    /// Take screenshot of view (if applicable).
    var sb_screenshot: UIImage? {
        UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }

    /// Shadow color of view; also inspectable from Storyboard.
    @IBInspectable var sb_shadowColor: UIColor? {
        get {
            guard let color = layer.shadowColor else { return nil }
            return UIColor(cgColor: color)
        }
        set {
            layer.shadowColor = newValue?.cgColor
        }
    }

    /// Shadow offset of view; also inspectable from Storyboard.
    @IBInspectable var sb_shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    /// Shadow opacity of view; also inspectable from Storyboard.
    @IBInspectable var sb_shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    /// Shadow radius of view; also inspectable from Storyboard.
    @IBInspectable var sb_shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }

    /// Size of view.
    var sb_size: CGSize {
        get {
            return frame.size
        }
        set {
            sb_width = newValue.width
            sb_height = newValue.height
        }
    }

    /// Get view's parent view controller
    var sb_parentViewController: UIViewController? {
        weak var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }

    /// Width of view.
    var sb_width: CGFloat {
        get {
            return frame.size.width
        }
        set {
            frame.size.width = newValue
        }
    }

    /// x origin of view.
    var sb_x: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            frame.origin.x = newValue
        }
    }
    
    /// maxX origin of view.
    var sb_maxX: CGFloat {
        get {
            return frame.maxX
        }
        set {
            frame.origin.x = newValue - frame.width
        }
    }

    /// y origin of view.
    var sb_y: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            frame.origin.y = newValue
        }
    }
    
    /// maxY origin of view.
    var sb_maxY: CGFloat {
        get {
            return frame.maxY
        }
        set {
            frame.origin.y = newValue - frame.height
        }
    }

}

// MARK: - 圆角
public extension UIView {

    struct SBCornerRadius {

        public init() {
            self.init(topLeft: 0, topRight: 0, bottomLeft: 0, bottomRight: 0)
        }

        public init(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
            self.topLeft = topLeft
            self.topRight = topRight
            self.bottomLeft = bottomLeft
            self.bottomRight = bottomRight
        }

        public var topLeft: CGFloat

        public var topRight: CGFloat

        public var bottomLeft: CGFloat

        public var bottomRight: CGFloat
    }

    struct SBCornerRadii {

        public init() {
            self.init(topLeft: CGSize.zero, topRight: CGSize.zero, bottomLeft: CGSize.zero, bottomRight: CGSize.zero)
        }

        public init(topLeft: CGSize, topRight: CGSize, bottomLeft: CGSize, bottomRight: CGSize) {
            self.topLeft = topLeft
            self.topRight = topRight
            self.bottomLeft = bottomLeft
            self.bottomRight = bottomRight
        }

        public var topLeft: CGSize

        public var topRight: CGSize

        public var bottomLeft: CGSize

        public var bottomRight: CGSize
    }
    
    /// 切圆角
    func sb_addCornerRadius(cornerRadius: SBCornerRadius) {
        var shapeLayer = layer.mask as? CAShapeLayer
        if shapeLayer == nil {
            shapeLayer = CAShapeLayer(layer: layer.mask as Any)
            layer.mask = shapeLayer
        }
        let path = UIView .createPath(roundedRect: self.bounds, cornerRadius: cornerRadius)
        shapeLayer?.path = path.cgPath
    }

    /// 切圆角函数绘制线条
    class func createPath(roundedRect rect: CGRect, cornerRadius: SBCornerRadius) -> UIBezierPath {
        
        let minX = rect.minX
        let minY = rect.minY
        let maxX = rect.maxX
        let maxY = rect.maxY
        
        let topLeftCenterX = minX + cornerRadius.topLeft
        let topLeftCenterY = minY + cornerRadius.topLeft;
        
        let topRightCenterX = maxX - cornerRadius.topRight;
        let topRightCenterY = minY + cornerRadius.topRight;
        
        let bottomLeftCenterX = minX +  cornerRadius.bottomLeft;
        let bottomLeftCenterY = maxY - cornerRadius.bottomLeft;
        
        let bottomRightCenterX = maxX -  cornerRadius.bottomRight;
        let bottomRightCenterY = maxY - cornerRadius.bottomRight;
        
        let path = UIBezierPath()
        
        path.addArc(withCenter: CGPoint(x: topLeftCenterX, y: topLeftCenterY),
                    radius: cornerRadius.topLeft,
                    startAngle: Double.pi,
                    endAngle: 3 * Double.pi / 2,
                    clockwise: true)
        
        path.addArc(withCenter: CGPoint(x: topRightCenterX, y: topRightCenterY),
                    radius: cornerRadius.topRight,
                    startAngle: 3 * Double.pi / 2,
                    endAngle: 0,
                    clockwise: true)
        
        path.addArc(withCenter: CGPoint(x: bottomRightCenterX, y: bottomRightCenterY),
                    radius: cornerRadius.bottomRight,
                    startAngle: 0,
                    endAngle: Double.pi / 2,
                    clockwise: true)

        path.addArc(withCenter: CGPoint(x: bottomLeftCenterX, y: bottomLeftCenterY),
                    radius: cornerRadius.bottomLeft,
                    startAngle: Double.pi / 2,
                    endAngle: Double.pi,
                    clockwise: true)
        
        return path

    }
    
}

/// 渐变色设置
public extension UIView {
    
    func addGradientColorLayer(colors: [CGColor]?, locations: [NSNumber]?, frame: CGRect, startPoint: CGPoint, endPoint: CGPoint) -> CAGradientLayer {
        let gradientColorLayer = CAGradientLayer()
        gradientColorLayer.colors = colors
        gradientColorLayer.locations = locations
        gradientColorLayer.frame = frame
        gradientColorLayer.startPoint = startPoint
        gradientColorLayer.endPoint = endPoint
        layer.addSublayer(gradientColorLayer)
        return gradientColorLayer
    }

}

/// 渐变色文字的view
public extension UIView {
    
    func addGradientColorText(text: String?, font: UIFont?, colors: [CGColor]?, locations: [NSNumber]?, startPoint: CGPoint, endPoint: CGPoint) {

        let titleLbl = UILabel(frame: bounds)
        titleLbl.textAlignment = .center
        titleLbl.backgroundColor = UIColor.clear
        titleLbl.font = font
        titleLbl.text = text

        let gradientColorLayer = CAGradientLayer()
        gradientColorLayer.colors = colors
        gradientColorLayer.locations = locations
        gradientColorLayer.frame = bounds
        gradientColorLayer.startPoint = startPoint
        gradientColorLayer.endPoint = endPoint
        layer.addSublayer(gradientColorLayer)
        mask = titleLbl

    }

}
