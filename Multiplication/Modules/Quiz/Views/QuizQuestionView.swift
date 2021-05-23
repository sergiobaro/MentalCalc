import SwiftUI

struct QuizQuestionView: View {

  @Binding var question: String
  @Binding var input: String
  @Binding var color: Color
  
  var body: some View {
    HStack {
      Text(question)
        .font(.title)
        .frame(minWidth: 100)
      Text(input)
        .font(.title)
        .padding(10)
        .frame(maxWidth: .infinity, minHeight: 55)
        .background(
          RoundedRectangle(cornerRadius: 6, style: .continuous)
            .stroke(color, lineWidth: 1)
        )
    }
  }
}

struct QuizQuestionView_Previews: PreviewProvider {
  static var previews: some View {
    QuizQuestionView(question: .constant("99 x 99"), input: .constant("9999"), color: .constant(.black))
  }
}
