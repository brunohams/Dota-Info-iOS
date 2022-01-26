import Foundation

class UIComponent {

    private init() {}

    class Dialog: UIComponent {
        let title: String
        let description: String
        init(title: String, description: String) {
            self.title = title
            self.description = description
        }
    }

    class None: UIComponent {
        let message: String
        init(message: String) {
            self.message = message
        }
    }
//    case dialog(uiComponent: Dialog)
//    case none(uiComponent: None)

}


