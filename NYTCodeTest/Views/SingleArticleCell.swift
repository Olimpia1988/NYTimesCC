

import UIKit

class SingleArticleCell: UITableViewCell {
//MARK: - UIObjects
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var selectedImageTest: UIImageView!
  @IBOutlet weak var textField: UITextView!
  
  
  //MARK: - Internal Properties
  func configureCell(_ NYTimesArticle: Articles, _ currentLanguage: LanguageSelector, _ currentImage: UIImage) {
    switch currentLanguage {
    case .English:
      UIUtilities.setupTitleText(title, NYTimesArticle.title)
      UIUtilities.setupBodyText(textField, NYTimesArticle.body)
      UIUtilities.setupImage(currentImage, selectedImageTest)
    case .Martian:
      UIUtilities.setupTitleText(title, Articles.getTextForLanguage(NYTimesArticle.title,
      selectedLanguage: currentLanguage))
      UIUtilities.setupBodyText(textField, Articles.getTextForLanguage(NYTimesArticle.body, selectedLanguage: currentLanguage))
      UIUtilities.setupImage(currentImage, selectedImageTest)
      
      
      
    }
  }
  
}
