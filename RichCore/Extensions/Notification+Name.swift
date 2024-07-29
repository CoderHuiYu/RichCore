//
//  Notification+Name.swift
//  MMNotes
//
//  Created by JefferyYu on 28.3.22.
//

import Foundation
extension Notification.Name {
    
    public static let enlargePDFNotification = NSNotification.Name("com.MM.MMRefetchPDFThumbnailNotification")
    public static let flowLayoutItemSizeisChangedNotification = NSNotification.Name("MMFlowLayoutItemSizeisChangedNotification")
    public static let fingerScrollEnableChangedNotification = NSNotification.Name("fingerScrollEnableChangedNotification")
    public static let pdfDisplayModeChangedNotification = NSNotification.Name("pdfDisplayModeChangedNotification")
    public static let pdfExpandChangedNotification = NSNotification.Name("pdfExpandChangedNotification")
    public static let pdfAddAssociateNotification = NSNotification.Name("pdfAddAssociateNotification")
    public static let pdfDeleteAssociateNotification = NSNotification.Name("pdfDeleteAssociateNotification")
    public static let pdfAdjustPdfSelectionNotification = NSNotification.Name("pdfAdjustPdfSelectionNotification") // 添加新的pdf，通知调整导航模式的UI
    public static let pdfChoseAssociatePDFNotification = NSNotification.Name("pdfChoseAssociatePDFNotification")
    public static let pdfReadModeChangedNotification = NSNotification.Name("pdfReadModeChangedNotification")
    public static let pdfNvaToolChoseChangedNotification = NSNotification.Name("pdfNvaToolChoseChangedNotification")
    public static let pdfSwitchPositionNotification = NSNotification.Name("pdfSwitchPositionNotification")
    public static let pdfShowVideoNotification = NSNotification.Name("pdfShowVideoNotification")
    public static let pdfLeftRightModeWithShowOnlyOnePdfNotification = NSNotification.Name("pdfLeftRightModeWithShowOnlyOnePdfNotification")
    public static let pdfTemplateHasChangeNotification = NSNotification.Name("pdfTemplateHasChangeNotification")
    
    public static let pdfPasswordChangeStateNotification = NSNotification.Name("pdfPasswordChangeStateNotification")
    public static let pdfPlatePatternChangeNotification = NSNotification.Name("pdfPlatePatternChangeNotification")

    public static let pdfFirstPageIndexChangedNotification = NSNotification.Name("pdfFirstPageIndexChangedNotification")
    public static let pdfChangeNameNotification = NSNotification.Name("pdfChangeNameNotification")
    // 系统颜色改变通知
    public static let mainColorDidChangeNotification = NSNotification.Name("mainColorDidChangeNotification")
    
    
}

extension String {
    public static let MMHasClickedMeunInPDFThumbnal = "MMHasClickedMeunInPDFThumbnal"
}
