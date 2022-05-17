//
//  SignUpViewController.swift
//  karhabti
//
//  Created by Mac-Mini-2021 on 16/4/2022.
//

import UIKit

class SignUpViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
   

        // Do any additional setup after loading the view.
    }
    

 
    @IBAction func signupBtn(_ sender: Any) {
        registerUser(nom: nomField.text!, email: emailField.text!, password: passwordField.text!, numero: numeroField.text!, datenaissance: dateField.text!)
    }
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var numeroField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var nomField: UITextField!

    func registerUser(nom:String,email:String,password:String,numero:String,datenaissance:String)
    {
        SignInUtils.register(nom: nom, email: email, password: password, numero: numero, datenaissance: datenaissance)
        let defaults = UserDefaults.standard
        defaults.set(nom, forKey: "nom")
        defaults.set(email, forKey: "email")
        defaults.set(numero, forKey: "numero")
        defaults.set(datenaissance, forKey: "datenaissance")
        
    }
    
 
    

    
    
    
    

}
