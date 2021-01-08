import Foundation

struct QuizQuestion {

  let left: Int
  let right: Int

  var result: Int {
    left * right
  }

  var questionText: String {
    "\(left) x \(right) ="
  }
}

extension QuizQuestion: Equatable {

  static func == (lhs: QuizQuestion, rhs: QuizQuestion) -> Bool {
    lhs.left == rhs.left && lhs.right == rhs.right
  }
}

protocol QuizGenerator {

  func generate() -> QuizQuestion
  func generate(previous: QuizQuestion) -> QuizQuestion
}

extension QuizGenerator {

  func generate(previous: QuizQuestion) -> QuizQuestion {
    var next = generate()
    while (next == previous) {
      next = generate()
    }

    return next
  }
}

struct SimpleQuizGenerator: QuizGenerator {

  func generate() -> QuizQuestion {
    QuizQuestion(
      left: Int.random(in: 1...Constants.maxNumber),
      right: Int.random(in: 1...Constants.maxNumber)
    )
  }
}

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
}

struct MultiplicationTableQuizGenerator: QuizGenerator {

  private let number: Int

  init(number: Int) {
    self.number = number
  }

  func generate() -> QuizQuestion {
    QuizQuestion(
      left: number,
      right: Int.random(in: 1...Constants.maxNumber)
    )
  }
}
