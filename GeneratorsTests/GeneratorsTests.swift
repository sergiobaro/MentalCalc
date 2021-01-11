import XCTest
@testable import Generators

class GeneratorsTests: XCTestCase {

  func test() {
    let generator = SelectionTableQuizGenerator(maxNumber: 12, numbers: Set<Int>(arrayLiteral: 5, 6))
    let questions = generator.generateAll()

    XCTAssertEqual(questions.count, 24)

    var idsSet = Set<Int>()
    questions.forEach { idsSet.insert($0.id) }
    XCTAssertEqual(idsSet.count, 24)
  }

}
