//
//  MecaniciensViewController.swift
//  karhabti
//
//  Created by Mac-Mini_2021 on 13/05/2022.
//

import UIKit

class MecaniciensViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var annonceid:String?
    @IBOutlet weak var tableViewMeca: UITableView!
    var utilisateurs: [Utilisateur] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        utilisateurs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCellMeca")
        let cv = cell?.contentView
        
//        let imageview = cv?.viewWithTag(1) as! UIImageView
        let nom = cv?.viewWithTag(1) as! UILabel
        let numero = cv?.viewWithTag(2) as! UILabel
        let adresse = cv?.viewWithTag(3) as! UILabel

      //  imageview.image = UIImage(named: sandwichs[indexPath.row])
        let utilisateur = utilisateurs[indexPath.row]
        nom.text = utilisateur.name
        numero.text = String(utilisateur.phoneNumber!)
        adresse.text = utilisateur.adress

        return cell!
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UtilisateurController.getMecaniciens{ utilisateurs in
            self.utilisateurs = utilisateurs
                self.tableViewMeca.reloadData()
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "segueMecaDesc", sender: indexPath)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "segueMecaDesc" {
            
            let indexPath = sender as! IndexPath
            
            let destination = segue.destination as! AjoutInspectionViewController
            destination.annonceid = annonceid
            destination.mecanicienid=utilisateurs[indexPath.row]._id
            destination.name=utilisateurs[indexPath.row].name
            destination.latitude=utilisateurs[indexPath.row].latitude
            destination.longtitude=utilisateurs[indexPath.row].longtitude
            destination.numero=String(utilisateurs[indexPath.row].phoneNumber!)
            destination.adresse=utilisateurs[indexPath.row].adress


        
           
           
        }
        
    }
 

}
