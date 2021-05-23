import Foundation

class RandomStorage: Storage {

  private var records: [QuizQuestion: QuestionRecord] = [:]

  init() {
    self.records = generate()
  }

  func save(question: QuizQuestion, correct: Bool) {
    let record = records[question] ?? (0, 0)
    records[question] = update(record: record, correct: correct)
  }

  func retrieve(question: QuizQuestion) -> QuestionRecord? {
    records[question]
  }

  func retrieveAll() -> [QuizQuestion: QuestionRecord] {
    records
  }

  private func update(record: QuestionRecord, correct: Bool) -> QuestionRecord {
    if correct {
      return (record.correct + 1, record.errors)
    }
    return (record.correct, record.errors + 1)
  }

  private func generate() -> [QuizQuestion: QuestionRecord] {
    let generator = SimpleQuizGenerator(maxNumber: Constants.maxNumber)
    let questions = generator.generateAll()

    return questions.reduce(into: [QuizQuestion: QuestionRecord]()) { result, question in
      let record = (
        correct: Int.random(in: 0..<1000),
        errors: Int.random(in: 0..<1000)
      )
      result[question] = record
    }
  }
}
