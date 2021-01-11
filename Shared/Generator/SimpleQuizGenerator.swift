import Foundation

struct SimpleQuizGenerator: QuizGenerator {

  func generate() -> QuizQuestion {
    QuizQuestion(
      left: Int.random(in: 1...Constants.maxNumber),
      right: Int.random(in: 1...Constants.maxNumber)
    )
  }

  func generateAll() -> [QuizQuestion] {
    var questions = [QuizQuestion]()
    
    for left in 1...Constants.maxNumber {
      for right in 1...Constants.maxNumber {
        let question = QuizQuestion(left: left, right: right)
        questions.append(question)
      }
    }

    return questions
  }
}
