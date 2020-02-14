import Foundation

public enum MartianWord: String {
  case upperCase = "Boinga"
  case lowerCase = "boinga"
}

public enum LanguageSelector: String {
 
  case english = "English"
  case martian = "Martian"

  
  func swapLanguages() -> LanguageSelector {
switch(self) {
    case .english:
return .martian
    case .martian:
      return .english

    
    }
  }
}

struct Article: Codable {
  var title: String
  var images: [ArticleImages]?
  var body: String
  
  
  static func getArticles(from jsonData: Data) -> [Article] {
    do {
      let articles = try JSONDecoder().decode([Article].self, from: jsonData)
      return articles
    } catch {
      dump(error)
      return []
      
    }
  }
  
  static func getTextForLanguage(_ text: String, selectedLanguage: LanguageSelector) -> String {
   
    switch selectedLanguage {
    case .english:
  
      return text
    case .martian:
   
      
      let paragrapheSparator = text.components(separatedBy: "\n")
      var cleanArray = [String]()
      for paragraph in paragrapheSparator {
        
        var word = paragraph.components(separatedBy: " ")
        
        for index in 0..<word.count {
          if word[index].count > 3 {
            if word[index].first!.isUppercase {
              word[index] = MartianWord.upperCase.rawValue
              
            } else {
              word[index] = MartianWord.lowerCase.rawValue
              
            }
            
          }
          
        }
        
        let wordArray =  word.joined(separator: " ")
        cleanArray.append(wordArray)
      }
      return cleanArray.joined(separator: "\n")
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

