#if canImport(XCTest)
import XCTest
@testable import OSCAEnvironmentUI

final class OSCAEnvironmentUITests: XCTestCase {
  override func setUpWithError() throws {
    try super.setUpWithError()
  }
  
  func testModuleInit() throws -> Void {
    let uiModule = try makeDevUIModule()
    XCTAssertNotNil(uiModule)
    XCTAssertEqual(uiModule.version, "0.9.0")
    XCTAssertEqual(uiModule.bundlePrefix, "de.nedeco-osca.environment.ui")
    let uiBundle = OSCAEnvironmentUI.bundle
    XCTAssertNotNil(uiBundle)
    let configuration = OSCAEnvironmentUI.configuration
    XCTAssertNotNil(configuration)
  }
  
  func testContactUIConfiguration() throws -> Void {
    let _ = try makeDevUIModule()
    let uiModuleConfig = try makeUIModuleConfig()
    XCTAssertEqual(OSCAEnvironmentUI.configuration.title, uiModuleConfig.title)
  }
}

extension OSCAEnvironmentUITests {
  public func makeUIModuleConfig() throws -> OSCAEnvironmentConfig {
    return OSCAEnvironmentConfig(title: "OSCAEnvironmentUI")
  }
  
  public func makeDevUIModuleDependencies() throws -> OSCAEnvironmentDependencies {
    let uiConfig = try makeUIModuleConfig()
    return OSCAEnvironmentDependencies(moduleConfig: uiConfig)
  }
  
  public func makeDevUIModule() throws -> OSCAEnvironmentUI {
    let devDependencies = try makeDevUIModuleDependencies()
    return OSCAEnvironmentUI.create(with: devDependencies)
  }
  
  public func makeProductionUIModuleDependencies() throws -> OSCAEnvironmentDependencies {
    let uiConfig = try makeUIModuleConfig()
    return OSCAEnvironmentDependencies(moduleConfig: uiConfig)
  }
  
  public func makeProductionUIModule() throws -> OSCAEnvironmentUI {
    let productionDependencies = try makeProductionUIModuleDependencies()
    return OSCAEnvironmentUI.create(with: productionDependencies)
  }
}
#endif
