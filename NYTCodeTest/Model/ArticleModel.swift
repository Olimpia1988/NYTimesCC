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
    case .english: return text
    case .martian:
      let paragrapheSparator = text.components(separatedBy: "\n")
      var cleanArray = [String]()
      
      let puntuations = CharacterSet.punctuationCharacters
      let onlyLetter = CharacterSet.letters
      
      for paragraph in paragrapheSparator {
        
        var word = paragraph.components(separatedBy: " ")
        for index in 0..<word.count {
          let currentWord = word[index]
          
          
          guard let lastChar = currentWord.last else { break }
          guard let firstChar = currentWord.first else { break }
          
          let endIndex = currentWord.endIndex
          let startIndex = currentWord.startIndex
          let endOfDomain = currentWord.index(endIndex, offsetBy: -1)
          let rangeOfDomain = currentWord.startIndex ..< endOfDomain
          
          let wordLastCharPunct = String(currentWord[rangeOfDomain])
          
          if firstChar.isPunctuation && lastChar.isPunctuation {
            
            let startingIndex = currentWord.index(currentWord.startIndex, offsetBy: 1)
            let lastIndex = currentWord.index(currentWord.endIndex, offsetBy: -1)
            let finalRange = startingIndex ..< lastIndex
            let wordWithPuctFirst = String(currentWord[finalRange])
            
            if wordWithPuctFirst.count > 3 && wordWithPuctFirst.rangeOfCharacter(from: puntuations) == nil && wordWithPuctFirst.rangeOfCharacter(from: onlyLetter) != nil {
              
              if wordWithPuctFirst.first!.isUppercase {
                word[index] = String(firstChar) + MartianWord.upperCase.rawValue + String(lastChar)
              } else {
                word[index] = String(firstChar) + MartianWord.lowerCase.rawValue + String(lastChar)
                
              }
              
            }
            
          } else if lastChar.isPunctuation {
            if wordLastCharPunct.count > 3 {
              if wordLastCharPunct.first!.isUppercase {
                word[index] = MartianWord.upperCase.rawValue + String(lastChar)
              } else {
                word[index] = MartianWord.lowerCase.rawValue + String(lastChar)
              }
            }
          } else if firstChar.isPunctuation && lastChar.isPunctuation == false {
            
            let startOfDomain = currentWord.index(startIndex, offsetBy: 1)
            let rangeOfWords = startOfDomain ..< currentWord.endIndex
            let cleanWord = String(currentWord[rangeOfWords])
            
            if cleanWord.count > 3  && cleanWord.rangeOfCharacter(from: onlyLetter) != nil{
              if cleanWord.first!.isUppercase {
                word[index] = String(firstChar) + MartianWord.upperCase.rawValue
              } else {
                word[index] = String(firstChar) + MartianWord.lowerCase.rawValue
              }
            }
          } else if currentWord.count > 3 && currentWord.rangeOfCharacter(from: puntuations) == nil && currentWord.rangeOfCharacter(from: onlyLetter) != nil {
            
            if currentWord.first!.isUppercase {
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

