import SwiftUI
import Generators

struct MultiplyTableView: View {

  @ObservedObject var controller: MultiplyTableController
  private let columns = [
    GridItem(.flexible()),
    GridItem(.flexible()),
  ]

  var body: some View {
    VStack {
      LazyVGrid(columns: columns, alignment: .center) {
        VStack {
          ForEach(controller.questions, id: \.self) { question in
            Text(question)
              .font(.title)
              .frame(maxWidth: .infinity, alignment: .trailing)
          }
        }
        VStack(alignment: .trailing) {
          ForEach(controller.results, id: \.self) { result in
            Text(result)
              .font(.title)
          }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
      }
      .padding(.horizontal)
      Spacer()
    }
  }
}

struct MultiplyTableView_Previews: PreviewProvider {
  static var previews: some View {
    NavigationView {
      MultiplyTableView(
        controller: MultiplyTableController(
          generator: SelectionTableQuizGenerator(maxNumber: Constants.maxNumber, numbers: Set<Int>(arrayLiteral: 12))
        )
      )
    }
  }
}
