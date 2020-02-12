import UIKit

class ImageGetterManager {
    
    // MARK: - Static Properties
    static let manager = ImageGetterManager()
  
  // MARK: - Internal Properties
  static func getImage(urlStr: String, completionHandler: @escaping (Result<UIImage, AppError>) -> Void) {

        guard let url = URL(string: urlStr) else {
            completionHandler(.failure(.badURL))
            return
        }
      NetworkManager.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
        switch result {
        case .failure(let error):
          completionHandler(.failure(error))
          
        case .success(let imageData):
          guard let image = UIImage(data: imageData) else { return }
          completionHandler(.success(image))
        }
      }
      
    }
  // MARK: - Private Properties and Initializers
   private init() {}
}


