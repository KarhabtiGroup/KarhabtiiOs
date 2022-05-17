//
//  EditProfileViewController.swift
//  karhabti
//
//  Created by Bekri Taher on 7/4/2022.
//

import UIKit

class EditProfileViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    var user : Utilisateur?

    @IBAction func confirmBtn(_ sender: Any) {
        
        print("Edited profile")
        
        if (nameField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Error", message: "Please type your name"), animated: true)
            return
        }
        
        if (addressField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Error", message: "Please type your address"), animated: true)
            return
        }
        
        if (emailField.text!.isEmpty) {
            self.present(Alert.makeAlert(titre: "Error", message: "Please type your emergency number"), animated: true)
            return
        }
        
        
        
        //user?.idPhoto = ""
        
        user?.nom = nameField.text
        user?.adress = addressField.text
        user?.email = emailField.text

        UtilisateurController().updateProfile(user: user!, methode: .put, completed:{
            (success) in
            print (success)
            if success {
            }else{
            }
        } )
        _ = navigationController?.popViewController(animated: true)


      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializePage()
    }
    
    func initializePage() {
          
        UtilisateurController().getUserById(id: UserDefaults.standard.string(forKey: "id")!) {
                [self] success, result in self.user = result
                
                        print("user : ------------")
                        print(UserDefaults.standard.string(forKey: "id"))
                print(user)
            
                nameField.text = user?.nom
            addressField.text = user?.adress!
            emailField.text = user?.email!
            
            phoneField.text = String(Int((user?.phoneNumber)!))


            }
}
    


    }
