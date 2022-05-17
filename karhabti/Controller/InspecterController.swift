//
//  InspecterController.swift
//  karhabti
//
//  Created by Marwen Krichen on 19/4/2022.
//

import Foundation
import Alamofire


class InspecterController {
    
    
    
    struct Endpoint
    {
        static let addInspection = "https://karhabti.onrender.com/api/inspection/store"
        static let getInspection = "https://karhabti.onrender.com/api/inspection/index"
        static let updateInspection = "https://karhabti.onrender.com/api/inspection/update"

        
    }
    
    public static func addInspection(mecanicien:String,annoncess:String,utilisateur:String,date:String,moteur:String,chasis:String,roues:String,general:String,done:Bool) {
        var urlRequest = URLRequest(url: URL(string: Endpoint.addInspection)!)
               urlRequest.httpMethod = "post"
        let dataDictionary = ["mecanicien":mecanicien,"annonce":annoncess,"utilisateur":utilisateur,"date":date,"moteur":moteur,"chasis":chasis,"roues":roues,"general":general,String(done):"done"]
        
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
    
    
    public static func updateInspection(id:String,moteur:String,chasis:String,roues:String,general:String,done:Bool) {
        var urlRequest = URLRequest(url: URL(string: Endpoint.updateInspection)!)
               urlRequest.httpMethod = "post"
        let dataDictionary = ["id":id,"moteur":moteur,"chasis":chasis,"roues":roues,"general":general,String(done):"done"]
        
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
    
    public static func getInspection(ccompletionHandler: @escaping ([Inspection]) -> Void) {
        AF.request(Endpoint.getInspection, method: .post,
                   parameters: [ "id" : UserDefaults.standard.string(forKey: "id")!]).responseDecodable(of: InspectionResult.self) { result in
            switch result.result {
            case .success(let inspection):
                print(inspection)
                ccompletionHandler(inspection.inspection)
            case .failure(let error):
                print(error)
            }
        }

    }
    

    
    
}
