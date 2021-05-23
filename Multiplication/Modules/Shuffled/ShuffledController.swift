import Foundation
import SwiftUI

struct ShuffledQuestion: Identifiable {

  var id: Int {
    question.id
  }
  
  let question: QuizQuestion
  let borderWidth: CGFloat
  let borderColor: Color
  let inputText: String
}

class ShuffledController: ObservableObject {

  private let generator: QuizGenerator
  private let storage: Storage
  private var quizQuestions = [QuizQuestion]()
  private var focusedQuestionIndex = 0
  @Published var questions = [ShuffledQuestion]()

  init(generator: QuizGenerator, storage: Storage) {
    self.generator = generator
    self.storage = storage
  }

  func onAppear() {
    self.quizQuestions = generator.generateAll().shuffled()
    self.focusedQuestionIndex = 0
    self.questions = quizQuestions.enumerated().map { (index, question) -> ShuffledQuestion in
      let isFocused = (index == 0)
      return ShuffledQuestion(question: question,
                              borderWidth: isFocused ? 2 : 1,
                              borderColor: .black,
                              inputText: "")
    }
  }

  func focus(on focusedQuestion: ShuffledQuestion) {
    questions = questions.enumerated().map { (index, question) in
      let isFocused = question.id == focusedQuestion.id
      if isFocused {
        focusedQuestionIndex = index
      }
      return ShuffledQuestion(question: question.question,
                              borderWidth: isFocused ? 2 : 1,
                              borderColor: .black,
                              inputText: question.inputText)
    }
  }

  private func check() {
    if let question = findNextNotAnsweredQuestion() {
      focus(on: question)
    } else {
      checkAnswers()
    }
  }

  private func findNextNotAnsweredQuestion() -> ShuffledQuestion? {
    questions.first(where: { $0.inputText.isEmpty })
  }

  private func checkAnswers() {
    questions = questions.enumerated().map { (index, question) in
      let isFocused = (index == focusedQuestionIndex)
      let isCorrect = Int(question.inputText) == question.question.result

      return ShuffledQuestion(question: question.question,
                              borderWidth: isFocused ? 2 : 1,
                              borderColor: isCorrect ? .green : .red,
                              inputText: question.inputText)
    }
  }

  private func calculateInputText(_ question: ShuffledQuestion, keyboardOption: QuizKeyboardOption) -> String {
    var inputText = question.inputText

    switch keyboardOption {
    case let .number(number):
      inputText += String(number)
    case .check:
      break
    case .delete:
      inputText = String(inputText.dropLast())
    }
    return inputText
  }

  private func mapQuestions(with option: QuizKeyboardOption) {
    self.questions = questions.enumerated().map { (index, question) in
      let isFocused = (index == focusedQuestionIndex)

      let newInputText: String
      if isFocused {
        newInputText = calculateInputText(question, keyboardOption: option)
      } else {
        newInputText = question.inputText
      }

      return ShuffledQuestion(question: question.question,
                              borderWidth: isFocused ? 2 : 1,
                              borderColor: .black,
                              inputText: newInputText)
    }
  }
}

extension ShuffledController: QuizKeyboardController {

  func input(option: QuizKeyboardOption) {
    switch option {
    case .check:
      check()
    default:
      mapQuestions(with: option)
    }
  }
}
