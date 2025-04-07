import SwiftUI
import MapKit

// Default
let envDefColorBlue = Color("EnvBlueColor", bundle: OSCAEnvironmentUI.bundle)
let envMainPadding = EdgeInsets(top: 10, leading: 15, bottom: 15, trailing: 15)
let envGridPadding = EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0)
let envGridItemContentPadding: CGFloat = 15
let envGridSpacing: CGFloat = 10
let envGridButtonCornerRadius: CGFloat = 10
let envDefSelectionBrightness = -0.1
let envGridItemMinimalSize: CGFloat = 160
let envRoundedShape = RoundedRectangle(cornerRadius: 10)
let envScrollViewPadding = EdgeInsets(top: 0, leading: envMainPadding.leading, bottom: 0, trailing: envMainPadding.trailing)
let envScrollViewPaddingCancel = EdgeInsets(top: 0, leading: -envMainPadding.leading, bottom: 0, trailing: -envMainPadding.trailing)

// Tabs
let envCategoryTabSelectedColor = Color("EnvCategoryTabSelectedColor", bundle: OSCAEnvironmentUI.bundle)
let envCategoryTabUnselectedColor = Color("EnvCategoryTabUnselectedColor", bundle: OSCAEnvironmentUI.bundle)
let envCategoryTabTitleColor = Color("EnvTextColor", bundle: OSCAEnvironmentUI.bundle)
let envCategoryTabTitleSize: CGFloat = 15
let envCategoryTabShadowRadius: CGFloat = 2
let envCategoryTabShapeCorner: CGFloat = 10
let envCategoryTabSpacing:CGFloat = 10
let envCategoryTabHeight: CGFloat = 40
let envCategoryTabMaskPadding = EdgeInsets(top: -10, leading: -10, bottom: 0, trailing: -10)
let envCategoryTabButtonPressedBrightness = 0.01

// Backbutton
let envBackButtonPadding = EdgeInsets(top: 15, leading: 0, bottom: 0, trailing: 0)
let envBackButtonTitleSize: CGFloat = 30

let envBackButtonTitleColor = Color("EnvTextTitleColor", bundle: OSCAEnvironmentUI.bundle)
let envBackButtonIconColor = Color("EnvYellow", bundle: OSCAEnvironmentUI.bundle)
let envBackButtonIconWidth: CGFloat = 12
let envBackButtonIconHeight: CGFloat = 18
let envBackButtonStrokeSize: CGFloat = 2

// Subtitle
let envSubtitleSize: CGFloat = 13

let envSubtitleColor = Color("EnvTextColor", bundle: OSCAEnvironmentUI.bundle)
let envSubtitleTopPadding = EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
let envSubtitleLeadingPadding = EdgeInsets(top: 0, leading: 20, bottom: 0, trailing: 0)

// Subcategory Grid
let envSubCategoryGridButtonColor = Color("EnvBlueColor", bundle: OSCAEnvironmentUI.bundle)
let envSubCategoryGridButtonTitleColor = Color.white
let envSubCategoryGridButtonTitleSize: CGFloat = 18
let envSubCategoryGridButtonIconColor = Color.white
let envSubCategoryGridContentPadding: CGFloat = envGridItemContentPadding
let envSubCategoryGridButtonTitleHeight: CGFloat = 20
let envSubCategoryGridButtonIconSize: CGFloat = 40

// Station List
let envStationListItemColor = Color("EnvCardBackgroundColor", bundle: OSCAEnvironmentUI.bundle)
let envStationListItemHeight: CGFloat = 40
let envStationListItemTitleFontSize: CGFloat = 18
let envStationListScrollViewPadding = EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
let envStationListIconWidth: CGFloat = 4
let envStationListIconHeight: CGFloat = 8
let envStationListItemPadding = EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 0)
let envStationListButtonCornerRadius: CGFloat = 5
let envStationListTabItemSelectedColor = Color("EnvYellow", bundle: OSCAEnvironmentUI.bundle)
let envStationListTabItemUnselectedColor = Color("EnvCardBackgroundColor", bundle: OSCAEnvironmentUI.bundle)
let envStationListTabItemHeight: CGFloat = 45
let envStationListTabItemTitleColor = Color("EnvTextTitleColor", bundle: OSCAEnvironmentUI.bundle)
let envStationListTabItemTitleSize:CGFloat = 20
let envStationListTabPadding = EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
let envStationListTabItemCornerRadius: CGFloat = 10
let envStationListMapPadding = EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)

// Sensor Grid
let envSensorGridButtonColor = Color("EnvCardBackgroundColor", bundle: OSCAEnvironmentUI.bundle)
let envSensorGridIconColor = Color("EnvCardIconColor", bundle: OSCAEnvironmentUI.bundle)
let envSensorGridIconSize: CGFloat = 30
let envSensorGridUnitTitleSize: CGFloat = 22
let envSensorGridUnitTitleColor = Color("EnvCardIconColor", bundle: OSCAEnvironmentUI.bundle)
let envSensorGridValueTitleSize: CGFloat = 30
let envSensorGridValueTitleColor = Color("EnvCardIconColor", bundle: OSCAEnvironmentUI.bundle)
let envSensorGridSensorTitleSize: CGFloat = 15
let envSensorGridSensorTitleColor = Color("EnvTextTitleColor", bundle: OSCAEnvironmentUI.bundle) //ALMOSTWHITE

// Sensor Detail
let envSensorDetailIconColor = Color("EnvCardIconColor", bundle: OSCAEnvironmentUI.bundle)
let envSensorDetailIconSize: CGFloat = 30
let envSensorDetailUnitTitleSize: CGFloat = 18
let envSensorDetailUnitTitleColor = Color("EnvCardIconColor", bundle: OSCAEnvironmentUI.bundle)
let envSensorDetailFavIconSize: CGFloat = 18
let envSensorDetailValueTitleSize: CGFloat = 32
let envSensorDetailValueTitleColor = Color("EnvCardIconColor", bundle: OSCAEnvironmentUI.bundle)
let envSensorDetailContentPadding = EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0)
let envSensorDetailDescriptionFontSize: CGFloat = 14
let envSensorDetailScrollPadding = EdgeInsets(top: 5, leading: 0, bottom: 0, trailing: 0)
let envSensorDetailMapTitleSize: CGFloat = 17
let envSensorDetailMapTitleColor = Color("EnvCardIconColor", bundle: OSCAEnvironmentUI.bundle)

// Graph
let envGraphStrokeWidth: CGFloat = 2
let envGraphStrokeColor = Color("EnvCardIconColor", bundle: OSCAEnvironmentUI.bundle)
let envGraphGradientFirstColor = Color("EnvGraphGradientFirst", bundle: OSCAEnvironmentUI.bundle)
let envGraphGradientSecondColor = Color("EnvGraphGradientSecond", bundle: OSCAEnvironmentUI.bundle)
let envGraphBackgroundColor = Color("EnvCardBackgroundColor", bundle: OSCAEnvironmentUI.bundle)

let envGraphExternalPadding = EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
let envGraphInternalPadding = EdgeInsets(top: 30, leading: 10, bottom: 10, trailing: 10)

//Map
let envMapMarkerWidth: CGFloat = 20
let envMapMarkerHeight: CGFloat = 30
let envMapMarkerSelectedColor = Color("EnvCardIconColor", bundle: OSCAEnvironmentUI.bundle)
let envMapMarkerUnselectedColor = Color.red
