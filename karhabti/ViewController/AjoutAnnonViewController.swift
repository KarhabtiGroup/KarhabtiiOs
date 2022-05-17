//
//  AjoutAnnonViewController.swift
//  karhabti
//
//  Created by Bekri Taher on 7/4/2022.
//

import UIKit

class AjoutAnnonViewController: UIViewController {

    @IBOutlet weak var yearField: UITextField!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var gouvernerat: UITextField!
    @IBOutlet weak var priceField: UITextField!
    @IBOutlet weak var bodyField: UITextField!
    @IBOutlet weak var fiscalField: UITextField!
    @IBOutlet weak var energyField: UITextField!
    @IBOutlet weak var gearboxField: UITextField!
    @IBOutlet weak var kilometrageField: UITextField!
    @IBOutlet weak var colorField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func AddAnnonceButton(_ sender: Any) {
        let users = UserDefaults.standard.string(forKey: "id")!
        AnnonceController.addAnnonce(
            title: titleField.text!,
            price: gouvernerat.text!,
            gouvernerat: priceField.text!,
            bodys: bodyField.text!,
            fiscalPower: fiscalField.text!,
            energy: energyField.text!,
            kilometrage: kilometrageField.text!,
            gearbox: gearboxField.text!,
            color: colorField.text!,
            year: yearField.text!,
            image: "aa",
            users: users
        )
    
    }
    
    

}
