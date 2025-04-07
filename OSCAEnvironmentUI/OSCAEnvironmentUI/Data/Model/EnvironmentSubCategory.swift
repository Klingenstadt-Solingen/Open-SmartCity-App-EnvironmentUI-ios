import ParseCore

open class EnvironmentSubCategory: PFObject, PFSubclassing {
    public static func parseClassName() -> String {
        return "EnvironmentSubCategory"
    }
    
    @NSManaged public var name: String
    @NSManaged public var order: Int
    @NSManaged public var sensorTypes: PFRelation<EnvironmentSensorType>
    @NSManaged public var icon: EnvironmentIcon
}
