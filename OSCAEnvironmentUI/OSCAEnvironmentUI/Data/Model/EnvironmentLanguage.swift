import ParseCore

open class EnvironmentLanguage: PFObject, PFSubclassing {
    public static func parseClassName() -> String {
        return "EnvironmentLanguage"
    }
    
    @NSManaged public var name: String
    @NSManaged public var locale: String
    @NSManaged public var priority: Int
}
