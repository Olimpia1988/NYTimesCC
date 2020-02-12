import UIKit

struct UIUtilities {
  

  static func setupTitleText(_ articleTitle: UILabel, _ text: String) {
    articleTitle.font = UIFont(name: "Georgia-Bold", size: 18)
    articleTitle.text = text
    articleTitle.numberOfLines = 0
    articleTitle.textAlignment = .left
  }
  

  static func setupBodyText(_ articleBody: UITextView, _ text: String) {
    articleBody.font = UIFont(name: "Georgia", size: 16)
    articleBody.text = text
    
  }
  
  static func setupImage(_ articleImage: UIImage?,_ articleImageView: UIImageView) {
    if let currentImage = articleImage {
      articleImageView.image = currentImage
    }
   
  }
  
  
}
