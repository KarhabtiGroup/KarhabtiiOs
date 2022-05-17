//  AnnonceViewController.swift
//  karhabti
//
//  Created by Marwen Krichen on 20/4/2022.
//

import UIKit

class AnnonceViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var annonces: [Annonce] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        AnnonceController.getAnnonce { annonces in
            self.annonces = annonces
            self.tableView.reloadData()
            
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        annonces.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCel")
        let cv = cell?.contentView
        
        let name = cv?.viewWithTag(2) as! UILabel
        let price = cv?.viewWithTag(4) as! UILabel
        let boite = cv?.viewWithTag(9) as! UILabel
        let kms = cv?.viewWithTag(10) as! UILabel
        let year = cv?.viewWithTag(11) as! UILabel
        let titleContainer = cv?.viewWithTag(5)
        let priceContainer = cv?.viewWithTag(7)
        let container = cv?.viewWithTag(6)

        container?.addCornerRadius(radius: 12)
        container?.addShadow(color: UIColor.black.cgColor, opacity: 0.5, offset: CGSize(width: 3, height: 3), radius: 4)
        
        let annonce = annonces[indexPath.row]
        titleContainer?.addGradientColorBackground(gradient: UIColor.getPriceContainerGradient())
        priceContainer?.roundCorners(corners: .topLeft, radius: 20)
        name.text = annonce.titre
        price.text = annonce.price
        boite.text = annonce.gearbox
        kms.text = annonce.kilometrage
        year.text = annonce.year
        
        
        
        

        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "AnndescSegue", sender: indexPath)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AnndescSegue" {
            
            let indexPath = sender as! IndexPath
            
            let destination = segue.destination as! DetailsAnnonceViewController
            destination.id = annonces[indexPath.row]._id
            destination.titre = annonces[indexPath.row].titre
            destination.price = annonces[indexPath.row].price
            destination.gouvernerat = annonces[indexPath.row].gouvernerat
            destination.bodys = annonces[indexPath.row].bodys
            destination.fiscalPower = annonces[indexPath.row].fiscalPower
            destination.energy = annonces[indexPath.row].energy
            destination.gearbox = annonces[indexPath.row].gearbox
            destination.kilometrage = annonces[indexPath.row].kilometrage
            destination.color = annonces[indexPath.row].color
            destination.year = annonces[indexPath.row].year
            destination.image = annonces[indexPath.row].image
            destination.users = annonces[indexPath.row].users
          
           
        }
        
    }
    

}
