import Foundation

class MemoryStorage: Storage {

  private var records: [QuizQuestion: QuestionRecord] = [:]

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
}
