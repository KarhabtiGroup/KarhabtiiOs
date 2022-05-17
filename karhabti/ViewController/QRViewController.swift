//
//  QRViewController.swift
//  karhabti
//
//  Created by Bekri Taher on 3/5/2022.
//

import UIKit
import Foundation
import SwiftUI
import CoreImage.CIFilterBuiltins

class QRViewController: UIViewController {
    var moteur : String?
    var chasis : String?
    var roues : String?
    var general : String?
    var id : String?
    @IBOutlet weak var annonceField: UILabel!
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var utilisateurField: UILabel!
    @IBOutlet weak var QRImage: UIImageView!
    var annonce : String?
    var date : String?
    var utilisateur : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        annonceField.text=annonce
        dateField.text=date
        utilisateurField.text=utilisateur
        let QRimg = generateQRCode(from: "Inspection confirmed!")
        self.QRImage.image = QRimg
        // Do any additional setup after loading the view.
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)
        if let QRFilter = CIFilter(name: "CIQRCodeGenerator") {
            QRFilter.setValue(data, forKey: "inputMessage")
            guard let QRImage = QRFilter.outputImage else {return nil}
            return UIImage(ciImage: QRImage)
        }
        return nil
    }
    @IBAction func backToList(_ sender: Any) {
        InspecterController.updateInspection(
            id:id!,moteur:moteur!, chasis: chasis!, roues: roues!, general:  general!,done:true)
        performSegue(withIdentifier: "backToIspectionsSegue", sender: nil)
    }
    
}
