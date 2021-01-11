import Combine
import SwiftUI
import Generators

class QuizController: ObservableObject {

  @Published var questionText: String = ""
  @Published var inputText: String = ""
  @Published var solutionText: String = "Show Solution"
  @Published var borderColor: Color = .black
  @Published var correct: Int = 0
  @Published var errors: Int = 0

  private let generator: QuizGenerator
  private var currentQuestion: QuizQuestion

  init(generator: QuizGenerator) {
    self.generator = generator
    self.currentQuestion = generator.generate()
  }

  func onAppear() {
    reset()
  }

  func next() {
    borderColor = .black
    inputText = ""
    solutionText = "Show Solution"
    currentQuestion = generator.generate(previous: currentQuestion)
    questionText = currentQuestion.questionText
  }

  func check() {
    if currentQuestion.result == Int(inputText) {
      correct += 1
      next()
    } else {
      errors += 1
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
