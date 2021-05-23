import Foundation

protocol QuizGenerator {

  func generate() -> QuizQuestion
  func generate(previous: QuizQuestion) -> QuizQuestion
  func generateAll() -> [QuizQuestion]
}

extension QuizGenerator {

  public func generate(previous: QuizQuestion) -> QuizQuestion {
    var next = generate()
    while next == previous {
      next = generate()
    }

    return next
  }
}
