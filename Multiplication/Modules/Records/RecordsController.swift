import Foundation
import Combine

struct RecordViewModel: Identifiable {
  let id: String
  let question: String
  let correct: Int
  let errors: Int
}

class RecordsController: ObservableObject {

  @Published var records: [RecordViewModel]

  private let storage: Storage

  init(storage: Storage) {
    self.storage = storage
    self.records = []
  }

  func onAppear() {
    records = storage.retrieveAll()
      .map { question, record in
        RecordViewModel(
          id: UUID().uuidString,
          question: "\(question.left) x \(question.right)",
          correct: record.correct,
          errors: record.errors
        )
      }
      .sorted { record1, record2 in
        record1.errors > record2.errors
      }
  }
}
