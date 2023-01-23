//
//  HomeVC.swift
//  HomeUI
//
//  Created by Bareeth on 21/01/23.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet var homeView: HomeView!
    
    
    private lazy var viewModel:HomeModel = {
        return HomeModel()
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        homeView.viewDidLoad(self)
        CallApi()
        
    }
    
    func CallApi(){
        viewModel.callApi{ value in
            self.homeView.modelData = value.articles
            self.homeView.setTableViewDeledate()
        }
    }

    class func initWithStory() -> HomeVC {
        let story = UIStoryboard(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "HomeVC") as!  HomeVC
        return vc
    }

}
