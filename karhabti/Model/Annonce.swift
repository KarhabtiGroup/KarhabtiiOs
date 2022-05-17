//
//  Annonce.swift
//  karhabti
//
//  Created by Mac-Mini-2021 on 16/4/2022.
//

import Foundation

struct AnnonceResult: Codable {
    var annonce: [Annonce]
}

struct Annonce : Codable {

    var _id : String?
    var titre : String?
    var price : String?
    var gouvernerat : String?
    var bodys : String?
    var fiscalPower : String?
    var energy : String?
    var gearbox : String?
    var kilometrage : String?
    var color : String?
    var year : String?
    var image : String?
    var users : String?

    
    
}
