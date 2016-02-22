//
//  LcAlertView.swift
//  beautySalonsApp
//
//  Created by 刘驰 on 15/12/29.
//  Copyright © 2015年 银多资本. All rights reserved.
//

import Foundation
import UIKit

public enum LcAlertViewStyle {
    case Alert, Confirmation
}

typealias alertBtnClick = (alertView: LcAlertView, tag: String) -> Void

public class LcAlertView: UIViewController {
    
    let kDefaultShadowOpacity: CGFloat = 0.7
    let kAlertWidth:CGFloat = 300
    let kAlertHeight:CGFloat = 65
    let kCornerRadius:CGFloat = 4
    let kButtonMargin:CGFloat = 5
    let kButtonCornerRadius:CGFloat = 5
    let KTopMargin: CGFloat = 10
    let kWidthMargin: CGFloat = 10
    let kTitleHeight:CGFloat = 30.0
    let kHeightMargin: CGFloat = 10.0
    let kButtonHeight:CGFloat = 35.0
    let kButtonFontSize:CGFloat = 14
    let kMessageViewHeight: CGFloat = 60.0
    let kInputViewHeight: CGFloat = 35.0
    let kDuration:Double = 0.3
    let kOkTitle = "确定"
    
    let kOkBtnColor = UIColor(red: 102/255, green: 153/255, blue: 153/255, alpha: 1)
    let kCancelBtnColor = UIColor(red: 204/255, green: 51/255, blue: 51/255, alpha: 1)
    let kTitleColor: UIColor? = UIColor(red:0.5, green:0.55, blue:0.55, alpha:1.0)
    let kMessageColor: UIColor? = UIColor(red:0.5, green:0.55, blue:0.55, alpha:1.0)
    let inputBorderColor: UIColor? = UIColor(red: 102/255, green: 153/255, blue: 153/255, alpha: 1)
    
    public var alertTitle:String?
    public var message:String?
    public var okTitle: String?
    public var cancelTitle: String?
    
    var btnClick: alertBtnClick?
    
    var alertView:LcAlertView?
    var baseView = UIView()
    var contentView = UIView()
    
    var titleLab = UILabel()
    var messageLab = UILabel()
    
    var inputTf = UITextField()
    
    var okBtn = LcAlertButton(id: "okBtn")
    var cancelBtn = LcAlertButton(id: "cancelBtn")
    
    
    
    let mainScreenBounds = UIScreen.mainScreen().bounds
    var x:CGFloat = 0
    var y:CGFloat = 0
    var width:CGFloat = 0
    var btnWidth:CGFloat = 0
    
    init() {
        x = kWidthMargin
        y = KTopMargin
        width = kAlertWidth - (kWidthMargin * 2)
        btnWidth = (kAlertWidth - (kWidthMargin * 2) - kButtonMargin) / 2
        super.init(nibName: nil, bundle: nil)
        let window: UIWindow = UIApplication.sharedApplication().keyWindow!
        window.addSubview(view)
        window.bringSubviewToFront(view)
        view.frame = window.bounds
        self.view.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        self.view.backgroundColor = UIColor(red:0, green:0, blue:0, alpha:kDefaultShadowOpacity)
        self.view.alpha = 0
        baseView.frame = view.frame
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector("dismiss"))
        self.baseView.addGestureRecognizer(tapGesture)
        self.view.addSubview(baseView)
        
