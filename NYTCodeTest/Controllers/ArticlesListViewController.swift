import UIKit

class ArticlesListViewController: UIViewController {
  
  //MARK: - Setters
  var articles = [Article]() {
    didSet {
      self.articlesTableView.reloadData()
      
    }
  }
  
  public var currentLanguage = LanguageSelector.english {
    didSet {
      self.articlesTableView.reloadData()
    }
  }
  
  
  //MARK: - UIObjects
  @IBOutlet weak var articlesTableView: UITableView!
  @IBOutlet weak var toggleButton: UIBarButtonItem!
  
  //MARK: - Private Properties
  var isMartian = false
  let userDefaults = UserDefaults.standard
  
  
  //MARK: - Life Cycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupDelegation()
    loadArticles()
//    self.articlesTableView.estimatedRowHeight = 500
//    self.articlesTableView.rowHeight = UITableView.automaticDimension
  }
  
  override func viewWillAppear(_ animated: Bool) {
    self.articlesTableView.reloadData()
  }
  
  //MARK: - IBActions
  @IBAction func toggleButton(_ sender: Any) {
    switch currentLanguage {
    case .english:
      self.currentLanguage = currentLanguage.swapLanguages()
      self.toggleButton.title = "English"

    case .martian:
      self.currentLanguage = currentLanguage.swapLanguages()
      self.toggleButton.title = "Martian"

    }
    
  }
  
  
  //MARK: - Segue
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    guard let indexPath = articlesTableView.indexPathForSelectedRow,
      let detailViewController = segue.destination as? SingleArticleViewController else {
        fatalError("indexPath, detailVC nil")
    }
    let singleArticle = articles[indexPath.row]
    guard let cell = articlesTableView.cellForRow(at: indexPath) as? ArticleCell else { return }
    detailViewController.selectedImage = cell.articleImage.image
    detailViewController.selecteddArticle = singleArticle
    detailViewController.currentLanguage = currentLanguage
  }
  
 
  //MARK: - Private functions
  private func loadArticles() {
    ArticlesAPIManager.getData { (result) in
      switch result {
      case .success(let data):
        self.articles = data
      case .failure(let error):
        print("Error loading data: \(error)")
      }
    }
  }
  
  private func setupDelegation() {
    self.articlesTableView.delegate = self
    self.articlesTableView.dataSource = self
  }
  
  private func persistLanguage() {
    UserDefaults.standard.set(currentLanguage, forKey: "lastSelectedLanguage")

}
  
  private func readData() {
    if let loadedInfo: LanguageSelector = UserDefaults.standard.value(forKey: "lastSelectedLanguage") as? LanguageSelector {
      currentLanguage = loadedInfo
      self.articlesTableView.reloadData()
    }
  }

}

//MARK: - ViewController Extention
extension ArticlesListViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    articles.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell else { return UITableViewCell() }
    let singleArticle = articles[indexPath.row]
    cell.configureCell(singleArticle, currentLanguage)
    return cell
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    500
  }
  
  private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
      return UITableView.automaticDimension
  }
  

}

