//
//  NewsViewController.swift
//  karhabti
//
//  Created by iMac on 14/5/2022.
//

import UIKit

class NewsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    //var news: [Articles] = []
    var articles: [Articles] = []

    @IBOutlet weak var tableView: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        articles.count
    }
    
    //@IBOutlet weak var imageview: UIImageView!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "mCel2")
        let cv = cell?.contentView
        let mycolor = UIColor(red: 0.765, green: 0.553, blue: 0.580, alpha: 1.0)

    //    var articles = articles[indexPath.row]
        var articles = articles[indexPath.row]


        let name = cv?.viewWithTag(21) as! UILabel
        let indice = cv?.viewWithTag(22) as! UILabel
        let imageView = cv?.viewWithTag(20)as! UIImageView

        let container = cv?.viewWithTag(6)
        imageView.layer.borderWidth = 1

        imageView.layer.masksToBounds = false

        imageView.layer.borderColor = mycolor.cgColor

        imageView.layer.cornerRadius = 20
        print(articles)
        imageView.clipsToBounds = true
        container?.addCornerRadius(radius: 12)
        container?.addShadow(color: UIColor.black.cgColor, opacity: 0.5, offset: CGSize(width: 3, height: 3), radius: 4)
        
        
        name.text = articles.title
        print(articles.urlToImage)
        if(articles.urlToImage==""){
            articles.urlToImage="https://media.istockphoto.com/vectors/breaking-news-isolated-vector-icon-sign-of-main-news-on-dark-world-vector-id1212012012?k=20&m=1212012012&s=612x612&w=0&h=RBUIgsYpO22XkNXTqqunalkcbpngnuCtZU7xSSgMk6c="
            ImageLoader.shared.loadImage(identifier: (articles.urlToImage)!, url: (articles.urlToImage)!) { imageResp in
                
                imageView.image = imageResp
            }
            
        }else{
            ImageLoader.shared.loadImage(identifier: (articles.urlToImage)!, url: (articles.urlToImage)!) { imageResp in
                
                imageView.image = imageResp
            }
        }
    
        
        indice.text = articles.description

        
        return cell!    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
  
        AnnonceController().recupererToutNews(completed: { [self] success, results in
            if success {
              //  articles = []
                self.articles.append(contentsOf: results!)
                self.tableView.reloadData()
                
                
            }
        }
    )}
    


}
