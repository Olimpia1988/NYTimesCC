

import UIKit

class SingleArticleCell: UITableViewCell {
//MARK: - UIObjects
  @IBOutlet weak var title: UILabel!
  @IBOutlet weak var selectedImageTest: UIImageView!
  @IBOutlet weak var textField: UITextView!
  
  
  //MARK: - Internal Properties
  func configureCell(NYTimesArticle: Articles, currentLanguage: LanguageSelector) {
    switch currentLanguage {
    case .English:
      UIUtilities.setupTitleText(title, NYTimesArticle.title)
      UIUtilities.setupBodyText(textField, NYTimesArticle.body)
      //setup image
    case .Martian:
      UIUtilities.setupTitleText(title, Articles.getTextForLanguage(NYTimesArticle.title,
      selectedLanguage: currentLanguage))
      UIUtilities.setupBodyText(textField, Articles.getTextForLanguage(NYTimesArticle.body, selectedLanguage: currentLanguage))
      
      
      
    }
  }
  
}
