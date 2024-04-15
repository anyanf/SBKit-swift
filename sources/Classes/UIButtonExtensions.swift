//
//  UIButtonExtensions.swift
//  SBKit-swift
//
//  Created by ankang on 2023/7/13.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Properties
public extension UIButton {

    private static var clickEdgeInsets = "clickEdgeInsets"
    /// 扩充点击的范围
    /// 使用方式 btn.enlargeEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    var enlargeEdgeInsets: UIEdgeInsets? {
        set {
            objc_setAssociatedObject(self, &Self.clickEdgeInsets, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_COPY)
        }
        get {
            return objc_getAssociatedObject(self, &Self.clickEdgeInsets) as? UIEdgeInsets ?? UIEdgeInsets.zero
        }
    }
    
    /// Image of disabled state for button; also inspectable from Storyboard.
    @IBInspectable
    var imageForDisabled: UIImage? {
        get {
            return image(for: .disabled)
        }
        set {
            setImage(newValue, for: .disabled)
        }
    }

    ///  Image of highlighted state for button; also inspectable from Storyboard.
    @IBInspectable
    var imageForHighlighted: UIImage? {
        get {
            return image(for: .highlighted)
        }
        set {
            setImage(newValue, for: .highlighted)
        }
    }

    ///  Image of normal state for button; also inspectable from Storyboard.
    @IBInspectable
    var imageForNormal: UIImage? {
        get {
            return image(for: .normal)
        }
        set {
            setImage(newValue, for: .normal)
        }
    }

    ///  Image of selected state for button; also inspectable from Storyboard.
    @IBInspectable
    var imageForSelected: UIImage? {
        get {
            return image(for: .selected)
        }
        set {
            setImage(newValue, for: .selected)
        }
    }

    ///  Title color of disabled state for button; also inspectable from Storyboard.
    @IBInspectable
    var titleColorForDisabled: UIColor? {
        get {
            return titleColor(for: .disabled)
        }
        set {
            setTitleColor(newValue, for: .disabled)
        }
    }

    ///  Title color of highlighted state for button; also inspectable from Storyboard.
    @IBInspectable
    var titleColorForHighlighted: UIColor? {
        get {
            return titleColor(for: .highlighted)
        }
        set {
            setTitleColor(newValue, for: .highlighted)
        }
    }

    ///  Title color of normal state for button; also inspectable from Storyboard.
    @IBInspectable
    var titleColorForNormal: UIColor? {
        get {
            return titleColor(for: .normal)
        }
        set {
            setTitleColor(newValue, for: .normal)
        }
    }

    ///  Title color of selected state for button; also inspectable from Storyboard.
    @IBInspectable
    var titleColorForSelected: UIColor? {
        get {
            return titleColor(for: .selected)
        }
        set {
            setTitleColor(newValue, for: .selected)
        }
    }

    ///  Title of disabled state for button; also inspectable from Storyboard.
    @IBInspectable
    var titleForDisabled: String? {
        get {
            return title(for: .disabled)
        }
        set {
            setTitle(newValue, for: .disabled)
        }
    }

    ///  Title of highlighted state for button; also inspectable from Storyboard.
    @IBInspectable
    var titleForHighlighted: String? {
        get {
            return title(for: .highlighted)
        }
        set {
            setTitle(newValue, for: .highlighted)
        }
    }

    ///  Title of normal state for button; also inspectable from Storyboard.
    @IBInspectable
    var titleForNormal: String? {
        get {
            return title(for: .normal)
        }
        set {
            setTitle(newValue, for: .normal)
        }
    }

    ///  Title of selected state for button; also inspectable from Storyboard.
    @IBInspectable
    var titleForSelected: String? {
        get {
            return title(for: .selected)
        }
        set {
            setTitle(newValue, for: .selected)
        }
    }
    
    ///  font for button; also inspectable from Storyboard.
    @IBInspectable
    var fontForTitle: UIFont? {
        get {
            return titleLabel?.font
        }
        set {
            titleLabel?.font = newValue
        }
    }

}

