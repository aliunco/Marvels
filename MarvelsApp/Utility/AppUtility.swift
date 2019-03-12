//
//  AppUtility.swift
//  MarvelsApp
//
//  Created by aliunco on 3/11/19.
//  Copyright © 2019 Zibazi. All rights reserved.
//

import Foundation
import UIKit

struct AppUtility {
    
    static var appName: String? {
        get {
            if let bundle = Bundle.main.object(forInfoDictionaryKey: "CFBundleName") as? String {
                return bundle.replacingOccurrences(of: " ", with: "_")
            }
            return nil
        }
    }
    
    static func getInfoConfigs(for key: String) -> Any? {
        if let configs = Bundle.main.infoDictionary?["configs"] as? [String: Any] {
            return configs[key]
        }
        return nil
    }
}
