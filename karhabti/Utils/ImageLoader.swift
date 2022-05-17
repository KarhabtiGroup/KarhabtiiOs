//
//  ImageLoader.swift
//  karhabti
//
//  Created by iMac on 15/5/2022.
//

import Foundation

import Alamofire

class ImageLoader{
    
    static let shared: ImageLoader = {
        let instance = ImageLoader()
        return instance
    }()
    
    let imageCache = NSCache<NSString,UIImage>()
    let utilityQueue = DispatchQueue.global(qos: .utility)
    
    static let ANNONCE_IMAGE = "ANNONCE_IMAGE"
    static let EVENT_IMAGE = "EVENT_IMAGE"
    
    func loadImage(identifier:String,url:String,completion: @escaping (UIImage?) -> () ) {
        
        if let cachedImage = self.imageCache.object(forKey: NSString(string: identifier)) {
            completion(cachedImage)
        }else{
            utilityQueue.async {
                var urll :URL

                    urll=URL(string: url)!
             
                
                
                guard let data = try? Data(contentsOf: urll) else {return}
                let image = UIImage(data: data)
                DispatchQueue.main.async {
                    self.imageCache.setObject(image!, forKey: NSString(string: identifier))
                    completion (image)
                }
            }
        }
    }
}
