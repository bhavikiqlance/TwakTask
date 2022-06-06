//
//  HomeTableViewCell.swift
//  Test
//
//  Created by Apple iQlance on 03/06/2022.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    //MARK:-  Outlets and Variable Declarations
    @IBOutlet weak var imgUser: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblDetails: UILabel!
    @IBOutlet weak var btnFile: UIButton!
    
    //MARK:- 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:-  Buttons Clicked Action
    
    //MARK:-  Functions
    func configureCell(users:UsersData) {
        
        self.lblUserName.text = users.login ?? ""
        self.lblDetails.text = users.type ?? ""
        self.imgUser.loadFrom(URLAddress: users.avatar_url ?? "person.circle.fill")
        
        if users.notes == "" {
            self.btnFile.isHidden = true
        } else {
            self.btnFile.isHidden = false
        }
    }

}
