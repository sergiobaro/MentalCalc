import Combine
import SwiftUI

class QuizController: ObservableObject {

  @Published var questionText: String = ""
  @Published var inputText: String = ""
  @Published var solutionText: String = "Show Solution"
  @Published var borderColor: Color = .black
  @Published var correct: Int = 0
  @Published var errors: Int = 0
  @Published var lastQuestions: [String] = []

  private var first: Bool = true
  private let generator: QuizGenerator
  private let storage: Storage
  private var currentQuestion: QuizQuestion

  init(generator: QuizGenerator, storage: Storage) {
    self.generator = generator
    self.storage = storage
    self.currentQuestion = generator.generate()
  }

  func onAppear() {
    reset()
  }

  func next() {
    borderColor = .black
    inputText = ""
    solutionText = "Show Solution"
    if first {
      first = false
      lastQuestions = []
    } else {
      lastQuestions = [currentQuestion.text]
    }
    currentQuestion = generator.generate(previous: currentQuestion)
    questionText = currentQuestion.questionText
  }

  func check() {
    if currentQuestion.result == Int(inputText) {
      correct += 1
      storage.save(question: currentQuestion, correct: true)
      next()
    } else {
      errors += 1
      storage.save(question: currentQuestion, correct: false)
      borderColor = .red
    }
  }

  func showSolution() {
    errors += 1
    solutionText = "\(currentQuestion.result)"
  }

  func reset() {
    correct = 0
    errors = 0
    first = true
    next()
  }
}

extension QuizController: QuizKeyboardController {

  func input(option: QuizKeyboardOption) {
    switch option {
    case let .number(number):
      inputText += String(number)
    case .check:
      check()
    case .delete:
      inputText = String(inputText.dropLast())
    }
  }
}
