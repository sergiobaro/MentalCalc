import SwiftUI

struct FullTableView: View {

  @ObservedObject var controller: FullTableController

  private let columns = [
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
    GridItem(.fixed(50.0), spacing: 0),
  ]

  var body: some View {
    ScrollView(.horizontal) {
      LazyVGrid(columns: columns) {
        ForEach(controller.items) { item in
          Text(item.text)
            .frame(width: 50.0, height: 50.0, alignment: .center)
            .foregroundColor(textColor(item: item))
            .background(backgroundColor(item: item))
            .border(Color.black, width: 0.5)
            .onTapGesture {
              controller.tapItem(item)
            }
        }
      }
      .border(Color.black)
      .padding([.horizontal], 5)

      Spacer()
    }
    .navigationBarTitle("", displayMode: .inline)
  }

  private func textColor(item: FullTableItem) -> Color {
    if item.isSelected {
      return Color.white
    }
    return Color.black
  }

  private func backgroundColor(item: FullTableItem) -> Color {
    if item.isHighlighted && item.isSelected {
      return Color.blue.opacity(0.8)
    }
    if item.isHighlighted {
      return Color.gray.opacity(0.2)
    }
    if item.isSelected {
      return Color.blue.opacity(0.5)
    }
    return Color.white
  }
}

struct FullTable_Previews: PreviewProvider {
  static var previews: some View {
    FullTableView(controller: FullTableController())
  }
}
