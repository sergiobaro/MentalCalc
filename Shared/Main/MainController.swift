import Foundation

struct MainOption: Identifiable {

  var id: String {
    title
  }

  let title: String
  let generator: QuizGenerator
}

class MainController: ObservableObject {

  @Published var options: [MainOption]

  init() {
    options = (1...12).map { MainOption(title: "Practice Times Table \($0)", generator: MultiplicationTableQuizGenerator(number: $0)) }
  }
}
