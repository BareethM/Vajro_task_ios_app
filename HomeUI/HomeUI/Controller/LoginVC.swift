//
//  LoginVC.swift
//  HomeUI
//
//  Created by Bareeth on 21/01/23.
//

import UIKit

import UIKit

class LoginVC: UIViewController {

    @IBOutlet var loginView: LoginView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginView.viewDidLoad(self)
    }

    class func initWithStory() -> LoginVC {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "LoginVC") as!  LoginVC
        return vc
    }

}
