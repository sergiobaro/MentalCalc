import Foundation

typealias QuestionRecord = (correct: Int, errors: Int)

protocol Storage {

  func save(question: QuizQuestion, correct: Bool)
  func retrieve(question: QuizQuestion) -> QuestionRecord?
  func retrieveAll() -> [QuizQuestion: QuestionRecord]
}
