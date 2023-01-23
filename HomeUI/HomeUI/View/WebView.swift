//
//  WebView.swift
//  HomeUI
//
//  Created by Bareeth on 22/01/23.
//

import UIKit
import WebKit

class WebView: UIView {

    private lazy var viewController:WebviewVC = {
        return WebviewVC()
    }()
    
    @IBOutlet weak var wkWebView: WKWebView!
    
    public func viewDidLoad(_ forController:WebviewVC) {
        self.viewController = forController
        if self.viewController.htmlURLs != ""{
            onRedirectToWeb()
        }else{
            self.viewController.showAlert(msg: "Something went wrong")
        }
    }
    
    func onRedirectToWeb(){
        self.wkWebView.isOpaque = false;
        self.wkWebView.backgroundColor = .clear
        wkWebView.loadHTMLString(self.viewController.htmlURLs, baseURL: nil)
    }
    
    @IBAction func onBackBtnTapped(_ sender: Any) {
        self.viewController.dismiss(animated: true)
    }
    
}



