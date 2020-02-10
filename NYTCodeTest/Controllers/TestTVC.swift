import UIKit


class TestTVC: UITableViewController {

  var articles = [Articles]() {
       didSet {
         self.articlesTableView.reloadData()
       }
     }
  
  var currentLanguage: LanguageSelector? {
       didSet {
         if let language = currentLanguage {
           switch language {
           case .Martian: currentLanguage = .Martian
           case .English: currentLanguage = .English
           }
         }
       }
     }
     
     //MARK: UIObjects
     @IBOutlet weak var articlesTableView: UITableView!

     //MARK: Life Cycle Methods
     override func viewDidLoad() {
       super.viewDidLoad()
       setupDelegation()
       loadArticles()
     }
     
     
     @IBAction func toggleButton(_ sender: Any) {
     
         }
  
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       guard let indexPath = articlesTableView.indexPathForSelectedRow,
         let detailViewController = segue.destination as? SingleArticleViewController else {
           fatalError("indexPath, detailVC nil")
       }
       let singleArticle = articles[indexPath.row]
       guard let cell = articlesTableView.cellForRow(at: indexPath) as? ArticleCell else { return }
       detailViewController.currentImage = cell.articleImage.image
       detailViewController.detailedArticle = singleArticle
     }
     
     //MARK: Private functions
     private func loadArticles() {
       APIManager.getData { (result) in
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
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     articles.count
   }
   
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
     guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell", for: indexPath) as? ArticleCell else { return UITableViewCell() }
     let singleArticleData = articles[indexPath.row]
     cell.configureCell(NYTimesArticle: singleArticleData)
     return cell
   }
   
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    
    return 250
     
   }
}
