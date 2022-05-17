//
//  ForgetPassViewController.swift
//  karhabti
//
//  Created by Apple Esprit on 11/5/2022.
//

import UIKit

class ForgetPassViewController: UIViewController {

    
    
    @IBOutlet weak var emailField: UITextField!
    

    //var
    struct MotDePasseOublieData {
        var email: String?
        var code: String?
    }
    var data : MotDePasseOublieData?
    let spinner = SpinnerViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func ResetPassBtn(_ sender: Any) {
        if (emailField.text!.isEmpty){
            self.present(Alert.makeAlert(titre: "Warning", message: "Please type your email"), animated: true)
            return


    }
        startSpinner()
        
        data = MotDePasseOublieData(email: emailField.text, code: String(Int.random(in: 1000..<9999)))
        
        UtilisateurController().forgetPassword(email: (data?.email)!, codeDeReinit: (data?.code)! ) { success in
            self.stopSpinner()
            if success {
                self.performSegue(withIdentifier: "Confirm", sender: self.data)
            } else {
                self.present(Alert.makeAlert(titre: "Error", message: "Email does not exist"), animated: true)
            }
        }
    


}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! ForgetPassVerificationViewController
        destination.data = data
        destination.email = emailField.text
    }
    
    func startSpinner() {
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
    }
    
    func stopSpinner() {
        spinner.willMove(toParent: nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
