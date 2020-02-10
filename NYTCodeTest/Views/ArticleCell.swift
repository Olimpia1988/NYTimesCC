import UIKit

class ArticleCell: UITableViewCell {
  
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var articleImage: UIImageView!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  

  public func configureCell(NYTimesArticle: Articles, language: LanguageSelector) {
    let titleText = Articles.getTextForLanguage(NYTimesArticle.title,
                                                selectedLanguage: language)
    Utilities.setupTitleFont(title, titleText)
    imageSetUp(NYTimesArticle: NYTimesArticle)
  }
  
  public func imageSetUp(NYTimesArticle: Articles) {
    if let unwrapImage = NYTimesArticle.images {
      let filteredImage = unwrapImage.filter{$0.topImage}
      ImageHelper.shared.getImage(urlStr: (filteredImage.first!.url), completionHandler: { (result) in
        DispatchQueue.main.async {
          self.activityIndicator.isHidden = true
          switch result {
          case .failure(let error):
            
            print("Error loading the article image \(error)")
            self.activityIndicator.stopAnimating()
          case .success(let image):
            self.articleImage.image = image
          }
        }
      })
    }
    
  }
}