        alertView = self
    }
    
    func showTitle(title: String, message: String?, style: LcAlertViewStyle, okTitle: String, cancelTitle: String?, btnAction: ((alertView: LcAlertView, tag: String) -> Void)? = nil) {
        self.alertTitle = title
        self.message = message
        self.okTitle = okTitle
        self.cancelTitle = cancelTitle
        self.setupTitleViews()
        switch style {
        case .Alert:
            self.setupMessageView()
        case .Confirmation:
            self.setupTextFields()
        }
        self.setupButtons()
    }
    
    func showShortMsg(title:String, message:String, okTitle:String) {
        showTitle(title, message: message, style: .Alert, okTitle: okTitle, cancelTitle: nil)
    }
    
    func showMsg(title:String, message:String, okTitle:String, cancelTitle: String?, btnAction: ((alertView: LcAlertView, tag: String) -> Void)? = nil){
        showTitle(title, message: message, style: .Alert, okTitle: okTitle, cancelTitle: cancelTitle)
        self.btnClick = btnAction
    }
    
    func showConfirmation(title:String, okTitle:String, cancelTitle:String, placeHolder:String, isSecured:Bool, btnAction: ((alertView: LcAlertView, tag: String) -> Void)? = nil){
        showTitle(title, message: nil, style: LcAlertViewStyle.Confirmation, okTitle: okTitle, cancelTitle: cancelTitle)
        self.btnClick = btnAction
        self.inputTf.placeholder = placeHolder
        if isSecured {
            self.inputTf.secureTextEntry = true
        }
        
    }
    
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName:nibNameOrNil, bundle:nibBundleOrNil)
    }
    
    
    func setupTitleViews(){
        //contentView.frame = CGRect(x: (UIScreen.mainScreen().bounds.size.width - 300) / 2.0, y: (UIScreen.mainScreen().bounds.size.height - 150) / 2.0, width: 280, height: 65)
        contentView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        contentView.layer.cornerRadius = kCornerRadius
        contentView.layer.masksToBounds = true
        contentView.layer.borderWidth = 0.5
        baseView.addSubview(contentView)
        // Setup title
        self.titleLab.textAlignment = NSTextAlignment.Center
        self.titleLab.textColor = kTitleColor
        self.titleLab.font = UIFont.boldSystemFontOfSize(16)
        if alertTitle != nil {
            self.titleLab.text = alertTitle
            titleLab.frame = CGRect(x: x, y: y, width: width, height: kTitleHeight)
            self.y += kTitleHeight + kHeightMargin
            self.contentView.addSubview(titleLab)
        }
    }
    
    func setupMessageView(){
        self.messageLab.textAlignment = NSTextAlignment.Center
        self.messageLab.numberOfLines = 0
        self.messageLab.textAlignment = NSTextAlignment.Left
        self.messageLab.textColor = kMessageColor
        self.messageLab.font = UIFont.systemFontOfSize(14)
        if message != nil {
            self.messageLab.text = message
            messageLab.frame = CGRect(x: x + 5, y: y, width: width - 5, height: kMessageViewHeight)
            self.contentView.addSubview(messageLab)
            self.y += kMessageViewHeight + kHeightMargin
        }
    }
    
    func setupTextFields(){
        inputTf.leftView = UIView(frame: CGRectMake(0, 0, 10, kInputViewHeight))
        inputTf.rightView = UIView(frame: CGRectMake(0, 0, 10, kInputViewHeight))
        inputTf.leftViewMode = UITextFieldViewMode.Always
        inputTf.rightViewMode = UITextFieldViewMode.Always
        inputTf.layer.cornerRadius = 4
        inputTf.layer.borderWidth = 1
        inputTf.font = UIFont.systemFontOfSize(14)
        inputTf.layer.borderColor = inputBorderColor?.CGColor
        inputTf.frame = CGRect(x: x, y: y, width: width, height: kInputViewHeight)
        self.contentView.addSubview(inputTf)
        self.y += kInputViewHeight + kHeightMargin * 2
    }
    
    func setupButtons(){
        if okTitle == nil {
            okTitle = kOkTitle
        }
        okBtn.setTitle(okTitle, forState: UIControlState.Normal)
        okBtn.layer.cornerRadius = kButtonCornerRadius
        okBtn.titleLabel?.font = UIFont.boldSystemFontOfSize(kButtonFontSize)
        okBtn.addTarget(self, action: "okBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        okBtn.backgroundColor = kOkBtnColor
        if cancelTitle != nil {
            cancelBtn.frame = CGRect(x: x + btnWidth + kButtonMargin, y: y, width: btnWidth, height: kButtonHeight)
            cancelBtn.setTitle(cancelTitle, forState: UIControlState.Normal)
            cancelBtn.backgroundColor = kCancelBtnColor
            cancelBtn.layer.cornerRadius = kButtonCornerRadius
            cancelBtn.addTarget(self, action: "cancelBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
            cancelBtn.titleLabel?.font = UIFont.boldSystemFontOfSize(kButtonFontSize)
            contentView.addSubview(cancelBtn)
        }else{
            btnWidth = width
        }
        okBtn.frame = CGRect(x: x, y: y, width: btnWidth, height: kButtonHeight)
        contentView.addSubview(okBtn)
        y += kButtonHeight + kHeightMargin
        contentView.frame = CGRect(x: (mainScreenBounds.size.width - kAlertWidth) / 2.0, y: (mainScreenBounds.size.height - y) / 2.0, width: kAlertWidth, height: y)
        contentView.clipsToBounds = true
        showWithDuration()
    }
    
    func showWithDuration(){
        self.view.alpha = 0
        UIView.animateWithDuration(kDuration) { () -> Void in
            self.view.alpha = 1
        }
    }
    
    func okBtnClick(){
        btnClick?(alertView: self, tag: okBtn.identifier)
        dismiss()
    }
    
    func cancelBtnClick(){
        btnClick?(alertView: self, tag: cancelBtn.identifier)
        dismiss()
    }
    
    func dismiss(){
        self.view.alpha = 1
        UIView.animateWithDuration(kDuration,
            animations: { () -> Void in
                self.view.alpha = 0
            }, completion: {
                Void in
                self.view.removeFromSuperview()
        })
        
    }
    
    class LcAlertButton: UIButton {
        var identifier: String!
        
        init(id:String) {
            super.init(frame: CGRectZero)
            identifier = id
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
        }
        
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
    }
    
    
}