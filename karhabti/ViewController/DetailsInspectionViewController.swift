//
//  DetailsInspectionViewController.swift
//  karhabti
//
//  Created by Bekri Taher on 3/5/2022.
//

import UIKit

class DetailsInspectionViewController: UIViewController {
    @IBOutlet weak var generalField: UILabel!
    @IBOutlet weak var rouesField: UILabel!
    @IBOutlet weak var chasisField: UILabel!
    @IBOutlet weak var moteurField: UILabel!
    @IBOutlet weak var annonceField: UILabel!
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var utilisateurField: UILabel!
  
    @IBAction func SliderRoues(_ sender: UISlider) {
        rouesField.text=String(round(sender.value))
        roues=String(round(sender.value))
    }
    @IBAction func SliderM(_ sender: UISlider) {
        moteurField.text=String(round(sender.value))
        moteur=String(round(sender.value))

        
    }
    @IBAction func SliderC(_ sender: UISlider) {
        chasisField.text=String(round(sender.value))
        chasis=String(round(sender.value))

    }
    @IBAction func SliderG(_ sender: UISlider) {
        generalField.text=String(round(sender.value))
        general=String(round(sender.value))

    }
    var id : String?
    var annonce : String?
    var date : String?
    var utilisateur : String?
    var moteur : String?
    var chasis : String?
    var roues : String?
    var general : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        annonceField.text=annonce
        dateField.text=date
        utilisateurField.text=utilisateur
        // Do any additional setup after loading the view.
    }
    
  
    @IBAction func QRAction(_ sender: Any) {
        performSegue(withIdentifier: "DetailsQRSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailsQRSegue" {
            
         
            
            let destination = segue.destination as! QRViewController
            destination.annonce = annonce
            
            destination.date = date
            destination.utilisateur = utilisateur
            destination.id=id
            destination.moteur=moteur
            destination.chasis=chasis
            destination.roues=roues
            destination.general=general
           
        }
        
    }
    
    
  
    
    

    

}
