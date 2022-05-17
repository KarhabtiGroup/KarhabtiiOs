//
//  ViewController.swift
//  karhabti
//
//  Created by iMac on 7/4/2022.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController  {
    let signInConfig = GIDConfiguration.init(clientID: "573746297232-psq8s13qc1l0lm7kedj1uuv02fci9gek.apps.googleusercontent.com")
override func viewDidLoad() {
        super.viewDidLoad()
}


    struct Endpoint
    {
      
        static let showAll = "https://karhabti.onrender.com/api/utilisateurs/index"
        
    }
    
    @IBAction func googleSignIn(_ sender: Any) {
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
          guard error == nil else { return }
            if let profile = user?.profile {
                SignInUtils.register(nom: profile.name, email: profile.email, password: "hasshass", numero: "26322652", datenaissance: "14/08/1998")
            }

        }
    }
    
    
    func showAll()
    {
        var urlRequest = URLRequest(url: URL(string: Endpoint.showAll)!)
               urlRequest.httpMethod = "get"
urlRequest.addValue("application/json", forHTTPHeaderField: "content-type") //this line is very important as explained in the video

                
        URLSession.shared.dataTask(with: urlRequest) { (data, httpUrlResponse, error) in

                  if(data != nil && data?.count != 0)
                  {
                  
                      let response = String(data: data!, encoding: .utf8)
                      debugPrint(response!)
                  }
              }.resume()
          

    }
    
    
}

