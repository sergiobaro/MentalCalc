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

  var text: String {
    "\(questionText) \(result)"
  }

  init(left: Int, right: Int) {
    self.left = left
    self.right = right
  }
}

extension QuizQuestion: Equatable {

  static func == (lhs: QuizQuestion, rhs: QuizQuestion) -> Bool {
    lhs.left == rhs.left && lhs.right == rhs.right
  }
}

extension QuizQuestion: Identifiable {
  
  var id: Int {
    Int("\(left)\(right)\(result)")!
  }
}

extension QuizQuestion: Hashable {}
