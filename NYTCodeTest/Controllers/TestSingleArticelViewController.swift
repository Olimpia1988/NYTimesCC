import UIKit

class TestSingleArticelViewController: UIViewController {
  
  //MARK: - Internal Properties
  var selectedArticle: Articles!
  var currentLanguageTest: LanguageSelector!
  var currentImage: UIImage!
  
  
  //MARK: - UIObjects
  @IBOutlet weak var singleArticleTableView: UITableView!
  override func viewDidLoad() {
    super.viewDidLoad()
    setupDelegation()
  }
  
  //MARK: - Private Methods
  func setupDelegation() {
    singleArticleTableView.delegate = self
    singleArticleTableView.dataSource = self
  }
  
}

extension TestSingleArticelViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "SingleArticle", for: indexPath) as? SingleArticleCell else { return UITableViewCell() }
    if let unwrapedImage = currentImage {
      cell.configureCell(selectedArticle, currentLanguageTest, unwrapedImage)
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 700
  }
  
  
}
