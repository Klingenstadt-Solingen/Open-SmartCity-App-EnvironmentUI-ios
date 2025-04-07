import ParseCore

open class EnvironmentIcon: PFObject, PFSubclassing {
    public static func parseClassName() -> String {
        return "EnvironmentIcon"
    }
    
    @NSManaged public var icon: PFFileObject
    @NSManaged public var definition: String
}
