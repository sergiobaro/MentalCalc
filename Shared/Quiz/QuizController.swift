import Combine
import SwiftUI

class QuizController: ObservableObject {

  @Published var questionText: String = ""
  @Published var inputText: String = ""
  @Published var borderColor: Color = .black
  @Published var correct: Int = 0
  @Published var attemps: Int = 0
  @Published var solveDisabled: Bool = false
  @Published var nextDisabled: Bool = true
  @Published var checkDisabled: Bool = false

  private let generator: QuizGenerator
  private var currentQuestion: QuizQuestion

  init(generator: QuizGenerator) {
    self.generator = generator
    self.currentQuestion = generator.generate()
    next()
  }

  func next() {
    borderColor = .black
    inputText = ""
    currentQuestion = generator.generate(previous: currentQuestion)
    questionText = currentQuestion.questionText

    checkDisabled = false
    nextDisabled = true
    solveDisabled = false
  }

  func check() {
    attemps += 1
    if currentQuestion.result == Int(inputText) {
      correct += 1
      next()
    } else {
      self.borderColor = .red
    }
  }

  func solve() {
    attemps += 1
    inputText = "\(currentQuestion.result)"
    checkDisabled = true
    nextDisabled = false
    solveDisabled = true
  }

  func reset() {
    correct = 0
    attemps = 0
    next()
  }
}

extension QuizController: QuizKeyboardController {

  func input(option: QuizKeyboardOption) {
    switch option {
    case let .number(number):
      inputText += String(number)
    case .delete:
      inputText = String(inputText.dropLast())
    }
  }
}
