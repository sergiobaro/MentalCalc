import Foundation

struct SelectionTableQuizGenerator: QuizGenerator {

  private let numbers: Set<Int>

  init(numbers: Set<Int>) {
    self.numbers = numbers
  }

  func generate() -> QuizQuestion {
    QuizQuestion(
      left: numbers.randomElement() ?? Int.random(in: 1...Constants.maxNumber),
      right: Int.random(in: 1...Constants.maxNumber)
    )
  }

  func generateAll() -> [QuizQuestion] {
    var questions = [QuizQuestion]()

    for left in numbers {
      for right in 1...Constants.maxNumber {
        let question = QuizQuestion(left: left, right: right)
        questions.append(question)
      }
    }

    return questions
  }
}
