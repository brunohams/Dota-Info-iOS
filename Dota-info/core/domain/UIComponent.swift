import Foundation

enum UIComponent {

    class Dialog {
        let title: String
        let description: String
        init(title: String, description: String) {
            self.title = title
            self.description = description
        }
    }

    class None {
        let message: String
        init(message: String) {
            self.message = message
        }
    }

    case dialog(uiComponent: Dialog)
    case none(uiComponent: None)

}
