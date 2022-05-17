

import Foundation

struct Articles {
    
    internal init(title: String?, description: String?, urlToImage: String?) {
        self.title = title
        self.description = description
        self.urlToImage = urlToImage
    }
    
    
    var title : String?
    var description : String?
    var urlToImage : String?
    

}
