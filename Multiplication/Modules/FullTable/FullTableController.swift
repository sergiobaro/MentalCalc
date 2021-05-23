import Foundation

struct FullTableItem: Identifiable {
  let id: String
  let number: Int
  let text: String
  let isHighlighted: Bool
  let isSelected: Bool

  init(text: String, number: Int = -1, isHighlighted: Bool = false, isSelected: Bool = false) {
    self.id = UUID().uuidString
    self.number = number
    self.text = text
    self.isHighlighted = isHighlighted
    self.isSelected = isSelected
  }
}

class FullTableController: ObservableObject {

  @Published var items: [FullTableItem] = []
  private var selectedNumber = -1

  init() {
    refresh()
  }

  func tapItem(_ item: FullTableItem) {
    selectedNumber = item.number == 0 ? -1 : item.number
    refresh()
  }

  private func refresh() {
    var items = [FullTableItem]()

    let firstRow: [FullTableItem] = (0...12).map {
      FullTableItem(
        text: $0 == 0 ? " " : String($0),
        number: $0,
        isHighlighted: true,
        isSelected: selectedNumber == $0
      )
    }
    items.append(contentsOf: firstRow)

    for index in 1...12 {
      let rowHeader = FullTableItem(
        text: String(index),
        number: index,
        isHighlighted: true,
        isSelected: selectedNumber == index
      )
      let row: [FullTableItem] = (1...12).map {
        FullTableItem(
          text: String($0 * index),
          isHighlighted: index == $0,
          isSelected: (selectedNumber == index || selectedNumber == $0)
        )
      }
      items.append(contentsOf: [rowHeader] + row)
    }

    self.items = items
  }
}
