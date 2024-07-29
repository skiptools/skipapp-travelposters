import Foundation

/// A JSON response from the open-meteo.com weather service
///
/// See https://github.com/open-meteo/sdk.git for a more complete SDK
public struct Weather : Hashable, Codable {
    public var latitude: Double // e.g.: 42.36515
    public var longitude: Double // e.g.: -71.0618
    public var time: Double // e.g.: 0.6880760192871094
    public var offset: Double // e.g.: 0
    public var timezone: String // e.g.: "GMT"
    public var tz: String // e.g.: "GMT"
    public var elevation: Double // e.g.: 8.0
    public var conditions: Conditions

    enum CodingKeys: String, CodingKey {
        case latitude = "latitude"
        case longitude = "longitude"
        case time = "generationtime_ms"
        case offset = "utc_offset_seconds"
        case timezone = "timezone"
        case tz = "timezone_abbreviation"
        case elevation = "elevation"
        case conditions = "current_weather"
    }

    public struct Conditions : Hashable, Codable {
        public var temperature: Double // 16.2
        public var windspeed: Double // 16.6
        public var winddirection: Double // 314
        public var weathercode: Int // 1
        public var is_day: Int // 1
        public var time: String // "2023-07-30T12:00"
    }
}

extension Weather {
    /// Fetches the weather from the open-meteo API
    public static func fetch(latitude: Double, longitude: Double) async throws -> Weather {
        let factor = pow(10.0, 4.0) // API expects a lat/lon rounded to 4 places
        let lat = Double(round(latitude * factor)) / factor
        let lon = Double(round(longitude * factor)) / factor
        let url = URL(string: "https://api.open-meteo.com/v1/forecast?latitude=\(lat)&longitude=\(lon)&current_weather=true")!

        var request = URLRequest(url: url)
        request.setValue("skipapp-bookings", forHTTPHeaderField: "User-Agent")

        logger.info("fetching weather endpoint: \(url.absoluteString)")
        let (data, response) = try await URLSession.shared.data(for: request)
        logger.info("received response: \(response)")
        return try JSONDecoder().decode(Weather.self, from: data)
    }
}
