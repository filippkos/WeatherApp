// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum L10n {
  public enum ContainerView {
    /// Forecast
    public static let forecast = L10n.tr("Localizable", "container_view.forecast", fallback: "Forecast")
    /// Localizable.strings
    ///   idap_study_task10
    /// 
    ///   Created by Filipp Kosenko on 07.03.2023.
    public static let today = L10n.tr("Localizable", "container_view.today", fallback: "Today")
    /// Tomorrow
    public static let tomorrow = L10n.tr("Localizable", "container_view.tomorrow", fallback: "Tomorrow")
  }
  public enum DetailsView {
    /// Cloudiness
    public static let cloudinessDiagramTitle = L10n.tr("Localizable", "details_view.cloudiness_diagram_title", fallback: "Cloudiness")
    /// Hourly forecast
    public static let hourlyForecastTitle = L10n.tr("Localizable", "details_view.hourly_forecast_title", fallback: "Hourly forecast")
    /// Humidity
    public static let humidityTitle = L10n.tr("Localizable", "details_view.humidity_title", fallback: "Humidity")
    /// Hourly forecast line chart
    public static let lineChartTitle = L10n.tr("Localizable", "details_view.line_chart_title", fallback: "Hourly forecast line chart")
    /// Pressure
    public static let pressureTitle = L10n.tr("Localizable", "details_view.pressure_title", fallback: "Pressure")
    /// Rain volume
    public static let rainVolumeTitle = L10n.tr("Localizable", "details_view.rain_volume_title", fallback: "Rain volume")
    /// Wind speed
    public static let windSpeedTitle = L10n.tr("Localizable", "details_view.wind_speed_title", fallback: "Wind speed")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
