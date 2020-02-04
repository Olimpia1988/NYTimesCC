import UIKit

class ArticlesListViewController: UIViewController {
  
  var articles = [Articles]() {
    didSet {
      self.articlesTableView.reloadData()
    }
  }
  
  
  @IBOutlet weak var articlesTableView: UITableView!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegation()
        loadArticles()
      
      
    }
  
  private func loadArticles() {
    APIManager.getData { (result) in
      switch result {
      case .success(let data):
        self.articles = data
      case .failure(let error):
       print(error)
      }
    }
    
    
  }
  
  private func setupDelegation() {
    self.articlesTableView.delegate = self
    self.articlesTableView.dataSource = self
    
  }
  
    
}

extension ArticlesListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    articles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell else { return UITableViewCell() }
    let singleArticleData = articles[indexPath.row]
    cell.configureCell(NYTimesArticle: singleArticleData)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 300
  }
}

