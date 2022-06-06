//
//  ViewController.swift
//  Test
//
//  Created by Apple iQlance on 03/06/2022.
//

import UIKit

class HomeVC: UIViewController {
    
    //MARK:-  Outlets and Variable Declarations
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var tblUser: UITableView!
    
    var arrOfUsers = [UsersData]()
    var arrCopyOfUsers = [UsersData]()
    var shimmer = TableViewShimmer()
    private var currentPage = 0
    let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
    
    //MARK:- 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setUsersLists(count: "\(currentPage)")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getUsersFromCoreDatabase()
    }
    
    //MARK:-  Buttons Clicked Action
    
    //MARK:-  Functions
    private func setUsersLists(count:String) {
        
        let url = URL(string: APIName.USER_LIST + count)!
        let progressHUD = ProgressHUD(text: "Please Wait...")
        self.view.addSubview(progressHUD)
        URLSession.shared.fetchUsersList(at: url) { result in
            switch result {
            case .success(let toDos):
                DispatchQueue.main.async {
                    progressHUD.removeFromSuperview()
                }
                
                print(toDos)
                self.arrOfUsers = toDos
                self.reloadTableView()
                
                for c in toDos {
                    CoreDataManager.shared.insertUser(user: c) { isSuccess, message in }
                }
                
                self.getUsersFromCoreDatabase()
            case .failure(let error):
                DispatchQueue.main.async {
                    progressHUD.removeFromSuperview()
                }
                
                print(error)
                self.showAlertWithOKButton(message: "No Data Found!")
            }
        }
    }
    
    private func reloadTableView() {
        
        DispatchQueue.main.async {
            self.arrCopyOfUsers = self.arrOfUsers
            self.tblUser.reloadData()
            self.tblUser.layoutIfNeeded()
            self.spinner.stopAnimating()
        }
    }
    
    private func getUsersFromCoreDatabase() {
        
        DispatchQueue.main.async {
            self.arrOfUsers = CoreDataManager.shared.getAllUsers()
            self.tblUser.reloadData()
            self.tblUser.layoutIfNeeded()
            self.spinner.stopAnimating()
        }
    }
}

//MARK:-  UITableViewDataSource Methods
extension HomeVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrOfUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as! HomeTableViewCell
        
        cell.configureCell(users: arrOfUsers[indexPath.row])
        
        return cell
    }
}


//MARK:-  UITableViewDelegate Methods
extension HomeVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let userDetailsVC = storyboard?.instantiateViewController(withIdentifier: "UserDetailsVC") as! UserDetailsVC
        userDetailsVC.userName = arrOfUsers[indexPath.row].login ?? ""
        self.navigationController?.pushViewController(userDetailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == arrOfUsers.count - 1 {
            self.currentPage = currentPage + 1
            self.setUsersLists(count: "\(currentPage + 1)")
        }
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            self.tblUser.tableFooterView = spinner
            self.tblUser.tableFooterView?.isHidden = false
        }
    }
}

//MARK:-  UITextFieldDelegate Methods
extension HomeVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
            
        default:
            textField.resignFirstResponder()
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let text = textField.text!
        let textRange = Range(range, in: text)!
        let searchText = text.replacingCharacters(in: textRange, with: string)
        
        print("searchText", searchText)
        if searchText.trime().isEmpty {
            
            self.arrOfUsers = self.arrCopyOfUsers
        } else {
            
            self.arrOfUsers = self.arrCopyOfUsers.filter({($0.login?.lowercased().contains(searchText.trime().lowercased()) ?? false)})
        }
        self.tblUser.reloadData()
        
        return true
    }
}
