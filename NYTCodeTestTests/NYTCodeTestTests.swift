import XCTest
@testable import NYTCodeTest

class NYTCodeTestTests: XCTestCase {
 
  func testWordTranslation() {
    // arrange
    let sutWord = "article" // sut - system under test
    
    // act
    let article = Article.getTextForLanguage(sutWord, selectedLanguage: .martian)
    
    // assert
    XCTAssertEqual(article, MartianWord.lowerCase.rawValue)
  }
  
  
  var articleJSONData = Data()
  
  override func setUp() {
    guard let jsonPath = Bundle.main.path(forResource: "articles", ofType: "json") else {
      XCTFail("Could not find JSON file")
      return
      
    }
    let jsonURL = URL(fileURLWithPath: jsonPath)
    do {
      articleJSONData = try Data(contentsOf: jsonURL)
    }  catch  {
      XCTFail("\(error)")
    }
  }
  
  func testModelDecoding() {
    var articles = [Article]()
      do {
        let articleInfo = try Article.getArticles(from: articleJSONData)
        articles = articleInfo
      } catch {
        XCTFail("\(error)")
      }
    
    //Assert
    XCTAssert(articles.count == 3, "Was expecting 3 articles, found instead \(articles.count)")
    }
    
 
  
  func testNetwork() {
   
        guard let url = URL(string: "https://s1.nyt.com/ios-newsreader/candidates/test/articles.json") else {
            fatalError("URL can't be empty")
        }
    NetworkManager.manager.performDataTask(withUrl: url, andMethod: .get) { (result) in
      
      
    }

        }
    }
  
  
  
  

