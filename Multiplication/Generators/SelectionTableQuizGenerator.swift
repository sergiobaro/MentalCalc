import Foundation

public struct SelectionTableQuizGenerator: QuizGenerator {

  private let maxNumber: Int
  private let numbers: Set<Int>

  public init(maxNumber: Int, numbers: Set<Int>) {
    self.maxNumber = maxNumber
    self.numbers = numbers
  }

  public func generate() -> QuizQuestion {
    QuizQuestion(
      left: numbers.randomElement() ?? Int.random(in: 1...maxNumber),
      right: Int.random(in: 1...maxNumber)
    )
  }

  public func generateAll() -> [QuizQuestion] {
    var questions = [QuizQuestion]()

    for right in 1...maxNumber {
      for left in numbers {
        let question = QuizQuestion(left: left, right: right)
        questions.append(question)
      }
    }

    return questions
  }
}
