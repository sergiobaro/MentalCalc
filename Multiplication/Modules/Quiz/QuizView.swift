import SwiftUI

struct QuizView: View {

  @ObservedObject var controller: QuizController

  var body: some View {
    VStack {
      QuizLastQuestionsView(questions: $controller.lastQuestions)
        .frame(height: 150, alignment: .bottom)
        .padding(.bottom, 10)
      QuizQuestionView(question: $controller.questionText, input: $controller.inputText, color: $controller.borderColor)
        .padding(.horizontal, 20)

      Spacer()
      QuizScoreView(correct: $controller.correct, errors: $controller.errors)
        .padding(.vertical, 10)

      Spacer()
      QuizSolutionView(text: $controller.solutionText, onTap: { controller.showSolution() })
        .padding(.vertical, 10)
        .padding(.horizontal, 20)

      QuizKeyboard(controller: controller)
        .frame(maxHeight: 300)
    }
    .onAppear(perform: {
      self.controller.onAppear()
    })
    .navigationBarTitle("Quiz", displayMode: .inline)
  }
}

struct QuizView_Previews: PreviewProvider {
  static var previews: some View {
    Group {
      QuizView(
        controller: QuizController(
          generator: SimpleQuizGenerator(maxNumber: Constants.maxNumber),
          storage: RandomStorage()
        )
      )
    }
  }
}
