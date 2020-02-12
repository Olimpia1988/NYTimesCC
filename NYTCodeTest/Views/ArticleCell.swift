import UIKit

class ArticleCell: UITableViewCell {
  
  //MARK: - UIObjects
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var articleImage: UIImageView!
  
  
  // MARK: - Internal Properties
  public func configureCell(NYTimesArticle: Articles,
                            language: LanguageSelector) {
    let titleText = Articles.getTextForLanguage(NYTimesArticle.title,
                                                selectedLanguage: language)
    UIUtilities.setupTitleText(title, titleText)
    imageSetUp(NYTimesArticle: NYTimesArticle)
  }
  
  func imageSetUp(NYTimesArticle: Articles) {
    if let unwrapImage = NYTimesArticle.images {
      let filteredImage = unwrapImage.filter{$0.topImage}
      ImageGetterManager.getImage(urlStr: filteredImage.first!.url) { (result) in
        switch result {
        case .failure:
          print("\(AppError.notAnImage)")
        case .success(let imageData):
          self.articleImage.image = imageData
          
        }
      }
    }
  }
}

