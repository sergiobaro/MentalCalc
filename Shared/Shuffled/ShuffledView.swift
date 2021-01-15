import SwiftUI
import Generators

struct ShuffledView: View {

  @ObservedObject var controller: ShuffledController
  private let columns = [
    GridItem(.flexible()),
    GridItem(.flexible()),
  ]

  var body: some View {
    VStack {
      LazyVGrid(columns: columns) {
        ForEach(controller.questions) { question in
          ShuffledQuestionView(question: question) {
            self.controller.focus(on: question)
          }
          .frame(maxWidth: .infinity)
        }
      }

      Spacer()

      QuizKeyboard(controller: controller)
        .frame(maxHeight: 300)
    }
    .onAppear(perform: {
      self.controller.onAppear()
    })
  }
}

struct ShuffledView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      ShuffledView(
        controller: ShuffledController(
          generator: SelectionTableQuizGenerator(
            maxNumber: Constants.maxNumber,
            numbers: Set<Int>(arrayLiteral: 1)
          )
        )
      )
    }
  }
}
