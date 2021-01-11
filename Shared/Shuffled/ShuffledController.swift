import Foundation

class ShuffledController: ObservableObject {

  @Published var questions: [QuizQuestion]

  init(generator: QuizGenerator) {
    self.questions = generator.generateAll().shuffled()
  }
}
