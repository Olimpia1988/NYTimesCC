import UIKit

class SingleArticleViewController: UIViewController {
  
  //MARK: - Properties
  var selecteddArticle: Articles!
  var selectedImage: UIImage?
  var currentLanguage: LanguageSelector!
  
  //MARK: - UIObjects
  @IBOutlet weak var articleTitle: UILabel!
  @IBOutlet weak var articleImage: UIImageView!
  @IBOutlet weak var articleBody: UITextView!
  
  @IBOutlet weak var scrollView: UIScrollView!
  
  //MARK: - Life Cycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUIObjects()
  }
  
  //MARK: - Private Properties
  private func setupUIObjects() {
    switch currentLanguage {
    case .English:
      UIUtilities.setupTitleText(articleTitle, selecteddArticle.title)
      UIUtilities.setupBodyText(articleBody, selecteddArticle.body)
      UIUtilities.setupImage(selectedImage, articleImage)
    case .Martian:
      UIUtilities.setupTitleText(articleTitle, Articles.getTextForLanguage(selecteddArticle.title,
      selectedLanguage: currentLanguage))
      UIUtilities.setupBodyText(articleBody, Articles.getTextForLanguage(selecteddArticle.body, selectedLanguage: currentLanguage))
      UIUtilities.setupImage(selectedImage, articleImage)
    case .none:
      break
    }
    articleBody.frame = CGRect(x: 20, y: 20, width: self.scrollView.frame.size.width - 40, height: self.scrollView.frame.size.width - 40);

  }
}


