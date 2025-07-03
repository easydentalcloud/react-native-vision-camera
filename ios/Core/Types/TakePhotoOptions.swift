//
//  TakePhotoOptions.swift
//  VisionCamera
//
//  Created by Marc Rousavy on 25.07.24.
//

import AVFoundation
import Foundation

struct TakePhotoOptions {
  var flash: Flash = .off
  var path: URL
  var enableAutoRedEyeReduction = false
  var enableAutoDistortionCorrection = false
  var enableShutterSound = true
  var format: String = "jpeg"

  init(fromJSValue dictionary: NSDictionary) throws {
    // Flash
    if let flashOption = dictionary["flash"] as? String {
      flash = try Flash(jsValue: flashOption)
    }
    // Red-Eye reduction
    if let enable = dictionary["enableAutoRedEyeReduction"] as? Bool {
      enableAutoRedEyeReduction = enable
    }
    // Distortion correction
    if let enable = dictionary["enableAutoDistortionCorrection"] as? Bool {
      enableAutoDistortionCorrection = enable
    }
    // Shutter sound
    if let enable = dictionary["enableShutterSound"] as? Bool {
      enableShutterSound = enable
    }
    // Format
    if let formatOption = dictionary["format"] as? String {
      format = formatOption
    }
    // Custom Path
    let fileExtension = format == "png" ? "png" : "jpg"
    if let customPath = dictionary["path"] as? String {
      path = try FileUtils.getFilePath(customDirectory: customPath, fileExtension: fileExtension)
    } else {
      path = try FileUtils.getFilePath(fileExtension: fileExtension)
    }
  }
}
