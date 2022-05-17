//
//  GoogleSignInUtils.swift
//  karhabti
//
//  Created by Marwen Krichen on 19/4/2022.
//

import Foundation
import Alamofire
class SignInUtils {
    
    
    struct Endpoint
    {
        static let registerUser = "https://karhabti.onrender.com/api/utilisateurs/store"
 
        
    }
    
    public static func register(nom:String,email:String,password:String,numero:String,datenaissance:String) {
        var urlRequest = URLRequest(url: URL(string: Endpoint.registerUser)!)
               urlRequest.httpMethod = "post"
               let dataDictionary = ["nom":nom,"email":email,"password":password,"phoneNumber":numero,"birthDate":datenaissance]
        
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
                  
                      let response = String(data: data!, encoding: .utf8)
                      debugPrint(response!)
                  }
              }.resume()

    }
    

}
