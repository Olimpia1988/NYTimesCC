import UIKit

class SingleArticleViewController: UIViewController {
  
  //MARK: - Properties
  var selecteddArticle: Article!
  var selectedImage: UIImage?
  var currentLanguage: LanguageSelector!
  
  //MARK: - UIObjects
  @IBOutlet weak var articleTitle: UILabel!
  @IBOutlet weak var articleImage: UIImageView!
  @IBOutlet weak var articleBody: UITextView!
  
  
  //MARK: - Life Cycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUIObjects()
  }
  
  //MARK: - Private Properties
  private func setupUIObjects() {
    switch currentLanguage {
    case .english:
      UIUtilities.setupTitleText(articleTitle, selecteddArticle.title)
      UIUtilities.setupBodyText(articleBody, selecteddArticle.body)
      UIUtilities.setupImage(selectedImage, articleImage)
    case .martian:
      UIUtilities.setupTitleText(articleTitle, Article.getTextForLanguage(selecteddArticle.title,
      selectedLanguage: currentLanguage))
      UIUtilities.setupBodyText(articleBody, Article.getTextForLanguage(selecteddArticle.body, selectedLanguage: currentLanguage))
      UIUtilities.setupImage(selectedImage, articleImage)
    case .none:
      break
    }
 

  }
}


