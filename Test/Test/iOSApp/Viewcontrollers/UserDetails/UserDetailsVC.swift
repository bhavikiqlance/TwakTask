//
//  UserDetailsVCViewController.swift
//  Test
//
//  Created by Apple iQlance on 03/06/2022.
//

import UIKit

class UserDetailsVC: UIViewController {
    
    //MARK:-  Outlets and Variable Declarations
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var lblFollowing: UILabel!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblCompany: UILabel!
    @IBOutlet weak var lblBlog: UILabel!
    @IBOutlet weak var txtNotes: UITextView!
    
    var userName = String()
    var arrOfUsersData : UsersData?
    
    //MARK:- 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUserData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK:-  Buttons Clicked Action
    @IBAction func btnBackClicked(_ sender: UIButton) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnSaveClicked(_ sender: UIButton) {
        
        if isValidAllFields() {
            
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    //MARK:-  Functions
    func setUserData() {
        
        let url = URL(string: APIName.USER_DETAIL + userName)!
        let progressHUD = ProgressHUD(text: "Please Wait...")
        self.view.addSubview(progressHUD)
        URLSession.shared.fetchUsersData(at: url) { result in
            switch result {
            case .success(let toDos):
                DispatchQueue.main.async {
                    progressHUD.removeFromSuperview()
                }
                
                print(toDos)
                self.getUsersData(users: toDos)
                self.arrOfUsersData = toDos
            case .failure(let error):
                DispatchQueue.main.async {
                    progressHUD.removeFromSuperview()
                }
                
                print(error)
                self.showAlertWithOKButton(message: "No Data Found!")
            }
        }
    }
    
    func getUsersData(users:UsersData) {
        
        DispatchQueue.main.async {
            self.lblTitle.text = users.login ?? ""
            self.imgUser.loadFrom(URLAddress: users.avatar_url ?? "person.circle.fill")
            self.lblFollowers.text = "Followers: \(users.followers ?? 0)"
            self.lblFollowing.text = "Following: \(users.following ?? 0)"
            self.lblUserName.text = "Name: \(users.login ?? "")"
            self.lblCompany.text = "Company: \(users.company ?? "")"
            self.lblBlog.text = "Blog: \(users.blog ?? "")"
            self.txtNotes.text = users.notes ?? ""
        }
    }
    
    private func isValidAllFields() -> Bool {
        
        if txtNotes.isemptyTextView() {
            self.showAlertWithOKButton(message: "Please enter notes.")
            
        } else {
            return true
        }
        
        return false
    }
}

//MARK:-  UITextViewDelegate Methods
extension UserDetailsVC: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") {
            textView.resignFirstResponder()
        }
        return true
    }
    
}
