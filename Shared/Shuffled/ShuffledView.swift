import SwiftUI

struct ShuffledView: View {

  @ObservedObject var controller: ShuffledController

  var body: some View {
    List {
      ForEach(controller.questions) { question in
        Text(question.questionText)
      }
    }
  }
}

struct ShuffledView_Previews: PreviewProvider {
  static var previews: some View {
    ShuffledView(controller: ShuffledController(generator: SimpleQuizGenerator()))
  }
}
