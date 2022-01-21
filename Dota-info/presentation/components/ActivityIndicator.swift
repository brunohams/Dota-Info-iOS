import Foundation
import SwiftUI

struct ActivityIndicator: View {

    @State var degress = 0.0

    var body: some View {
        Circle()
                .trim(from: 0.0, to: 0.6)
                .stroke(Color.blue, lineWidth: 5.0)
                .frame(width: 120, height: 120)
                .rotationEffect(Angle(degrees: degress))
                .onAppear(perform: {self.start()})
    }

    func start() {
        _ = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { timer in
            withAnimation {
                self.degress += 10.0
            }
            if self.degress == 360.0 {
                self.degress = 0.0
            }
        }
    }
}