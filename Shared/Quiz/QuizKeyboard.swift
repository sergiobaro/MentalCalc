import SwiftUI

protocol QuizKeyboardController {
  func input(option: QuizKeyboardOption)
}

enum QuizKeyboardOption {
  case number(Int)
  case check
  case delete

  var title: String {
    switch self {
    case let .number(integer): return "\(integer)"
    case .check: return "Check"
    case .delete: return "Del"
    }

  }

  var image: Image? {
    switch self {
    case .number: return nil
    case .check: return Image(systemName: "checkmark")
    case .delete: return Image(systemName: "delete.left")
    }
  }

  var color: Color {
    switch self {
    case .number: return Color.gray.opacity(0.1)
    case .check: return Color.blue.opacity(0.5)
    case .delete: return Color.red.opacity(0.5)
    }
  }
}

struct QuizKeyboard: View {

  let controller: QuizKeyboardController

  private let spacing: CGFloat = 10
  
  var body: some View {
    VStack(spacing: spacing) {
      HStack(spacing: spacing) {
        QuizKeyboardButton(option: .number(1), controller: controller)
        QuizKeyboardButton(option: .number(2), controller: controller)
        QuizKeyboardButton(option: .number(3), controller: controller)
      }
      HStack(spacing: spacing) {
        QuizKeyboardButton(option: .number(4), controller: controller)
        QuizKeyboardButton(option: .number(5), controller: controller)
        QuizKeyboardButton(option: .number(6), controller: controller)
      }
      HStack(spacing: spacing) {
        QuizKeyboardButton(option: .number(7), controller: controller)
        QuizKeyboardButton(option: .number(8), controller: controller)
        QuizKeyboardButton(option: .number(9), controller: controller)
      }
      HStack(spacing: spacing) {
        QuizKeyboardButton(option: .check, controller: controller)
        QuizKeyboardButton(option: .number(0), controller: controller)
        QuizKeyboardButton(option: .delete, controller: controller)
      }
    }
    .padding(spacing)
  }
}

private struct QuizKeyboardButton: View {

  let option: QuizKeyboardOption
  let controller: QuizKeyboardController

  var body: some View {
    Button(action: {
      self.controller.input(option: option)
    }) {
      AnyView(_fromValue: option.image ?? Text(option.title))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    .foregroundColor(.black)
    .font(.title)
    .background(
      RoundedRectangle(cornerRadius: 10, style: .continuous)
        .fill(option.color)
    )
    
  }
}

struct QuizKeyboard_Previews: PreviewProvider {
  static var previews: some View {
    QuizKeyboard(controller: QuizKeyboardControllerPreview())
  }
}

private class QuizKeyboardControllerPreview: QuizKeyboardController {
  func input(option: QuizKeyboardOption) {
    print(option)
  }
}
