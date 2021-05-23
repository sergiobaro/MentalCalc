import SwiftUI

public struct MultiplicationView: View {
  private let storage = MemoryStorage()
  @ObservedObject var controller: MultiplicationController

  private let columns = [
    GridItem(.flexible()),
    GridItem(.flexible()),
    GridItem(.flexible()),
  ]

  public init() {
    self.controller = MultiplicationController()
  }

  public var body: some View {
    NavigationView {
      VStack {
        HStack {
          Text("Select tables:")
          Spacer()
        }
        .padding(.top, 20)
        .padding(.horizontal, 20)

        LazyVGrid(columns: columns, spacing: 10) {
          ForEach(controller.options) { option in
            SelectableButtonView(action: {
              self.controller.select(option: option)
            }) {
              Text(option.title)
            }
          }
        }
        .padding(.horizontal, 20)

        HStack {
          Spacer()

          NavigationLink(
            destination: QuizView(controller: QuizController(generator: controller.generator, storage: storage)),
            label: {
              Text("Quiz")
                .font(.title)
            })
            .disabled(controller.quizDisabled)

          Spacer()

          NavigationLink(
            destination: ShuffledView(
              controller: ShuffledController(generator: controller.generator, storage: storage)
            ),
            label: {
              Text("Shuffled")
                .font(.title)
            })
            .disabled(controller.shuffledDisabled)

          Spacer()
        }
        .padding()

        HStack {
          Spacer()
          NavigationLink(
            destination: FullTableView(controller: FullTableController()),
            label: {
              Text("Times Table")
                .font(.title)
            }
          )
          Spacer()
          NavigationLink(
            destination: RecordsView(controller: RecordsController(storage: storage)),
            label: {
              Text("Quiz Records")
                .font(.title)
            }
          )
          Spacer()
        }

        Spacer()
      }
      .navigationTitle("Multiplication")
    }
  }
}

struct MainView_Previews: PreviewProvider {
  static var previews: some View {
    MultiplicationView()
  }
}
