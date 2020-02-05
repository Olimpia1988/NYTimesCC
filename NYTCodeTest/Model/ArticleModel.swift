import Foundation

struct Articles: Codable {
  var title: String
  var images: [ArticleImages]?
  var body: String
  
  
  static func getArticles(from jsonData: Data) -> [Articles] {
    do {
      let articles = try JSONDecoder().decode([Articles].self, from: jsonData)
      return articles
    } catch {
      dump(error)
      return []
      
    }
  }
}

struct ArticleImages: Codable {
  var topImage: Bool
  var url: String
  var width: Int
  var height: Int
  
  private enum CodingKeys : String, CodingKey {
         case topImage = "top_image"
         case url, width, height
     }
}

