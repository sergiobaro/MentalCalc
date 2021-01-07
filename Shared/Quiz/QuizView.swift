import SwiftUI

struct QuizView: View {

  @ObservedObject var controller = QuizController()

  var body: some View {
    VStack {

      QuizScoreView(correct: $controller.correct, attemps: $controller.attemps)

      HStack {
        Text(controller.text)
          .font(.title)
        TextField("", text: $controller.inputText)
          .keyboardType(.numberPad)
          .font(.title)
          .padding(10)
          .background(
            RoundedRectangle(cornerRadius: 6, style: .continuous)
              .stroke(controller.borderColor, lineWidth: 1)
          )
      }
      .padding(.top, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)

      HStack {
        Button("Solve") {
          self.controller.solve()
        }
        .disabled(controller.solveDisabled)
        Button("Next") {
          self.controller.next()
        }
        .disabled(controller.nextDisabled)
        Spacer()
        Button("Check") {
          self.controller.check()
        }
        .disabled(controller.checkDisabled)
      }
      .padding(.vertical, 10)
    }
    .padding(.horizontal, 50)
  }
}

struct QuizView_Previews: PreviewProvider {
  static var previews: some View {
    QuizView()
  }
}
