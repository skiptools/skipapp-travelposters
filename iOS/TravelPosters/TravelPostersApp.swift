import SwiftUI

@main
struct TravelPostersApp: App {
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.black
                CityListView()
            }
            .preferredColorScheme(.dark)
        }
    }
}
