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
      ScrollView {
        LazyVGrid(columns: columns) {
          ForEach(controller.questions) { question in
            ShuffledQuestionView(question: question) {
              self.controller.focus(on: question)
            }
            .frame(maxWidth: .infinity)
          }
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

struct ShuffledQuestionView: View {

  let question: ShuffledQuestion
  let action: () -> Void

  var body: some View {
    HStack {
      Spacer()
      Text(question.question.questionText)
      Text(question.inputText)
        .frame(width: 100, height: 35)
        .background(
          RoundedRectangle(cornerRadius: 6, style: .continuous)
            .stroke(question.borderColor, lineWidth: question.borderWidth)
        )
        .onTapGesture {
          action()
        }
    }
    .padding(.trailing, 20)
    .padding(.vertical, 5)
  }
}
