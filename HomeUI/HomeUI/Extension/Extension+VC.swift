//
//  Extension+VC.swift
//  HomeUI
//
//  Created by Bareeth on 21/01/23.
//

import UIKit

extension UIViewController{
    //    MARK: Common Alert
    func showAlert(msg:String){
        let alert = UIAlertController(title:  "Alert", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //    MARK: Email and password validation
    
    func isValidEmail(text:String) -> Bool {
        let emailRegEx = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{1,4}$"
        let emailTest = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: text)
    }
    
    func isValidPassword(text:String) -> Bool {
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: text)
    }
}

public extension UIView{
    
    func elevate(_ elevation : CGFloat,
                 radius : CGFloat,
                 opacity : Float = 0.3,
                 fillcolor : UIColor = .clear,
                 shadowColor : UIColor = .darkGray){
        
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            let shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: radius).cgPath
            shadowLayer.fillColor = fillcolor.cgColor
            
            shadowLayer.shadowColor = shadowColor.cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: elevation, height: elevation)
            shadowLayer.shadowOpacity = opacity
            shadowLayer.shadowRadius = elevation
            self.layer.sublayers?.forEach({ (sub) in
                sub.removeFromSuperlayer()
            })
            self.layer.insertSublayer(shadowLayer, at: 0)
        }
    }
    
    func elevate(_ elevation: Double,shadowColor : UIColor = .black,opacity : Float = 0.3) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: elevation)
        self.layer.shadowRadius = abs(elevation > 0 ? CGFloat(elevation) : -CGFloat(elevation))
        self.layer.shadowOpacity = opacity
    }
    
    func width(ofCent percent: CGFloat)-> CGFloat{
        return self.frame.width * (percent/100)
    }
    func height(ofCent percent: CGFloat)-> CGFloat{
        return self.frame.height * (percent/100)
    }
    
    func takeScreenshot() -> UIImage {
        
        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        
        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)
        
        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }
    
    
    
    var isElevated : Bool {
        get{
            return self.layer.shadowRadius != 0.0
        }
        set(newValue){
            if newValue{
                self.elevation(width: 0, height: 5,border: 0.24)
            }else{
                self.elevation(width: 0, height: 0, border: 0)
            }
        }
    }
    var isCarded : Bool {
        get{
            return self.layer.shadowRadius != 0.0
        }
        set(newValue){
            if newValue{
                self.elevation(width: 5, height: 5,border: 0.24)
            }else{
                self.elevation(width: 0, height: 0, border: 0)
            }
        }
    }
    var isClippedCorner : Bool{
        get{
            return self.layer.cornerRadius != 0
        }
        set(newValue){
            if newValue{
                self.clipsToBounds = true
                self.layer.cornerRadius = self.frame.height * (8/100)
            }else{
                self.layer.cornerRadius = 0
            }
        }
    }
    var isCurvedCorner : Bool{
        get{
            return self.layer.cornerRadius != 0
        }
        set(newValue){
            if newValue{
                self.clipsToBounds = true
                self.layer.cornerRadius = self.frame.height * (25/100)
            }else{
                self.layer.cornerRadius = 0
            }
        }
    }
    var isRoundCorner : Bool{
        get{
            return self.layer.cornerRadius != 0
        }
        set(newValue){
            if newValue{
                self.clipsToBounds = true
                self.layer.cornerRadius = self.frame.height / 2
            }else{
                self.layer.cornerRadius = 0
            }
        }
    }
    func shadow(_ shadowSize : CGFloat = 5.0,xDir :CGFloat = 0,yDir:CGFloat = 0){
        let shadowPath = UIBezierPath(rect: self.bounds)
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: xDir, height: yDir)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowPath = shadowPath.cgPath
        self.layer.shouldRasterize = true
    }
    func elevation(width : CGFloat,height : CGFloat,border : CGFloat){
        if width == 5{
            self.layer.cornerRadius = self.frame.height * (3/100)
        }
        self.clipsToBounds = true
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width : width, height : height)
        self.layer.shadowRadius = CGFloat(height)
        self.layer.shadowOpacity = Float(border)
        
        if width != 0.0 && height != 0.0 && border != 0.0{
            self.backgroundColor = self.backgroundColor == UIColor.white ? UIColor(red: 250.0 / 255.0, green: 250.0 / 255.0, blue: 250.0 / 255.0, alpha: 0.5) : self.backgroundColor
            self.layer.borderColor = UIColor.lightGray.cgColor
            self.layer.borderWidth = border - 0.04
            self.layer.shadowColor = UIColor(red: 225.0 / 255.0, green: 228.0 / 255.0, blue: 228.0 / 255.0, alpha: 1.0).cgColor
        }
    }
    var isShimmering : Bool{
        get{
            return self.layer.mask != nil
        }
        set(newValue){
            if newValue{
                let light = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1).cgColor
                let dark = UIColor.black.cgColor
                
                let gradient: CAGradientLayer = CAGradientLayer()
                gradient.colors = [dark, light, dark]
                gradient.frame = CGRect(x: -self.bounds.size.width, y: 0, width: 3*self.bounds.size.width, height: self.bounds.size.height)
                gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradient.endPoint = CGPoint(x: 1.0, y: 0.525)
                gradient.locations = [0.4, 0.5, 0.6]
                self.layer.mask = gradient
                
                let animation: CABasicAnimation = CABasicAnimation(keyPath: "locations")
                animation.fromValue = [0.0, 0.1, 0.2]
                animation.toValue = [0.8, 0.9, 1.0]
                
                animation.duration = 1.5
                animation.repeatCount = HUGE
                gradient.add(animation, forKey: "shimmer")
            }else{
                self.layer.mask = nil
            }
        }
    }
    var clip : UIRectCorner{
        get{
            return UIRectCorner()
        }
        set(newValue){
            let cut = self.frame.height * (5/100)
            let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: newValue, cornerRadii:CGSize(width: cut, height: cut ))
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            self.layer.mask = maskLayer
            self.layoutIfNeeded()
        }
    }
}
extension UIView {
    
