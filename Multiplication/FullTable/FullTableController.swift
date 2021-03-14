import Foundation

struct FullTableItem: Identifiable {
  let id: String
  let text: String
  let highlight: Bool

  init(text: String, highlight: Bool = false) {
    self.id = UUID().uuidString
    self.text = text
    self.highlight = highlight
  }
}

class FullTableController: ObservableObject {

  @Published var items: [FullTableItem] = []

  init() {
    var items = [FullTableItem]()

    let firstRow: [FullTableItem] = (0...12).map {
      let text = $0 == 0 ? " " : String($0)
      return FullTableItem(text: text, highlight: true)
    }
    items.append(contentsOf: firstRow)

    for i in 1...12 {
      let row: [FullTableItem] = (1...12).map {
        let text = String($0 * i)
        return FullTableItem(text: text, highlight: i == $0)
      }
      let rowHeader = FullTableItem(text: String(i), highlight: true)
      items.append(contentsOf: [rowHeader] + row)
    }

    self.items = items
  }
}
