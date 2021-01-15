import Foundation

public struct QuizQuestion {

  let left: Int
  let right: Int

  public var result: Int {
    left * right
  }

  public var questionText: String {
    "\(left) x \(right) ="
  }

  public init(left: Int, right: Int) {
    self.left = left
    self.right = right
  }
}

extension QuizQuestion: Equatable {

  public static func == (lhs: QuizQuestion, rhs: QuizQuestion) -> Bool {
    lhs.left == rhs.left && lhs.right == rhs.right
  }
}

extension QuizQuestion: Identifiable {

  public var id: Int {
    Int("\(left)\(right)\(result)")!
  }
}

public protocol QuizGenerator {

  func generate() -> QuizQuestion
  func generate(previous: QuizQuestion) -> QuizQuestion
  func generateAll() -> [QuizQuestion]
}

extension QuizGenerator {

  public func generate(previous: QuizQuestion) -> QuizQuestion {
    var next = generate()
    while (next == previous) {
      next = generate()
    }

    return next
  }
}
