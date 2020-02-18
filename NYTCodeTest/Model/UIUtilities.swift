import UIKit

struct UIUtilities {
  
  static func setupTitleText(_ articleTitle: UILabel, _ text: String) {
    articleTitle.font = UIFont(name: "Georgia-Bold", size: 21)
    articleTitle.text = text
    articleTitle.numberOfLines = 0
    articleTitle.textAlignment = .left
  }
  
  static func setupBodyText(_ articleBody: UITextView, _ text: String) {
    articleBody.font = UIFont(name: "Georgia", size: 16)
    articleBody.text = text
    articleBody.textColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
  }
  
  static func setupArticleSumary(_ articleSumary: UITextView, _ text: String) {
   setupBodyText(articleSumary, text)
       articleSumary.translatesAutoresizingMaskIntoConstraints = true
       articleSumary.sizeToFit()
       articleSumary.isScrollEnabled = false
    
  }
  
  static func setupImage(_ articleImage: UIImage?,_ articleImageView: UIImageView) {
    if let currentImage = articleImage {
      articleImageView.image = currentImage
    }
   
  }
  
  
}
