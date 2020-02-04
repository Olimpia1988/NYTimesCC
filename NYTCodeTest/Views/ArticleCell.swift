
import UIKit

class ArticleCell: UITableViewCell {
  
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var articleImage
  : UIImageView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  public func configureCell(NYTimesArticle: Articles) {
    title.text = NYTimesArticle.title
    
    if let unwrapImage = NYTimesArticle.images {
      ImageHelper.shared.getImage(urlStr: (unwrapImage.first!.url), completionHandler: { (result) in
        DispatchQueue.main.async {
          self.activityIndicator.startAnimating()
          switch result {
          case .failure(let error):
            print(error)
            self.activityIndicator.stopAnimating()
          case .success(let image):
            self.activityIndicator.stopAnimating()
            self.articleImage.image = image
            
            
          }
        }
        
        
      })
    }
    
    
    
  }
  
  
}
