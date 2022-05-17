//
//  UtilisateurController.swift
//  karhabti
//
//  Created by Bekri Taher on 27/4/2022.
//

import UIKit
import Alamofire
import UIKit.UIImage
import SwiftyJSON

class UtilisateurController {

    static let sharedInstance = UtilisateurController()
    
    func signin(email : String, password: String, completed : @escaping (Bool, Any?) -> Void) {
        AF.request("https://karhabti.onrender.com/api/utilisateurs/login",
                   method: .post,
                   parameters: ["email": email, "password": password])
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    let user = self.makeItem(jsonItem: jsonData["user"])
                    UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "tokenConnexion")
                    UserDefaults.standard.setValue(user._id, forKey: "id")
                    print(user)
                    
                    completed(true, user)
                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)
                }
            }
    }
    
    func signup(user: Utilisateur, completed: @escaping (Bool) -> Void) {
        AF.request("https://karhabti.onrender.com/api/utilisateurs/register",
                   method: .post,
                   parameters: [
                    
                    "email": user.email!,
                    "password": user.password!,
                    "name": user.nom!,
                    "birthdate": DateUtils.formatFromDate(date: user.birthdate!) ,
                    "photo": user.photo!,
                    "address":user.adress!,
                    "phoneNumber" : user.phoneNumber!
                   ] ,encoding: JSONEncoding.default)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                    completed(true)
                case let .failure(error):
                    print(error)
                    completed(false)
                }
            }
    }
    func makeItem(jsonItem: JSON) -> Utilisateur {
         
         
         return Utilisateur(
             _id: jsonItem["_id"].stringValue,
             nom: jsonItem["name"].stringValue,
             birthdate: DateUtils.formatFromString(string: jsonItem["birthdate"].stringValue),
             adress : jsonItem["adress"].stringValue,
             email: jsonItem["email"].stringValue,
           
             password: jsonItem["password"].stringValue,
             
             phoneNumber : jsonItem["phoneNumber"].intValue,
             
             photo: jsonItem["idPhoto"].stringValue,
             
             isVerified: jsonItem["isVerified"].boolValue,
             
             role: jsonItem["role"].stringValue,
             latitude: jsonItem["latitude"].stringValue,
             longtitude: jsonItem["longtitude"].stringValue
         )
     }
    func getUserById(id: String, completed: @escaping(Bool, Utilisateur?) -> Void) {
         print("Looking for user --------------------")
         AF.request("https://karhabti.onrender.com/api/utilisateurs/show",
                    method: .post,
                    parameters: ["id": UserDefaults.standard.string(forKey: "id")],
                    encoding: JSONEncoding.default)
             .validate(statusCode: 200..<300)
             .validate(contentType: ["application/json"])
             .response { response in
                 switch response.result {
                 case .success:
                     let jsonData = JSON(response.data!)
                     let user = self.makeItem(jsonItem: jsonData["utilisateur"])
                     print("Found user --------------------")
                     print(user)
                     print("-------------------------------")
                    
                     completed(true, user)
                 case let .failure(error):
                     debugPrint(error)
                     completed(false, nil)
                 }
             }
         
     }
    

    
    
    func reSendConfirmationEmail(email: String, completed: @escaping (Bool) -> Void) {
            AF.request("https://karhabti.onrender.com/api/utilisateurs/resendconfirmationemail",
                       method: .post,
                       parameters: ["email": email])
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                    case .success:
                        print("Validation Successful")
                        completed(true)
                    case let .failure(error):
                        print(error)
                        completed(false)
                    }
                }
        }
        func forgetPassword(email: String, codeDeReinit: String, completed: @escaping (Bool) -> Void) {
            AF.request("https://karhabti.onrender.com/api/utilisateurs/forgot-password",
                       method: .post,
                       parameters: ["email": email, "codeDeReinit": codeDeReinit])
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                    case .success:
                        print("Validation Successful")
                        completed(true)
                    case let .failure(error):
                        print(error)
                        completed(false)
                    }
                }
        }
    
    public static func getMecaniciens(ccompletionHandler: @escaping ([Utilisateur]) -> Void) {
        AF.request("https://karhabti.onrender.com/api/utilisateurs/getmeca").responseDecodable(of: UtilisateurResult.self) { result in
            switch result.result {
            case .success(let utilisateur):
                print(utilisateur)
                ccompletionHandler(utilisateur.utilisateur)
            case .failure(let error):
                print(error)
            }
        }

    }
    
    func updateProfile (user: Utilisateur, methode: HTTPMethod, completed: @escaping (Bool) -> Void) {
            print(user)
            AF.request("https://karhabti.onrender.com/api/utilisateurs/update-profile",
                       method: methode,
                       parameters: [
                        "email": user.email!,
                        "adress": user.adress!,
                        "name": user.nom!,
                        "phoneNumber": user.phoneNumber!,
                   //     "birthdate": DateUtils.formatFromDate(date: user.birthdate!),
                        //"photo": utilisateur.photo!,
                    
                       ])
                .response { response in
                    print(response)
                }
        }
    func changepassword(email: String, newPassword: String, completed: @escaping (Bool) -> Void) {
            AF.request("https://karhabti.onrender.com/api/utilisateurs/resetPass",
                       method: .put,
                       parameters: ["email": email,"newPassword": newPassword])
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .responseData { response in
                    switch response.result {
                    case .success:
                        print("Validation Successful")
                        completed(true)
                    case let .failure(error):
                        print(error)
                        completed(false)
                    }
                }
        }
}

    /*    func loginWithSocialApp(email: String, nom: String, completed: @escaping (Bool, Utilisateur?) -> Void ) {
            AF.request("https://karhabti.onrender.com/api/utilisateurs/loginWithSocial",
                       method: .post,
                       parameters: [
                        "email": email,
                        "name": nom
                        
                       ],
                       encoding: JSONEncoding.default)
                .validate(statusCode: 200..<300)
                .validate(contentType: ["application/json"])
                .response { response in
                    switch response.result {
                    case .success:
                        let jsonData = JSON(response.data!)
                        let user = self.makeItem(jsonItem: jsonData["user"])
                        
                        print("this is the new token value : " + jsonData["token"].stringValue)
                        UserDefaults.standard.setValue(jsonData["token"].stringValue, forKey: "tokenConnexion")
                        UserDefaults.standard.setValue(user._id, forKey: "idUser")
                       
                        completed(true, user)
                    case let .failure(error):
                        debugPrint(error)
                        completed(false, nil)
                    }
                }
        }*/


