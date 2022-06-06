//
//  CoreDataManager.swift
//  Test
//
//  Created by Apple iQlance on 06/06/2022.
//

import UIKit
import CoreData

struct CoreEntity {
    static let usersList = "UsersList"
}

struct CoreAttribute {
    
    static let image = "image"
    static let followers = "followers"
    static let following = "following"
    static let name = "name"
    static let company = "company"
    static let blog = "blog"
    static let notes = "notes"
    static let details = "details"
}

class CoreDataManager: NSObject {
    
    static let shared = CoreDataManager()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func insertUser(user: UsersData, completion: (_ isSuccess: Bool, _ message: String) -> Void) {
        
        let conEntity = NSEntityDescription.entity(forEntityName: CoreEntity.usersList, in: context)
        let newUser = NSManagedObject(entity: conEntity!, insertInto: context)
        newUser.setValue(user.avatar_url, forKey: CoreAttribute.image)
        newUser.setValue(user.followers, forKey: CoreAttribute.followers)
        newUser.setValue(user.following, forKey: CoreAttribute.following)
        newUser.setValue(user.login, forKey: CoreAttribute.name)
        newUser.setValue(user.company, forKey:  CoreAttribute.company)
        newUser.setValue(user.blog, forKey:  CoreAttribute.blog)
        newUser.setValue(user.type, forKey:  CoreAttribute.details)
        newUser.setValue(user.notes, forKey:  CoreAttribute.notes)
        
        do {
            try context.save()
            completion(true, "User Saved Successfully.")
        } catch {
            completion(false, error.localizedDescription)
        }
    }
    
    func getAllUsers() -> [UsersData] {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: CoreEntity.usersList)
        request.returnsObjectsAsFaults = false
        
        var arrOfUsers = [UsersData]()
        
        do {
            
            let result = try context.fetch(request)
            
            for r in result as! [NSManagedObject] {
                
                let image = r.value(forKey: CoreAttribute.image) as? String ?? ""
                let followers = r.value(forKey: CoreAttribute.followers) as? Int ?? 0
                let following = r.value(forKey: CoreAttribute.following) as? Int ?? 0
                let name = r.value(forKey: CoreAttribute.name) as? String ?? ""
                let company = r.value(forKey: CoreAttribute.company) as? String ?? ""
                let blog = r.value(forKey: CoreAttribute.blog) as? String ?? ""
                let details = r.value(forKey: CoreAttribute.details) as? String ?? ""
                let notes = r.value(forKey: CoreAttribute.notes) as? String ?? ""
                
                //arrOfUsers.append(UsersData(login: name ?? "", avatar_url: UIImage(data: image), type: details ?? "", company: company ?? "", blog: blog ?? "", followers: "\(followers ?? 0)", following: "\(following ?? 0)"))
                
                arrOfUsers.append(UsersData(login: name, id: 0, node_id: "", avatar_url: image, gravatar_id: "", url: "", html_url: "", followers_url: "", following_url: "", gists_url: "", starred_url: "", subscriptions_url: "", organizations_url: "", repos_url: "", events_url: "", received_events_url: "", type: details , site_admin: false, name: "", company: company , blog: blog , location: "", email: "", hireable: "", bio: "", twitter_username: "", public_repos: 0, public_gists: 0, followers: followers , following: following , created_at: "", updated_at: "", notes: notes))
            }
            
        } catch {
            print(error.localizedDescription)
        }
        return arrOfUsers
    }
    
    func updateUser(user: UsersData, completion: (_ isSuccess: Bool, _ message: String) -> Void) {
        
        if let objID = user.id {
        
            do {
                
//                let result = try context.existingObject(with: objID)
//
//                result.setValue(user.avatar_url, forKey: CoreAttribute.image)
//                result.setValue(user.followers, forKey: CoreAttribute.followers)
//                result.setValue(user.following, forKey: CoreAttribute.following)
//                result.setValue(user.login, forKey: CoreAttribute.name)
//                result.setValue(user.company, forKey: CoreAttribute.company)
//                result.setValue(user.blog, forKey: CoreAttribute.blog)
//                result.setValue(user.type, forKey: CoreAttribute.details)
//                result.setValue(user.notes, forKey: CoreAttribute.notes)
                
                try context.save()
                completion(true, "Update user successfullly!")
                
            } catch {
                completion(false, "Error in update data: \(error.localizedDescription)")
            }
        } else {
            completion(false, "User ObjectID not found, Please try again letter!")
        }
    }
}
