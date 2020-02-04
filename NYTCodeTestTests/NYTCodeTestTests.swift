import XCTest
@testable import NYTCodeTest

class NYTCodeTestTests: XCTestCase {
  class TriviaAppTests: XCTestCase {
    func testGetQuestions() {
      
      // Arrange
      let articleSample = getSampleArticles()
      
      // Act
      
      let articles = Articles.getArticles(from: articleSample)
      
      //assert
      XCTAssertTrue(articles.count == 0)
    }
    
    func getSampleArticles() -> Data {
      guard let pathToData = Bundle.main.path(forResource: "articles", ofType: "json") else {
        fatalError("sampleQuestions.json not found")
      }
      let internalUrl = URL(fileURLWithPath: pathToData)
      do {
        let data = try Data(contentsOf: internalUrl)
        return data
      }
      catch {
        fatalError("An error occurred: \(error)")
      }
    }
    
    
  }
  
}
