import SwiftUI

struct SelectableButtonView<Label>: View where Label: View {

  private let action: () -> Void
  private let label: () -> Label

  @State var isSelected = false

  init(action: @escaping () -> Void, @ViewBuilder label: @escaping () -> Label) {
    self.action = action
    self.label = label
  }

  var body: some View {
    label()
      .frame(maxWidth: .infinity, maxHeight: .infinity)
      .foregroundColor(isSelected ? .white : .black)
      .font(.title)
      .padding(.vertical, 20)
      .background(
        RoundedRectangle(cornerRadius: 10, style: .continuous)
          .fill(isSelected ? Color.blue.opacity(0.5) : Color.gray.opacity(0.2))
      )
      .onTapGesture {
        self.isSelected.toggle()
        self.action()
      }
  }
}
