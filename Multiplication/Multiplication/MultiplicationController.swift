import Foundation

struct Option: Identifiable {

  var id: String {
    title
  }

  let title: String
  let number: Int
}

class MultiplicationController: ObservableObject {

  @Published var options: [Option]
  @Published var generator: QuizGenerator = SimpleQuizGenerator(maxNumber: Constants.maxNumber)
  @Published var quizDisabled = true
  @Published var shuffledDisabled = true
  @Published var tableDisabled = true

  private var selectedNumbers = Set<Int>()

  init() {
    options = (1...Constants.maxNumber).map { Option(title: "\($0)", number: $0) }
  }

  func select(option: Option) {
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
      tableDisabled = true
    case 1:
      quizDisabled = false
      shuffledDisabled = false
      tableDisabled = false
    default:
      quizDisabled = false
      shuffledDisabled = true
      tableDisabled = true
    }
  }
}
