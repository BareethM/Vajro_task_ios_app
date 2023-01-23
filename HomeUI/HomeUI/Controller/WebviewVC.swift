//
//  WebviewVC.swift
//  HomeUI
//
//  Created by Bareeth on 22/01/23.
//

import UIKit

class WebviewVC: UIViewController {

    @IBOutlet var webview: WebView!
    
    var htmlURLs = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webview.viewDidLoad(self)
        print("Calllingg")
        
    }
    
    class func initWithStory(htmlURL:String) -> WebviewVC {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "WebviewVC") as!  WebviewVC
        vc.htmlURLs = htmlURL
        return vc
    }

}
