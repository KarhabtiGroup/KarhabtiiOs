//
//  ViewController.swift
//  Chicky
//
//  Created by Mac-Mini_2021 on 08/11/2021.
//

import UIKit

class MessagerieView: UIViewController, UITableViewDataSource, UITableViewDelegate, ModalTransitionListener {
    
    // VARS
    private var conversations : [Conversation] = []
    private var selectedConversation: Conversation?
    
    // WIDGETS
    @IBOutlet weak var tableView: UITableView!
    
    // PROTOCOLS
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return conversations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCell3")
        let contentView = cell?.contentView

      //  let imageProfile = contentView?.viewWithTag(31) as! UIImageView
        let labelUsername = contentView?.viewWithTag(12) as! UILabel
        let labellastMessage = contentView?.viewWithTag(13) as! UILabel
        
        let conversation = conversations[indexPath.row]
        let recepteur = conversation.receiver
        

      //  imageProfile.roundedGrayPhoto()
        
        /*  if (recepteur.photo! != ""){
            ImageLoader.shared.loadImage(
                identifier: recepteur.photo!,
                url: "IMAGE_URL + recepteur.idPhoto!",
                completion: { [] image in
                    imageProfile.image = image
                })
        }*/
        
        
        labelUsername.text = recepteur.nom!
        labellastMessage.text = conversation.dernierMessage
        
        print(conversation.dernierMessage)
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedConversation = conversations[indexPath.row]
        self.performSegue(withIdentifier: "conversationSegue", sender: selectedConversation)
    }
    
    
    // LIFECYCLE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "conversationSegue" {
            let destination = segue.destination as! ChatView
            destination.currentConversation = selectedConversation
            destination.title = (selectedConversation?.receiver.nom)!
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ModalTransitionMediator.instance.setListener(listener: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initialize()
    }
    
    // METHODS
    func popoverDismissed() {
        initialize()
    }
    
    func initialize() {
        self.conversations = []
        self.tableView.reloadData()
        MessagerieContoller.sharedInstance.recupererMesConversations { [self] success, conversationsfromRep in
            if success {
                self.conversations = []
                
                
        
                
                for conversation in conversationsfromRep! {
                    conversations.append(conversation)
                    print(conversation)
                }

                self.tableView.reloadData()
            }else {
                self.present(Alert.makeAlert(titre: "Error", message: "Could not load conversations "),animated: true)
            }
        }
    }
}

