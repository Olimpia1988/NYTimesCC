//
//import UIKit
//
//final class ImageCache {
//  private init() {}
//  
//  static let shared = ImageCache()
//  
//  private static var cache = NSCache<NSString, UIImage>()
//  
//  static func fetchImageFromNetwork(urlString: String, completionHandler: @escaping (Result<UIImage, AppError>) -> Void) {
//    
//    guard let url = URL(string: urlString) else {
//              completionHandler(.failure(.badURL))
//              return
//          }
//    
//    NetworkManager.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
//      switch result {
//      case .failure(let error):
//        DispatchQueue.main.async {
//          completionHandler(.failure(error))
//        
//        }
//      case .success(let imageData):
//        DispatchQueue.main.async {
//          if let image = UIImage(data: imageData) {
//            ImageCache.cache.setObject(image, forKey: urlString as NSString)
//            completionHandler(.success(image))
//          }
//        }
//      }
//    }
//  }
//  
//  public func fetchImageFromCache(urlString: String) -> UIImage? {
//    return ImageCache.cache.object(forKey: urlString as NSString)
//  }
//  
// 
//  
//  static func getImageFromCatch(with url: URL, completionHandler: @escaping (_ image: UIImage?) -> ()) {
//    if let image = cache.object(forKey: url.absoluteString as NSString) {
//      completionHandler(image)
//    } else {
//      guard let url = String(url) else {
//        
//      }
//      fetchImageFromNetwork(urlString: url, completionHandler: completionHandler)
//    }
//  }
//}
