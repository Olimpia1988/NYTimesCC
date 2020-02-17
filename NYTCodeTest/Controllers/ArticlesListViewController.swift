import UIKit

class ArticlesListViewController: UIViewController {
  
  //MARK: - Setters
  var articles = [Article]() {
    didSet {
      self.articlesTableView.reloadData()
    }
  }
  
  public var currentLanguage: LanguageSelector = Keys.languagePersistenceGet() ?? .english  {
    didSet {
      self.articlesTableView.reloadData()
      
    }
  }
  
  
  //MARK: - UIObjects
  @IBOutlet weak var articlesTableView: UITableView!
  @IBOutlet weak var toggleButton: UIBarButtonItem!
  let userDefaults = UserDefaults.standard
  
  
  
  //MARK: - Life Cycle Methods
  override func viewDidLoad() {
    super.viewDidLoad()
    setupDelegation()
    checkForLanguage()
    loadArticles()
    
 
    
    
    }
  
  

  //MARK: - IBActions
  @IBAction func toggleButton(_ sender: Any) {
    languageGetter()
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
  
  private func languageGetter() {
    switch currentLanguage {
    case .english:
      self.toggleButton.title = "English"
      self.currentLanguage = currentLanguage.swapLanguages()
      Keys.languagePersistenceSave(currentLanguge: currentLanguage)
      
    case .martian:
      self.toggleButton.title = "Martian"
      self.currentLanguage = currentLanguage.swapLanguages()
      Keys.languagePersistenceSave(currentLanguge: currentLanguage)
    }
  }
  
  private func setupDelegation() {
    self.articlesTableView.delegate = self
    self.articlesTableView.dataSource = self
  }
  
  private func checkForLanguage() {
    if let selectedLanguage = Keys.languagePersistenceGet() {
      self.currentLanguage = selectedLanguage
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

    cell.configureCell(singleArticle, currentLanguage){  }
    return cell
  }
  
  func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
    UITableView.automaticDimension
  }
  
  private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
  
     
  }
}

