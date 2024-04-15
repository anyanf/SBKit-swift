//
//  SBSliderView.swift
//  FBHomePage
//
//  Created by ankang on 2023/7/5.
//

import Foundation

public class SBSliderView : UIView {
    
    var sliderView: UIView?
    
    /// 滑块占整个view宽度比
    public var sliderWidthScale = 0.0 {
        didSet {
            sliderView?.sb_width = frame.width * sliderWidthScale
        }
    }
    /// 滑块X位置,比值
    public var locationXScale = 0.0 {
        didSet {
            sliderView?.sb_x = self.sb_width * locationXScale
        }
    }
    
    public var sliderColor = UIColor(red8Bit: 153, green8Bit: 202, blue8Bit: 62, alpha: 1) {
        didSet {
            sliderView?.backgroundColor = sliderColor
        }
    }
    
    public override var frame: CGRect {
        didSet {
            layer.cornerRadius = frame.height / 2
            
            sliderView?.layer.cornerRadius = frame.height / 2
            sliderView?.frame = CGRect(x: frame.width * locationXScale,
                                       y: 0,
                                       width: frame.width * sliderWidthScale,
                                       height: frame.height)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.white
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
        
        sliderView = UIView(frame: CGRect.init(x: 0, y: 0, width: 0, height: frame.height))
        sliderView?.backgroundColor = sliderColor
        sliderView?.layer.cornerRadius = frame.height / 2
        sliderView?.layer.masksToBounds = true
        if let sliderView = sliderView {
            addSubview(sliderView)
        }
        
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
