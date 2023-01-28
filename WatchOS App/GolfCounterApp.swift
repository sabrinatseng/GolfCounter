import SwiftUI

@main
struct golf_counter_Watch_AppApp: App {
    @State private var holes = Holes()
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SummaryView(holes: $holes)
            }
        }
    }
}