    //Corner Radius
    @IBInspectable
    var cornerRadius : CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
//            layer.masksToBounds = newValue > 0
        }
    }
    @IBInspectable
        var isRounded: Bool{
        get{
            return layer.cornerRadius == frame.width * 0.5
        }
        set{
            if newValue{
                DispatchQueue.main.asyncAfter(deadline: .now()+0.02) {
                    self.layer.cornerRadius = self.frame.width * 0.5
                }
            }else{
//                layer.cornerRadius = 0.0
            }
        }
    }
    
    //Border Width
    @IBInspectable
    var borderWidth : CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    
    //Border Color
    @IBInspectable
    var borderColor : UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            layer.borderColor = newValue?.cgColor
            self.layer.shouldRasterize = true
            self.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    
    // The color of the shadow. Defaults to opaque black. Colors created from patterns are currently NOT supported. Animatable.
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.shadowColor!)
        }
        set {
            layer.masksToBounds = false
            self.layer.shadowColor = newValue?.cgColor
        }
    }
    
    //The opacity of the shadow. Defaults to 0. Specifying a value outside the [0,1] range will give undefined results. Animatable.
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return self.layer.shadowOpacity
        }
        set {
            layer.masksToBounds = false
            self.layer.shadowOpacity = newValue
        }
    }
    
    //The shadow offset. Defaults to (0, -3). Animatable.
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return self.layer.shadowOffset
        }
        set {
            layer.masksToBounds = false
            self.layer.shadowOffset = newValue
        }
    }
    
    //The blur radius used to create the shadow. Defaults to 3. Animatable.
    @IBInspectable
    var shadowRadius: Double {
        get {
            return Double(self.layer.shadowRadius)
        }
        set {
            layer.masksToBounds = false
            self.layer.shadowRadius = CGFloat(newValue)
        }
    }
    
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
           let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
           let mask = CAShapeLayer()
           mask.path = path.cgPath
           layer.mask = mask
       }
    
    func anchor(toView : UIView,
                leading : CGFloat? = nil,
                trailing : CGFloat? = nil,
                top : CGFloat? = nil,
                bottom : CGFloat? = nil){
        
        self.translatesAutoresizingMaskIntoConstraints = false
        if let _leading = leading{
            self.leadingAnchor
                .constraint(equalTo: toView.leadingAnchor, constant: _leading)
                .isActive = true
        }
        if let _trailing = trailing{
            self.trailingAnchor
                .constraint(equalTo: toView.trailingAnchor, constant: _trailing)
                .isActive = true
        }
        if let _top = top{
            self.topAnchor
                .constraint(equalTo: toView.topAnchor, constant: _top)
                .isActive = true
        }
        if let _bottom = bottom{
            self.bottomAnchor
                .constraint(equalTo: toView.bottomAnchor, constant: _bottom)
                .isActive = true
        }
        
    }
   
    func setEqualHightWidthAnchor(toView : UIView,height: CGFloat? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalTo: toView.heightAnchor).isActive = true
        if let _height = height {
            self.heightAnchor.constraint(equalToConstant: _height).isActive = true
        }
    }
    
    func setCenterXYAncher(toView : UIView,
                           centerX: Bool = false,
                           centerY: Bool = false) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if centerX {
            self.centerXAnchor.constraint(equalTo: toView.centerXAnchor).isActive = true
        }
        if centerY {
            self.centerYAnchor.constraint(equalTo: toView.centerYAnchor).isActive = true
        }
    }
    
    
    func getSwipebleView(content: String) {
        enum state {
            case middle
            case full
        }
        
        var _ : state = .middle
        let bgView = UIView(frame: self.frame)
        bgView.backgroundColor = .white
        self.addSubview(bgView)
        bgView.anchor(toView: self,
                      leading: 0,
                      trailing: 0,
                      top: 0,
                      bottom: 0)
        
        let contentView = UIView(frame: self.frame)
        bgView.addSubview(contentView)
        contentView.anchor(toView: bgView,
                           leading: 0,
                           trailing: 0,
                           top: 0,
                           bottom: 0)

        let label = UILabel(frame: self.frame)
        label.text = content
        label.numberOfLines = 0
//        label.textAlignment = .justified
        contentView.roundCorners(corners: [.topLeft,.topRight], radius: 10)
        label.textAlignment = .left
        contentView.addSubview(label)
        label.anchor(toView : contentView,
                     leading : 10,
                     trailing : -10,
                     top : 10)
        label.bottomAnchor.constraint(greaterThanOrEqualTo: contentView.bottomAnchor,
                                      constant: -10).isActive = true
       
        // Inital View Postion
        contentView.frame.origin.y = self.frame.maxY * 1.5
        
        UIView.animate(withDuration: 0.5) {
            contentView.frame.origin.y = self.frame.midY
        } completion: { (completed) in
            print("Initiated SwipeView")
        }

        bgView.bringSubviewToFront(contentView)
        
      
    }
}

