//
//  AnnonceController.swift
//  karhabti
//
//  Created by Marwen Krichen on 19/4/2022.
//

import Foundation
import Alamofire
import SwiftyJSON


class AnnonceController {
    
    
    
    struct Endpoint
    {
        static let addAnnonce = "https://karhabti.onrender.com/api/annonce/stores"
        static let getAnnonce = "https://karhabti.onrender.com/api/annonce/index"
        static let getnews    = "https://newsapi.org/v2/everything?q=tesla&from=2022-04-14&sortBy=publishedAt&apiKey=380a73e6e6254d10a31dc8288c955a40"
        
    }
    
    func recupererToutNews(  completed: @escaping (Bool, [Articles]?) -> Void ) {
        AF.request("https://newsapi.org/v2/everything?q=tesla&from=2022-04-14&sortBy=publishedAt&apiKey=380a73e6e6254d10a31dc8288c955a40",
                   method: .get)
            .validate(statusCode: 200..<300)
            .validate(contentType: ["application/json"])
            .responseData { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(response.data!)
                    var news : [Articles]? = []

                    for singleJsonItem in jsonData["articles"] {
                        news!.append(self.makeCommentaire(jsonItem: singleJsonItem.1))
                    }
                    completed(true, news)
                    print(news)

                case let .failure(error):
                    debugPrint(error)
                    completed(false, nil)

                }

            }
    }
    func makePublication(jsonItem: JSON) -> News {
        var articles: [Articles] = []
        for i in jsonItem["articles"] {
            articles.append(makeCommentaire(jsonItem: i.1))
        }
        print(articles)

        return News(
            status: jsonItem["status"].stringValue,
            totalResults: jsonItem["totalResults"].stringValue,
            articles: articles
        )
    }
    
    func makeCommentaire(jsonItem: JSON) -> Articles {
   
        Articles(
            title: jsonItem["title"].stringValue, description: jsonItem["description"].stringValue, urlToImage: jsonItem["urlToImage"].stringValue
        )
    }

    public static func addAnnonce(title:String,price:String,gouvernerat:String,bodys:String,fiscalPower:String,energy:String,kilometrage:String,gearbox:String,color:String,year:String,image:String,users:String) {
        var urlRequest = URLRequest(url: URL(string: Endpoint.addAnnonce)!)
               urlRequest.httpMethod = "post"
               let dataDictionary = ["titre":title,"price":price,"gouvernerat":gouvernerat,"bodys":bodys, "fiscalPower":fiscalPower,"energy":energy,"kilometrage":kilometrage,"gearbox":gearbox,"color":color,"year":year,"image":image,"users":users]
        
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
    
    public static func getAnnonce(ccompletionHandler: @escaping ([Annonce]) -> Void) {
        AF.request(Endpoint.getAnnonce).responseDecodable(of: AnnonceResult.self) { result in
            switch result.result {
            case .success(let annonce):
                print(annonce)
                ccompletionHandler(annonce.annonce)
            case .failure(let error):
                print(error)
            }
        }

    }
}
