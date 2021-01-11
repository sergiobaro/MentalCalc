import SwiftUI

struct QuizView: View {

  @ObservedObject var controller: QuizController

  var body: some View {
    VStack {
      Spacer()
      QuizScoreView(correct: $controller.correct, errors: $controller.errors)
        .padding(.vertical, 10)
      Spacer()

      HStack {
        Text(controller.questionText)
          .font(.title)
          .frame(minWidth: 100)
        Text(controller.inputText)
          .font(.title)
          .padding(10)
          .frame(maxWidth: .infinity, minHeight: 55)
          .background(
            RoundedRectangle(cornerRadius: 6, style: .continuous)
              .stroke(controller.borderColor, lineWidth: 1)
          )
      }
      .padding(.horizontal, 20)

      Spacer()

      HStack {
        Text(self.controller.solutionText)
          .onTapGesture {
            self.controller.showSolution()
          }
      }
      .padding(.vertical, 10)
      .padding(.horizontal, 20)

      QuizKeyboard(controller: controller)
        .frame(maxHeight: 300)
    }
    .onAppear(perform: {
      self.controller.onAppear()
    })
  }
}

struct QuizView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      QuizView(controller: QuizController(generator: SimpleQuizGenerator()))
    }
  }
}
