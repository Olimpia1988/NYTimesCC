import UIKit

protocol ArticleCellDelegate: class {
  func imageDataLoaded(with index: IndexPath)
}

class ArticleCell: UITableViewCell {
  
  var delegate: ArticleCellDelegate?
  
  //MARK: - UIObjects
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var articleImage: UIImageView!
  @IBOutlet weak var paragraph: UITextView!
  
  
  // MARK: - Internal Properties
  public func configureCell(_ NYTimesArticle: Article,
                            _ language: LanguageSelector, _ indexPath: IndexPath, completionHandler: @escaping()-> Void) {
    let titleText = Article.getTextForLanguage(NYTimesArticle.title, selectedLanguage: language)
    let oneParagraph = NYTimesArticle.body.components(separatedBy: "\n")
    let paragraphBody = Article.getTextForLanguage(oneParagraph[0], selectedLanguage: language)
    imageSetUp(NYTimesArticle) { [weak self] in
      self?.delegate?.imageDataLoaded(with: indexPath)
    }
    UIUtilities.setupTitleText(title, titleText)
    UIUtilities.setupArticleSumary(paragraph, "• \(paragraphBody)")
    
    
  }
  
  
  public func imageSetUp( _ NYTimesArticle: Article, completionHandler: @escaping()-> Void) {
    if let unwrapImage = NYTimesArticle.images {
      let filteredImage = unwrapImage.filter{$0.topImage}
      
      if let image = ImageGetterManager.getImageFromCache(with: filteredImage.first!.url) {
        self.articleImage.image = image
      } else {
        ImageGetterManager.getImage(urlStr: filteredImage.first!.url) { (result) in
          switch result {
          case .failure:
            print(AppError.notAnImage)
          case .success(let imageData):
            self.articleImage.image = imageData
            completionHandler()
          }
        }
      }
    }
  }
}



