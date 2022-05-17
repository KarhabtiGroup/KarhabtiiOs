//
//  Inspection.swift
//  karhabti
//
//  Created by Mac-Mini-2021 on 16/4/2022.
//

import Foundation

struct InspectionResult: Codable {
    var inspection: [Inspection]
}

struct Inspection : Codable {
    var _id:String?
    var mecanicien:String?
    var annonce:String?
    var utilisateur:String?
    var date:String?
    var moteur:String?
    var chasis:String?
    var roues:String?
    var general:String?
    var done:Bool?

        
    
    
    
}
