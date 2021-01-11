import Foundation
import SwiftUI
import Generators

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

  private let quizQuestions: [QuizQuestion]
  private var focusedQuestionIndex: Int
  @Published var questions: [ShuffledQuestion]

  init(generator: QuizGenerator) {
    self.quizQuestions = generator.generateAll().shuffled()

    var isFirst = true
    self.questions = quizQuestions.map { question -> ShuffledQuestion in
      if isFirst {
        isFirst = false
        return ShuffledQuestion(question: question, borderWidth: 2, borderColor: .black, inputText: "")
      } else {
        return ShuffledQuestion(question: question, borderWidth: 1, borderColor: .black, inputText: "")
      }
    }

    self.focusedQuestionIndex = 0
  }

  func focus(on focusedQuestion: ShuffledQuestion) {
    self.questions = questions.enumerated().map { (index, question) in
      let isFocused = question.id == focusedQuestion.id
      if isFocused {
        self.focusedQuestionIndex = index
      }
      return ShuffledQuestion(question: question.question,
                              borderWidth: isFocused ? 2 : 1,
                              borderColor: .black,
                              inputText: question.inputText)
    }
  }
}

extension ShuffledController: QuizKeyboardController {

  func input(option: QuizKeyboardOption) {
    if case QuizKeyboardOption.check = option {
      if focusedQuestionIndex == questions.count - 1 {
        // SBS: focusOnFirtEmpty() ?
        check()
      } else {
        focusOnNextQuestion()
      }
      return
    }

    self.questions = questions.enumerated().map { (index, question) in
      let isFocused = index == self.focusedQuestionIndex
      let newInputText: String
      if isFocused {
        newInputText = self.calculateInputText(question, keyboardOption: option)
      } else {
        newInputText = question.inputText
      }

      return ShuffledQuestion(question: question.question,
                              borderWidth: isFocused ? 2 : 1,
                              borderColor: .black,
                              inputText: newInputText)
    }
  }

  private func check() {
    // SBS
  }

  private func focusOnNextQuestion() {
    let question = self.questions[focusedQuestionIndex + 1]
    self.focus(on: question)
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
}
