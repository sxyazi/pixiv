//
//  Utils.swift
//  Pixiv
//
//  Created by fuwaika on 2021/2/8.
//

import Foundation

class Utils {
    static func makeError(domain: String, description: String) -> Error {
        NSError(domain: domain, code: 0, userInfo: [NSLocalizedDescriptionKey: description])
    }
}
