//
//  AjoutInspectionViewController.swift
//  karhabti
//
//  Created by Bekri Taher on 27/4/2022.
//

import UIKit
import MapKit
class AjoutInspectionViewController: UIViewController {
    var user : Utilisateur?
var mecanicienid:String?
    var name:String?
    var numero:String?
    var adresse:String?
    var utilisateurid:String?
    var annonceid:String?
    var latitude:String?
    var longtitude:String?
   

   
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var adresseField: UILabel!
    @IBOutlet weak var numberField: UILabel!
    @IBOutlet weak var nomField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        initializePage()
        adresseField.text=adresse
        numberField.text=numero
        nomField.text=name
        let initialLoc = CLLocationCoordinate2D(latitude: 36.806496, longitude:10.181532 )
        setStartingLocation(location: initialLoc, distance: 15000)
        addAnotation()
        // Do any additional setup after loading the view.
    }
    
    
    func initializePage() {
        
        UtilisateurController().getUserById(id: UserDefaults.standard.string(forKey: "id")!) {
            [self] success, result in self.user = result
            utilisateurid=result?.nom
           // profilefield.text = result?.nom
          //  phoneNumberprofile.text = String(Int(result?.phoneNumber ?? 0))
            
            
        }
        
    }
    func setStartingLocation(location: CLLocationCoordinate2D,distance:CLLocationDistance ){
    let region=MKCoordinateRegion(center: location, latitudinalMeters: distance, longitudinalMeters: distance)
        mapView.setRegion(region, animated: true)
        mapView.setCameraBoundary(MKMapView.CameraBoundary(coordinateRegion: region), animated: true)
        let zoomRange = MKMapView.CameraZoomRange(maxCenterCoordinateDistance: 30000)
        mapView.setCameraZoomRange(zoomRange, animated: true)
    }
    
    func addAnotation(){
        let pin = MKPointAnnotation()
        pin.coordinate = CLLocationCoordinate2D(latitude: Double(latitude!)!, longitude: Double(longtitude!)!)
        pin.title = name
        pin.subtitle=numero
        mapView.addAnnotation(pin)
    }
    
    @IBAction func add(_ sender: Any) {
        InspecterController.addInspection(mecanicien: mecanicienid!, annoncess: annonceid!, utilisateur: utilisateurid!, date: "", moteur:"" , chasis: "", roues: "", general:  "",done:false)
        performSegue(withIdentifier: "backToHome1Segue", sender: nil)
    }

}
