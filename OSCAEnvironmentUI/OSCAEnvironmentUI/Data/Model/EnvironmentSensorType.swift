import ParseCore

open class EnvironmentSensorType: PFObject, PFSubclassing {
    public static func parseClassName() -> String {
        return "EnvironmentSensorType"
    }
    
    @NSManaged public var name: String
    @NSManaged public var type: String
    @NSManaged public var unit: String
    @NSManaged public var order: Int
    @NSManaged public var definition: String
    @NSManaged public var icon: EnvironmentIcon
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
