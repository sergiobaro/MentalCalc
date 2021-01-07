import Combine
import SwiftUI

class QuizController: ObservableObject {

  @Published var text: String = "7 x 7 ="
  @Published var inputText: String = ""
  @Published var borderColor: Color = .black
  @Published var correct: Int = 0
  @Published var attemps: Int = 0
  @Published var solveDisabled: Bool = false
  @Published var nextDisabled: Bool = true
  @Published var checkDisabled: Bool = false

  private var result: Int = 0

  init() {
    next()
  }

  private func generate() {
    let left = Int.random(in: 1...9)
    let right = Int.random(in: 1...9)
    self.result = left * right

    self.text = "\(left) x \(right) ="
  }

  func next() {
    self.borderColor = .black
    self.inputText = ""
    generate()
    checkDisabled = false
    nextDisabled = true
    solveDisabled = false
  }

  func check() {
    attemps += 1
    if result == Int(inputText) {
      correct += 1
      next()
    } else {
      self.borderColor = .red
    }
  }

  func solve() {
    attemps += 1
    inputText = "\(result)"
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
