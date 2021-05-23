import XCTest
import Nimble
@testable import Multiplication

class MemoryStorageTests: XCTestCase {

  var storage: MemoryStorage!
  
  override func setUpWithError() throws {
    self.storage = MemoryStorage()
  }

  func test_saveAndRetrieve() {
    let question1 = QuizQuestion(left: 1, right: 1)
    storage.save(question: question1, correct: false)

    let record1 = storage.retrieve(question: question1)
    expect(record1?.correct).to(equal(0))
    expect(record1?.errors).to(equal(1))

    let question2 = QuizQuestion(left: 2, right: 2)
    storage.save(question: question2, correct: true)

    let record2 = storage.retrieve(question: question2)
    expect(record2?.correct).to(equal(1))
    expect(record2?.errors).to(equal(0))
  }
}
