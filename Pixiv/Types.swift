//
//  Types.swift
//  Pixiv
//
//  Created by fuwaika on 2021/2/8.
//

import Foundation

struct UploadResult : Decodable {
    let images: String
    let error: String
}

struct SauceResult {
    let title: String
    let preview: String
    let illust_id: String
    let illust_link: String
    let author_name: String
    let author_link: String

    var source: String {
        if illust_link.contains("pixiv.net") {
            return "Pixiv"
        } else if illust_link.contains("twitter.com") {
            return "Twitter"
        }

        return ""
    }
}
