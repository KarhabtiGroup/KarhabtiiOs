//
//  LogInViewController.swift
//  karhabti
//
//  Created by Mac-Mini-2021 on 16/4/2022.
//

import UIKit

class LogInViewController: UIViewController {
    var exit=0
    let spinner = SpinnerViewController()
    var email: String?
    let userViewModel = UtilisateurController()

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    struct Endpoint
    {
 
        static let logIn = "https://karhabti.onrender.com/api/utilisateurs/signin"
    }

    
    
    func logIn(email:String,password:String)
    {

        var urlRequest = URLRequest(url: URL(string: Endpoint.logIn)!)
               urlRequest.httpMethod = "post"
        let dataDictionary = ["email":email,"password":password]
        
        do {
                    let requestBody = try JSONSerialization.data(withJSONObject: dataDictionary, options: .prettyPrinted)

                    urlRequest.httpBody = requestBody
                    urlRequest.addValue("application/json", forHTTPHeaderField: "content-type") //this line is very important as explained in the video

                } catch let error {
                    debugPrint(error.localizedDescription)
                }

        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in

                  if(data != nil && data?.count != 0)
                  {
                 
                     let response =  String(data: data!, encoding: .utf8)
                      print(response!)
                      if (response!.contains("Wrong informations"))
                      {
                       
                       
                          print("Wrong Infos!")
                         
                      }
                      else {print("Welcome!")
                          self.exit=1
                      
                          
                      }
                            
                  }
              }.resume()
     
        
    }


    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    
    
    
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
    
    
    
    
    
    
    
    
    
    
     //Functions
     func reSendEmail(email: String?) {
         userViewModel.reSendConfirmationEmail(email: email!, completed: { (success) in
             if success {
                 self.present(Alert.makeAlert(titre: "Success", message: "Confirmation email has been sent to " + email!), animated: true)
             } else {
                 self.present(Alert.makeAlert(titre: "Error", message: "Could not send the confirmation email"), animated: true)
             }
         })
     }
     func startSpinner() {
         addChild(spinner)
         spinner.view.frame = view.frame
         view.addSubview(spinner.view)
         spinner.didMove(toParent: self)
     }
     
     func stopSpinner() {
         spinner.willMove(toParent: nil)
         spinner.view.removeFromSuperview()
         spinner.removeFromParent()
     }
     
    
     
    
    @IBAction func loginBtn(_ sender: Any)  {
        
               if(emailField.text!.isEmpty || passwordField.text!.isEmpty){
                   self.present(Alert.makeAlert(titre: "Warning", message: "Please type your credentials"), animated: true)
                   return
               }
               startSpinner()

               userViewModel.signin(email: emailField.text!, password: passwordField.text!,completed: { (success, reponse) in
                   
                   self.stopSpinner()

                   if success {
                       var user = reponse as! Utilisateur
                       print(user.isVerified!)
                       print(user)
                       if user.isVerified! {
                          user.role="ROLE_MECANIC"
                           if (user.role=="ROLE_USER")
                           {
                               self.performSegue(withIdentifier: "LogintohomeSegue", sender: nil)}
                           else {self.performSegue(withIdentifier: "LogintomecanicSegue", sender: nil) }

                           
                       } else {
                           let action = UIAlertAction(title: "Resend", style: .default) { UIAlertAction in
                               self.reSendEmail(email: user.email)
                           }
                           self.present(Alert.makeActionAlert(titre: "Notice", message: "This email is not confirmed, would you like to resend the confirmation email to " + user.email! + " ?", action: action),animated: true)
                           self.reSendEmail(email: user.email)
                       }
                   } else {
                       self.present(Alert.makeAlert(titre: "Warning", message: "Email or password incorrect"), animated: true)
                   }
               })
}
    }

