import SwiftUI

struct QuizScoreView: View {

  @Binding var correct: Int
  @Binding var errors: Int

  var body: some View {
    HStack {
      VStack {
        Text("Correct:")
          .font(.caption)
        Text("\(correct)")
          .font(.title)
      }
      VStack {
        Text("Errors:")
          .font(.caption)
        Text("\(errors)")
          .font(.title)
      }
    }
  }
}

struct QuizScoreView_Previews: PreviewProvider {
  static var previews: some View {
    QuizScoreView(correct: .constant(99), errors: .constant(99))
  }
}
