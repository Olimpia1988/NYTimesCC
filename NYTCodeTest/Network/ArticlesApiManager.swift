import Foundation

final class APIManager {
   
    private init() {}
    static let manager = APIManager()
    
 static func getData(completionHandler: @escaping(Result<[Articles], AppError>) -> ()) {
        
        let stringUrl = "https://s1.nyt.com/ios-newsreader/candidates/test/articles.json"
        
        guard let url = URL(string: stringUrl) else {
            completionHandler(.failure(.badURL))
            return
        }
        
        NetworkHelper.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
            switch result {
                
            case .failure(let error):
                completionHandler(.failure(error))
            case .success(let data):
              let articles = Articles.getArticles(from: data)
              completionHandler(.success(articles))
          }
        }
    }
}



