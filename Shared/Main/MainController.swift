import Foundation
import Generators

struct MainOption: Identifiable {

  var id: String {
    title
  }

  let title: String
  let number: Int
}

class MainController: ObservableObject {

  @Published var options: [MainOption]
  @Published var generator: QuizGenerator = SimpleQuizGenerator(maxNumber: Constants.maxNumber)
  @Published var quizDisabled = true
  @Published var shuffledDisabled = true

  private var selectedNumbers = Set<Int>()

  init() {
    options = (1...Constants.maxNumber).map { MainOption(title: "\($0)", number: $0) }
  }

  func select(option: MainOption) {
    if selectedNumbers.contains(option.number) {
      selectedNumbers.remove(option.number)
    } else {
      selectedNumbers.insert(option.number)
    }
    generator = SelectionTableQuizGenerator(maxNumber: Constants.maxNumber, numbers: selectedNumbers)

    switch selectedNumbers.count {
    case 0:
      quizDisabled = true
      shuffledDisabled = true
    case 1:
      quizDisabled = false
      shuffledDisabled = false
    default:
      quizDisabled = false
      shuffledDisabled = true
    }
  }
}
