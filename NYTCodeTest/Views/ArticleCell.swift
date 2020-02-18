import UIKit

protocol ArticleCellDelegate: class {
  func imageDataLoaded()
}

class ArticleCell: UITableViewCell {
  
  var delegate: ArticleCellDelegate?
  
  //MARK: - UIObjects
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var articleImage: UIImageView!
  @IBOutlet weak var paragraph: UITextView!
  
  
  // MARK: - Internal Properties
  public func configureCell(_ NYTimesArticle: Article,
                            _ language: LanguageSelector, completionHandler: @escaping()-> Void) {
    let titleText = Article.getTextForLanguage(NYTimesArticle.title, selectedLanguage: language)
    let oneParagraph = NYTimesArticle.body.components(separatedBy: "\n")
    let paragraphBody = Article.getTextForLanguage(oneParagraph[0], selectedLanguage: language)
    
    UIUtilities.setupTitleText(title, titleText)
    UIUtilities.setupArticleSumary(paragraph, "• \(paragraphBody)")
    
    imageSetUp(NYTimesArticle) { [weak self] in
      self?.delegate?.imageDataLoaded()
    }
  }
  
  
  public func imageSetUp( _ NYTimesArticle: Article, completionHandler: @escaping()-> Void) {
    if let unwrapImage = NYTimesArticle.images {
      let filteredImage = unwrapImage.filter{$0.topImage}
      ImageGetterManager.getImage(urlStr: filteredImage.first!.url) { (result) in
        switch result {
        case .failure:
          print("\(AppError.notAnImage)")
        case .success(let imageData):
          self.articleImage.image = imageData
          completionHandler()
          
        }
      }
    }
  }
}

