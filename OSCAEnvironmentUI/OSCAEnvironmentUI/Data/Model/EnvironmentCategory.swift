import ParseCore

open class EnvironmentCategory: PFObject, PFSubclassing {
    public static func parseClassName() -> String {
        return "EnvironmentCategory"
    }
    
    @NSManaged public var name: String
    @NSManaged public var color: String
    @NSManaged public var order: Int
    @NSManaged public var subCategories: PFRelation<EnvironmentSubCategory>
}
