//
//  UIImage+Extension.swift
//  MMNotes
//
//  Created by JefferyYu on 28.2.22.
//

import UIKit

extension UIImage {
    static func image(systemName name: String, withConfiguration configuration: UIImage.Configuration? = UIImage.SymbolConfiguration(pointSize: 15*UIDevice.universalScale, weight: .medium)) -> UIImage? {
         return UIImage(systemName: name, withConfiguration: configuration)
    }
    
    /// 截取图片的指定区域，并生成新图片
    /// - Parameter rect: 指定的区域
    func cropping(to rect: CGRect) -> UIImage? {
        let scale = UIScreen.main.scale
        let x = rect.origin.x * scale
        let y = rect.origin.y * scale
        let width = rect.size.width * scale
        let height = rect.size.height * scale
        let croppingRect = CGRect(x: x, y: y, width: width, height: height)
        // 截取部分图片并生成新图片
        guard let sourceImageRef = self.cgImage else { return nil }
        guard let newImageRef = sourceImageRef.cropping(to: croppingRect) else { return nil }
        let newImage = UIImage(cgImage: newImageRef, scale: scale, orientation: .up)
        return newImage
    }
    
    func preRenderedImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        defer {
            UIGraphicsEndImageContext()
        }
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return self
        }
        return image
    }
}


public extension UIImage {
    @objc static func imageWithColor(_ color : UIColor) -> UIImage {
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    
    }
    
    //计算黑色占比
    func blackColorPercent(_ completion: @escaping (_ percent: Float?) -> Void){
        if self.cgImage == nil {
            return completion(0.0)
        }
        let bitmapInfo = CGBitmapInfo(rawValue: 0).rawValue | CGImageAlphaInfo.premultipliedLast.rawValue
          
        // 第一步 先把图片缩小 加快计算速度. 但越小结果误差可能越大
        let thumbSize = CGSize(width: 40 , height: 40.0/self.size.width * self.size.height)
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        guard let context = CGContext(data: nil,
                                      width: Int(thumbSize.width),
                                      height: Int(thumbSize.height),
                                      bitsPerComponent: 8,
                                      bytesPerRow: Int(thumbSize.width) * 4 ,
                                      space: colorSpace,
                                      bitmapInfo: bitmapInfo) else { return completion(0.0) }
          
        let drawRect = CGRect(x: 0, y: 0, width: thumbSize.width, height: thumbSize.height)
        context.draw(self.cgImage! , in: drawRect)
          
        // 第二步 取每个点的像素值
        if context.data == nil{ return completion(nil)}
        let countedSet = NSCountedSet(capacity: Int(thumbSize.width * thumbSize.height))
        for x in 0 ..< Int(thumbSize.width) {
            for y in 0 ..< Int(thumbSize.height){
                let offset = 4 * x * y
                let red = context.data!.load(fromByteOffset: offset, as: UInt8.self)
                let green = context.data!.load(fromByteOffset: offset + 1, as: UInt8.self)
                let blue = context.data!.load(fromByteOffset: offset + 2, as: UInt8.self)
                let alpha = context.data!.load(fromByteOffset: offset + 3, as: UInt8.self)
                let array = [red,green,blue,alpha]
                countedSet.add(array)
            }
        }
          
        //第三步 找到出现次数最多的那个颜色
        let enumerator = countedSet.objectEnumerator()
        var maxCount = 0
        while let curColor = enumerator.nextObject() as? [Int] , !curColor.isEmpty {
            if (curColor[0] < 19) && (curColor[1] < 19) && (curColor[2] < 19) {
                maxCount += 1
                continue
            }
        }
        //计算占比
        let precent = Float(maxCount) / Float(countedSet.count)
        completion(precent)
   }
    
    
}
