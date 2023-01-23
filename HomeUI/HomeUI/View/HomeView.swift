//
//  HomeView.swift
//  HomeUI
//
//  Created by Bareeth on 21/01/23.
//

import Foundation
import UIKit


class HomeView : UIView{
    
    var modelData = [Articles]()
    
    @IBOutlet weak var tblView: UITableView!
    
    
    private lazy var viewController:HomeVC = {
        return HomeVC()
    }()
    
    public func viewDidLoad(_ forController:HomeVC) {
        self.viewController = forController
        
        tblView.refreshControl = UIRefreshControl()
        tblView.refreshControl?.addTarget(self, action: #selector(handleRefreshControl), for: .valueChanged)
    }
 
    public func setTableViewDeledate(){
    
        DispatchQueue.main.async {
            self.tblView.delegate = self
            self.tblView.dataSource = self
            self.tblView.reloadData()
        }
    }
    
    
    @objc func handleRefreshControl() {
       DispatchQueue.main.async {
          self.tblView.refreshControl?.endRefreshing()
          self.tblView.reloadData()
       }
    }
    
}


extension HomeView : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.modelData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTVC") as! HomeTVC
        cell.holderView.cornerRadius = 20
        cell.holderView.elevate(3)
        cell.titleLbl.text = self.modelData[indexPath.row].title
        cell.descriptionLbl.text = self.modelData[indexPath.row].summary_html
        let imageURL = URL(string: self.modelData[indexPath.row].image?.src ?? "")!

        URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    cell.imgView.image = image//UIImage(data: data)
                }
            }
        }.resume()


        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(((((self.modelData[indexPath.row].image?.height)!)/3) + 100))
     }
    
}


extension HomeView : UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = WebviewVC.initWithStory(htmlURL: self.modelData[indexPath.row].body_html ?? "")
        vc.modalPresentationStyle = .fullScreen
        self.viewController.present(vc, animated: true)
    }
    
    
}
