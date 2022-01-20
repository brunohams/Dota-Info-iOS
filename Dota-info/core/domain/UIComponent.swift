import Foundation

class UIComponent {

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

}
