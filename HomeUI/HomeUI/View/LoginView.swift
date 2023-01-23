//
//  LoginView.swift
//  HomeUI
//
//  Created by Bareeth on 21/01/23.
//

import UIKit

class LoginView: UIView{

    //outlet
    
    @IBOutlet weak var userImg: UIImageView!
    @IBOutlet weak var signinLbl: UILabel!
    @IBOutlet weak var emailTxtFld: UITextField!
    @IBOutlet weak var passwordTxtFld: UITextField!
    
    
    private lazy var viewController:LoginVC = {
        return LoginVC()
    }()
    lazy var imagePicker = UIImagePickerController()
    var imagePicked : ((UIImage)-> Void)?
    var isImageUpload = false
    let userDefaults = UserDefaults.standard
    
    public func viewDidLoad(_ forController:LoginVC) {
        self.viewController = forController
        setRoundesImage()
    }
    
    func setRoundesImage(){
        userImg.layer.borderWidth=1.0
        userImg.layer.masksToBounds = false
        userImg.layer.borderColor = UIColor.white.cgColor
        userImg.layer.cornerRadius = userImg.frame.size.height/2
        userImg.clipsToBounds = true
    }
    
    
    @IBAction func loginBtnTapped(_ sender: Any) {
        
        if !self.viewController.isValidEmail(text: self.emailTxtFld.text!) || !self.viewController.isValidPassword(text: self.passwordTxtFld.text!){
            self.viewController.showAlert(msg: "Email or password should be At Least one uppercase alphabet, one special character and numeric character.")
        }else if !isImageUpload{
            self.viewController.showAlert(msg: "Please upload your image")
        }else{
            userDefaults.set(true, forKey: "isLogin")
            let vc = HomeVC.initWithStory()
            self.viewController.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    
    @IBAction func imageAddBtnTapped(_ sender: Any) {
        
        imagePAthAlert()
    }
    
    func imagePAthAlert(){
        let refreshAlert = UIAlertController(title: "Choose", message: "", preferredStyle: .actionSheet)
                
        refreshAlert.addAction(UIAlertAction(title: "Take photo", style: .default, handler: { (action: UIAlertAction!) in
            self.takePhoto()
           }))
        
        refreshAlert.addAction(UIAlertAction(title: "Choose photo", style: .default, handler: { (action: UIAlertAction!) in
            self.choosePhoto()
           }))
                
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
                    print("Handle Cancel Logic here")
                    refreshAlert .dismiss(animated: true, completion: nil)
           }))

        self.viewController.present(refreshAlert, animated: true, completion: nil)
    }
    
    
}


extension LoginView : UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    func takePhoto()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)
        {
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera;
            imagePicker.allowsEditing = true
            self.viewController.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let settingsActionSheet: UIAlertController = UIAlertController(title:"Error", message:"Device has no camera", preferredStyle:UIAlertController.Style.alert)
            settingsActionSheet.addAction(UIAlertAction(title:"ok", style:UIAlertAction.Style.cancel, handler:nil))
            self.viewController.present(settingsActionSheet, animated:true, completion:nil)
        }
        
    }
    
    func choosePhoto() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary;
            imagePicker.allowsEditing = true
            self.viewController.present(imagePicker, animated: true, completion: nil)
        } else {
            let settingsActionSheet: UIAlertController = UIAlertController(title:"Warning".uppercased(), message: "Please give permission to access photo.", preferredStyle:UIAlertController.Style.alert)
            settingsActionSheet.addAction(UIAlertAction(title:"ok".uppercased(), style:UIAlertAction.Style.cancel, handler:nil))
            self.viewController.present(settingsActionSheet, animated:true, completion:nil)
        }
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.viewController.dismiss(animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        let uploadImage : UIImage? =  info[.editedImage] as? UIImage ?? (info[.originalImage] as? UIImage)
        let _ : Float = Float((uploadImage?.size.width)! / (uploadImage?.size.height)!)
        if let toImage = uploadImage {
            self.userImg.image = toImage
            self.isImageUpload = true
        }
        viewController.dismiss(animated: true, completion: nil)
        self.viewController.dismiss(animated: true, completion: nil)
    }
    
}
