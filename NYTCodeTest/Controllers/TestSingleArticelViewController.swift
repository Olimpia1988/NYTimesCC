
import UIKit

class TestSingleArticelViewController: UIViewController {
  
  //MARK: - Internal Properties
  var selectedArticle: Articles!
  var currentLanguageTest: LanguageSelector!


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
    cell.configureCell(NYTimesArticle: selectedArticle, currentLanguage: currentLanguageTest)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 700
  }
  
  
}
