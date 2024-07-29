import Foundation
import Combine

/// A manager for loading the cities list and handling user favorites
public class CityManager : ObservableObject {
    /// The JSON list of cities stored with the app
    static let localCitiesURL: URL = Bundle.module.url(forResource: "Cities", withExtension: "json")!

    /// The JSON containing the user-selected list of favorite city IDs
    static let favoritesURL: URL = URL.documentsDirectory.appendingPathComponent("favorites.json")

    /// The app-wide singleton `CityManager`
    public static let shared = CityManager()

    private init() {
        do {
            logger.log("localCitiesURL: \(Self.localCitiesURL)")
            logger.log("favoritesURL: \(Self.favoritesURL)")

            // load cities from Cities.json bundled with the app
            self.allCities = try JSONDecoder().decode([City].self, from: Data(contentsOf: Self.localCitiesURL)).sorted { c1, c2 in
                c1.name < c2.name
            }
            logger.log("loaded cities: \(self.allCities.count)")

            // load favorites from favorites.json in the user's app documents folder
            self.favoriteIDs = try JSONDecoder().decode(Array<City.ID>.self, from: Data(contentsOf: Self.favoritesURL))
            logger.log("loaded favorites: \(self.favoriteIDs)")
        } catch {
            logger.log("error initializing CityManager: \(error)")
        }
    }

    /// All the cities in the list
    @Published public var allCities: [City] = []

    /// The ordered list of favorites specified by the user; changed will be persisted to the JSON file
    @Published public var favoriteIDs: Array<City.ID> = [] {
        didSet {
            logger.log("saving favorites: \(self.favoriteIDs)")
            do {
                try JSONEncoder().encode(favoriteIDs).write(to: Self.favoritesURL)
            } catch {
                logger.log("error saving favorites: \(error)")
            }
        }
    }
}
