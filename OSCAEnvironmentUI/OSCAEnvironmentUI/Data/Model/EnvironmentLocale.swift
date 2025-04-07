import ParseCore

open class EnvironmentLocale: PFObject, PFSubclassing {
    public static func parseClassName() -> String {
        return "EnvironmentLocale"
    }
    
    @NSManaged public var key: String
    @NSManaged public var value: String
    @NSManaged public var locale: String
}
