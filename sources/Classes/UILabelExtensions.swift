//
//  UILabel.swift
//  SBKit-swift
//
//  Created by ankang on 2023/7/25.
//

#if canImport(UIKit) && !os(watchOS)
import UIKit

// MARK: - Methods
public extension UILabel {

    ///  Initialize a UILabel with text
    convenience init(text: String?) {
        self.init()
        self.text = text
    }

    ///  Initialize a UILabel with a text and font style.
    ///
    /// - Parameters:
    ///   - text: the label's text.
    ///   - style: the text style of the label, used to determine which font should be used.
    convenience init(text: String, style: UIFont.TextStyle) {
        self.init()
        font = UIFont.preferredFont(forTextStyle: style)
        self.text = text
    }
    
    func set(textColor: UIColor, font: UIFont, textAlignment: NSTextAlignment) {
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
    }
    
    func set(text: String?, textColor: UIColor, font: UIFont, textAlignment: NSTextAlignment) {
        self.text = text
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
    }

    ///  Required height for a label
    var requiredHeight: CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text
        label.attributedText = attributedText
        label.sizeToFit()
        return label.frame.height
    }
    
    /// 划线
    func setStrikethrough() {

        var attributedTextTemp: NSMutableAttributedString?
        
        if let attributedText = attributedText {
            attributedTextTemp = NSMutableAttributedString(attributedString: attributedText)
        } else {
            attributedTextTemp = NSMutableAttributedString(string: text ?? "")
        }
        
        guard let attributedTextTemp else { return }

        let range = NSMakeRange(0, attributedTextTemp.length)
        
        // 添加删除线
        attributedTextTemp.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                        value: NSUnderlineStyle.single.rawValue,
                                        range: range)
        
        // 将NSAttributedString应用到UILabel
        attributedText = attributedTextTemp
    }

}

#endif

