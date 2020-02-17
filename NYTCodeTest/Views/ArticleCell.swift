import UIKit

class ArticleCell: UITableViewCell {
  
  //MARK: - UIObjects
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var articleImage: UIImageView!
  @IBOutlet weak var paragraph: UITextView!
  
  
  // MARK: - Internal Properties
  public func configureCell(_ NYTimesArticle: Article,
                            _ language: LanguageSelector) {
    let titleText = Article.getTextForLanguage(NYTimesArticle.title,
                                                selectedLanguage: language)
    UIUtilities.setupTitleText(title, titleText)
    imageSetUp(NYTimesArticle)
  
    let oneParagraph = NYTimesArticle.body.components(separatedBy: "\n")
    let paragraphBody = Article.getTextForLanguage(oneParagraph[0], selectedLanguage: language)

    UIUtilities.setupArticleSumary(paragraph, "• \(paragraphBody)")
  }
  
  func imageSetUp( _ NYTimesArticle: Article) {
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

