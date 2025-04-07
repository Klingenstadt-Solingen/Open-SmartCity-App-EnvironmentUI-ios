import SwiftUI

/**
 Universal Grid View showing given items
 
 - Parameters:
    - itemCount: Count of items to create
    - createGridItem: ViewBuilder function to create the grid item externally
    - fetchMore: Called upon loading the last grid item to fetch (if there are any) more items for the grid
 */
struct OSCAEnvironmentGrid<T: View>: View {
    var itemCount: Int
    var createGridItem: (Int) -> T
    var fetchMore: () async -> () = {}
    
    var body: some View {
        ScrollView {
            LazyVGrid(
                columns: Array(
                    repeating: GridItem(
                        .adaptive(minimum: envGridItemMinimalSize),
                        spacing: envGridSpacing
                    ),
                    count: 2
                ),
                spacing: envGridSpacing
            ) {
                ForEach(0..<itemCount, id: \.self) { index in
                    addItemToGrid(itemId: index).task() {
                        if index == itemCount-1 {
                            await fetchMore()
                        }
                    }
                }
            }.padding(envGridPadding)
        }
    }
    
    @ViewBuilder func addItemToGrid(itemId: Int) -> some View {
        createGridItem(itemId)
    }
}
