# LcAlertView
简单的对话框

## 效果图
![image](https://github.com/liuchi188/LcAlertView/blob/master/image01.png)
![image](https://github.com/liuchi188/LcAlertView/blob/master/image02.png)
![image](https://github.com/liuchi188/LcAlertView/blob/master/image03.png)

## 运行环境

- iOS8.1 or later
- Xcode 7.0

## 使用方法

1.将代码中LcScrollBannerView.swift拖入项目中。     
2.viewController中加入下面代码。   

```swift
LcAlertView().showShortMsg("标题", message: "2016年 银多资本", okTitle: "返回")

LcAlertView().showMsg("标题", message: "复合年化指活期宝收益复投后的年化收益，由于活期宝采取收益复投方式，复合年化收益会高于单日年化收益。", okTitle: "确定", cancelTitle: "返回"){
            alertView, identifier in
            if identifier == "okBtn" {
                print("确定....")
            }
        }

LcAlertView().showConfirmation("交易密码", okTitle: "确定", cancelTitle: "取消", placeHolder: "请输入交易密码", isSecured: true) {
                    alertView, identifier in
                    if identifier == "okBtn" {
                        print(alertView.inputTf.text)
                    }
                }


