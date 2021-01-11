import Foundation

struct MainOption: Identifiable {

  var id: String {
    title
  }

  let title: String
  let number: Int
}

class MainController: ObservableObject {

  @Published var options: [MainOption]
  @Published var generator: QuizGenerator = SimpleQuizGenerator()

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

    if selectedNumbers.isEmpty {
      generator = SimpleQuizGenerator()
    } else {
      generator = SelectionTableQuizGenerator(numbers: selectedNumbers)
    }
  }
}
