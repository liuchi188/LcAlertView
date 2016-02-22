//
//  ViewController.swift
//  LcAlertView
//
//  Created by 刘驰 on 16/2/22.
//  Copyright © 2016年 liuchi188. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func shorMsgClick(sender: AnyObject) {
        LcAlertView().showShortMsg("标题", message: "2016年 银多资本", okTitle: "返回")
    }
    
    @IBAction func msgClick(sender: AnyObject) {
        LcAlertView().showMsg("标题",
            message: "复合年化指活期宝收益复投后的年化收益，由于活期宝采取收益复投方式，复合年化收益会高于单日年化收益。",
            okTitle: "确定",
            cancelTitle: "返回"){
            alertView, identifier in
            if identifier == "okBtn" {
                print("确定....")
            }
        }
    }

    @IBAction func confirmationClick(sender: AnyObject) {
        LcAlertView().showConfirmation("交易密码", okTitle: "确定", cancelTitle: "取消", placeHolder: "请输入交易密码", isSecured: true) {
                    alertView, identifier in
                    if identifier == "okBtn" {
                        print(alertView.inputTf.text)
                    }
                }
    }

}

