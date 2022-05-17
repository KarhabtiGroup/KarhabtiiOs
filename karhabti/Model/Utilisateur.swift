//
//  Utilisateur.swift
//  karhabti
//
//  Created by Mac-Mini-2021 on 16/4/2022.
//

import Foundation

struct UtilisateurResult: Codable {
    var utilisateur: [Utilisateur]
}

struct Utilisateur : Codable {
    
    
    
    
    internal init(_id: String? = nil, nom: String? = nil,name: String? = nil, birthdate: Date? = nil, adress: String? = nil, email: String? = nil, password: String? = nil, is_mecanicien: Bool? = nil,phoneNumber: Int? = nil, photo: String? = nil, isVerified: Bool? = nil, role: String? = nil,latitude: String?,longtitude: String?){
        
        self._id = _id
        self.name = name
        self.nom = nom
        self.birthdate = birthdate
        self.adress = adress
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.photo = photo
        self.isVerified = isVerified
        self.role = role
        self.latitude = latitude
        self.longtitude = longtitude
        self.is_mecanicien = is_mecanicien
    }
    
    
    
    var _id : String?
    var birthdate: Date?
    var phoneNumber : Int?
    var photo : String?
    var isVerified : Bool?
    var nom: String?
    var name: String?
    var email: String?
    var password: String?
    var adress: String?
    var latitude: String?
    var longtitude: String?

    var is_mecanicien : Bool?
    var role: String?
}
