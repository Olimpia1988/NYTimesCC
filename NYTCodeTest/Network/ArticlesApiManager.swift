import Foundation

final class ArticlesAPIManager {
  
  // MARK: - Static Properties
  static let manager = ArticlesAPIManager()
  
  // MARK: - Internal Properties
  static func getData(completionHandler: @escaping(Result<[Article], AppError>) -> ()) {
    
    let stringUrl = "https://s1.nyt.com/ios-newsreader/candidates/test/articles.json"
    
    guard let url = URL(string: stringUrl) else {
      completionHandler(.failure(.badURL))
      return
    }
    
    NetworkManager.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
      switch result {
      case .failure(let error):
        completionHandler(.failure(error))
      case .success(let data):
        let articles = Article.getArticles(from: data)
        completionHandler(.success(articles))
      }
    }
  }
  // MARK: - Private Properties and Initializers
  private init() {}
}



