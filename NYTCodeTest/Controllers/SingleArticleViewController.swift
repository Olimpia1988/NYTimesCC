import UIKit

class SingleArticleViewController: UIViewController {
  
  var detailedArticle: Articles!
  var currentImage: UIImage?
  
  @IBOutlet weak var articleTitle: UILabel!
  
  @IBOutlet weak var articleImage: UIImageView!
  
  @IBOutlet weak var articleBody: UITextView!
  override func viewDidLoad() {
        super.viewDidLoad()
        setupUIObjects()


    }
  
  private func setupUIObjects() {
    Utilities.setupTitleFont(articleTitle, detailedArticle.title)
    Utilities.setupBodyTextFont(articleBody, detailedArticle.body)
    Utilities.setupImage(currentImage, articleImage)
  }
    

   
}
