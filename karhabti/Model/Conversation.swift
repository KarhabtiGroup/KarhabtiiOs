//
//  Conversation.swift
//  Chicky
//
//  Created by Mac2021 on 15/11/2021.
//

import Foundation

struct Conversation {
    
    internal init(_id: String? = nil, dernierMessage: String, dateDernierMessage: Date, sender: Utilisateur, receiver: Utilisateur) {
        self._id = _id
        self.dernierMessage = dernierMessage
        self.dateDernierMessage = dateDernierMessage
        self.sender = sender
        self.receiver = receiver
    }
    
    var _id : String?
    var dernierMessage : String
    var dateDernierMessage : Date
    
    // relations
    var sender : Utilisateur
    var receiver : Utilisateur
}
