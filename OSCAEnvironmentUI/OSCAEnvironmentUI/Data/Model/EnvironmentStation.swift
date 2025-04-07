import ParseCore
import OSCAEssentials

open class EnvironmentStation: PFObject, PFSubclassing {
    public static func parseClassName() -> String {
        return "EnvironmentStation"
    }
    
    @NSManaged public var name: String
    @NSManaged public var poi: OSCAPointOfInterest
}
