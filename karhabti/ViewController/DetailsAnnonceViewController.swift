//
//  DetailsAnnonceViewController.swift
//  karhabti
//
//  Created by Bekri Taher on 7/4/2022.
//

import UIKit
//private var conversations : [Conversation] = []
//private var selectedConversation: Conversation?
class DetailsAnnonceViewController: UIViewController {
    var id : String?
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
   // var currentConversation: Conversation?


    @IBOutlet weak var idField: UILabel!
    @IBOutlet weak var image3Field: UIImageView!
    @IBOutlet weak var image2field: UIImageView!
    @IBOutlet weak var image1field: UIImageView!
    @IBOutlet weak var imageField: UIImageView!
    @IBOutlet weak var titreField: UILabel!
    @IBOutlet weak var prixField: UILabel!
    @IBOutlet weak var gouvernouratField: UILabel!
    @IBOutlet weak var couleurField: UILabel!
    @IBOutlet weak var kilometrageField: UILabel!
    @IBOutlet weak var gearboxField: UILabel!
    @IBOutlet weak var energyField: UILabel!
    @IBOutlet weak var bodyField: UILabel!
    @IBOutlet weak var yearField: UILabel!
    @IBOutlet weak var fiscalPowerField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        idField.text=id
        titreField.text=titre
        prixField.text=price
        gouvernouratField.text=gouvernerat
        bodyField.text=bodys
        fiscalPowerField.text=fiscalPower
        energyField.text=energy
        gearboxField.text=gearbox
        kilometrageField.text=kilometrage
        couleurField.text=color
        yearField.text=year
        //image.text=image
        //users.text=users
       // selectedConversation?.sender = Utilisateur(_id: users, nom: "taher", name: "bekri", adress: "ariana", email: "taherbekri@gmail.com", password: "taher1920", is_mecanicien: true, phoneNumber: 26322739 , photo: "aaa", isVerified: true, role:     "RSER")
     }
    
    
    
    @IBAction func inspectBtn(_ sender: Any) {
        performSegue(withIdentifier: "segueMecaList", sender: nil)
    }
    
    @IBAction func contactTap(_ sender: Any) {
        MessagerieContoller.sharedInstance.creerNouvelleConversation(recepteur: users!) { isError, conversation in
            if !isError {
                return
            }
            if let conversation = conversation {
                let chatView = ChatView()
                chatView.currentConversation = conversation
                self.present(chatView, animated: true)
            }
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueMecaList" {
            
    
            
            let destination = segue.destination as! MecaniciensViewController
            destination.annonceid = titre
          
 
        }else
            if segue.identifier == "conversationSegue" {
            }
        
    }
  
    
}
