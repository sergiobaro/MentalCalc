import Foundation

public struct SimpleQuizGenerator: QuizGenerator {

  private let maxNumber: Int

  public init(maxNumber: Int) {
    self.maxNumber = maxNumber
  }

  func generate() -> QuizQuestion {
    QuizQuestion(
      left: Int.random(in: 1...maxNumber),
      right: Int.random(in: 1...maxNumber)
    )
  }

  func generateAll() -> [QuizQuestion] {
    var questions = [QuizQuestion]()
    
    for left in 1...maxNumber {
      for right in 1...maxNumber {
        let question = QuizQuestion(left: left, right: right)
        questions.append(question)
      }
    }

    return questions
  }
}