// MARK: - Methods
public extension UIButton {

    
    /// 重写系统方法修改点击区域
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard let inset = enlargeEdgeInsets else {
            return super.point(inside: point, with: event)
        }
        var bounds = self.bounds

        let x: CGFloat = -inset.left
        let y: CGFloat = -inset.top
        let width: CGFloat = bounds.width + inset.left + inset.right
        let height: CGFloat = bounds.height + inset.top + inset.bottom
        bounds = CGRect(x: x, y: y, width: width, height: height) // 负值是方法响应范围

        return bounds.contains(point)
    }
    
    func set(title: String?, titleColor: UIColor?, for state: UIControl.State) {
        setTitle(title, for: state)
        setTitleColor(titleColor, for: state)
    }
    
    func set(title: String?, titleColor: UIColor?, image: UIImage?, for state: UIControl.State) {
        setTitle(title, for: state)
        setTitleColor(titleColor, for: state)
        setImage(image, for: state)
    }
    
    func set(title: String?, titleColor: UIColor?, image: UIImage?, backgroundImage: UIImage?, for state: UIControl.State) {
        setTitle(title, for: state)
        setTitleColor(titleColor, for: state)
        setImage(image, for: state)
        setBackgroundImage(backgroundImage, for: state)
    }
    
    
    private var states: [UIControl.State] {
        return [.normal, .selected, .highlighted, .disabled]
    }

    ///  Set image for all states.
    ///
    /// - Parameter image: UIImage.
    func setImageForAllStates(_ image: UIImage?) {
        states.forEach { setImage(image, for: $0) }
    }

    ///  Set title color for all states.
    ///
    /// - Parameter color: UIColor.
    func setTitleColorForAllStates(_ color: UIColor?) {
        states.forEach { setTitleColor(color, for: $0) }
    }

    ///  Set title for all states.
    ///
    /// - Parameter title: title string.
    func setTitleForAllStates(_ title: String?) {
        states.forEach { setTitle(title, for: $0) }
    }

    ///  Center align title text and image
    /// - Parameters:
    ///   - imageAboveText: set true to make image above title text, default is false, image on left of text
    ///   - spacing: spacing between title text and image.
    func centerTextAndImage(imageAboveText: Bool = false, spacing: CGFloat) {
        if imageAboveText {
            // https://stackoverflow.com/questions/2451223/#7199529
            guard
                let imageSize = imageView?.image?.size,
                let text = titleLabel?.text,
                let font = titleLabel?.font
                else { return }

            let titleSize = text.size(withAttributes: [.font: font])

            let titleOffset = -(imageSize.height + spacing)
            titleEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageSize.width, bottom: titleOffset, right: 0.0)

            let imageOffset = -(titleSize.height + spacing)
            imageEdgeInsets = UIEdgeInsets(top: imageOffset, left: 0.0, bottom: 0.0, right: -titleSize.width)

            let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0
            contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
        } else {
            let insetAmount = spacing / 2
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount, bottom: 0, right: insetAmount)
            titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: -insetAmount)
            contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
        }
    }
    
    func leftTextAndImage(spacing: CGFloat) {
        guard
            let imageSize = imageView?.image?.size,
            let text = titleLabel?.text,
            let font = titleLabel?.font
        else { return }
        
        let titleSize = text.size(withAttributes: [.font: font])
        
        let titleOffset = -(imageSize.width + spacing)
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: titleOffset, bottom: 0, right: -titleOffset)
        
        let imageOffset = (titleSize.width + spacing)
        imageEdgeInsets = UIEdgeInsets(top: 0, left: imageOffset, bottom: 0.0, right: -imageOffset)
        
        let edgeOffset = abs(titleSize.height - imageSize.height) / 2.0
        contentEdgeInsets = UIEdgeInsets(top: edgeOffset, left: 0.0, bottom: edgeOffset, right: 0.0)
    }
    
}

#endif
