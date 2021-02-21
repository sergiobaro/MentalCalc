import XCTest
@testable import Multiplication

class GeneratorsTests: XCTestCase {

  func test_idsAreUnique() {
    let generator = SelectionTableQuizGenerator(maxNumber: 12, numbers: Set<Int>(arrayLiteral: 5, 6))
    let questions = generator.generateAll()

    XCTAssertEqual(questions.count, 24)

    let ids = questions.reduce(into: Set<Int>()) { $0.insert($1.id) }
    XCTAssertEqual(ids.count, 24)
  }

  func test_randomNumbersOnTheLeft() {
    let generator = SelectionTableQuizGenerator(maxNumber: 12, numbers: Set<Int>(arrayLiteral: 11))
    let questions = generator.generateAll()

    XCTAssertEqual(questions.count, 12)

    questions.forEach {
      XCTAssertEqual($0.right, 11)
    }
  }
}
