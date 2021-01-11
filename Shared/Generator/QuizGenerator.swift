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

extension QuizQuestion: Identifiable {
  var id: Int {
    result
  }
}

protocol QuizGenerator {

  func generate() -> QuizQuestion
  func generate(previous: QuizQuestion) -> QuizQuestion
  func generateAll() -> [QuizQuestion]
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
