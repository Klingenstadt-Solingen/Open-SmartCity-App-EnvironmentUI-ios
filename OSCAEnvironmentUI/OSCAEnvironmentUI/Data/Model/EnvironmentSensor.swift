import ParseCore

open class EnvironmentSensor: PFObject, PFSubclassing, Identifiable {
    public static func parseClassName() -> String {
        return "EnvironmentSensor"
    }
    
    @NSManaged public var value: Double
    @NSManaged public var refId: String
    @NSManaged public var observedAt: Date
    @NSManaged public var sensorType: EnvironmentSensorType
    @NSManaged public var station: EnvironmentStation
    @NSManaged public var graphDivider: NSArray?
    
    func getGraphDivider() -> [EnvironmentGraphDivider]? {
        guard let graphDivider = graphDivider else {
            return nil
        }
        guard var list = try? JSONDecoder().decode([EnvironmentGraphDivider].self, from: JSONSerialization.data(withJSONObject: graphDivider)) else {
            return nil
        }
        return list
    }
}
