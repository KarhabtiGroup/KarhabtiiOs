//
//  ProfileViewController.swift
//  karhabti
//
//  Created by Bekri Taher on 7/4/2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var user : Utilisateur?

    var name : String?
    var phone : String?
    var gouvernerat : String?
    var date : String?
    var image : String?
    var email : String?

    @IBOutlet weak var profilefield: UILabel!
    @IBOutlet weak var phoneNumberprofile: UILabel!
    @IBOutlet weak var emailprofile: UILabel!
    @IBOutlet weak var dateprofile: UILabel!
    @IBOutlet weak var gouverneratprofile: UILabel!
    @IBOutlet weak var imageprofile: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializePage()    }
    
    
    func initializePage() {
        
        UtilisateurController().getUserById(id: UserDefaults.standard.string(forKey: "id")!) {
            [self] success, result in self.user = result
            
            profilefield.text = result?.nom
        //    dateprofile.text = result?.birthdate
            emailprofile.text = result?.email
            phoneNumberprofile.text = String(Int(result?.phoneNumber ?? 0))
            
            
        }
        
    }
    
    @IBAction func updateprofileaction(_ sender: Any) {
    }
    

}
