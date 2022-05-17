//
//  InspectionViewController.swift
//  karhabti
//
//  Created by Marwen Krichen on 20/4/2022.
//

import UIKit

class InspectionViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var inspections: [Inspection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        InspecterController.getInspection{ inspections in
            self.inspections = inspections
                self.tableView.reloadData()
            
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        inspections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell2")
        let cv = cell?.contentView
        
//        let imageview = cv?.viewWithTag(1) as! UIImageView
        let annonce = cv?.viewWithTag(1) as! UILabel
        let date = cv?.viewWithTag(2) as! UILabel
        let utilisateur = cv?.viewWithTag(3) as! UILabel

      //  imageview.image = UIImage(named: sandwichs[indexPath.row])
        let inspection = inspections[indexPath.row]
      //  let datex = NSDate(timeIntervalSince1970: parseDuration(inspection.date!))
   
  
        annonce.text = inspection.annonce
        date.text = inspection.date
        utilisateur.text = inspection.utilisateur

        return cell!
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "DetailsInspectionSegue", sender: indexPath)
        
    }
    func parseDuration(_ timeString:String) -> TimeInterval {
        guard !timeString.isEmpty else {
            return 0
        }

        var interval:Double = 0

        let parts = timeString.components(separatedBy: ":")
        for (index, part) in parts.reversed().enumerated() {
            interval += (Double(part) ?? 0) * pow(Double(60), Double(index))
        }

        return interval
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailsInspectionSegue" {
            
            let indexPath = sender as! IndexPath
            
            let destination = segue.destination as! DetailsInspectionViewController
            destination.annonce = inspections[indexPath.row].annonce
            destination.id=inspections[indexPath.row]._id
            destination.date = inspections[indexPath.row].date
            destination.utilisateur = inspections[indexPath.row].utilisateur
           
           
        }
        
    }
    

}
