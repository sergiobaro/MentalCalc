import Foundation
import Generators

class MultiplyTableController: ObservableObject {

  private let generator: QuizGenerator
  @Published var questions: [String]
  @Published var results: [String]

  init(generator: QuizGenerator) {
    self.generator = generator

    self.questions = generator.generateAll().map { $0.questionText }
    self.results = generator.generateAll().map { String($0.result) }
  }
}
