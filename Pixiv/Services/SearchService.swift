//
//  Search.swift
//  Pixiv
//
//  Created by fuwaika on 2021/2/8.
//

import Foundation
import Alamofire
import SwiftSoup

class SearchService {
    public static func saucenao(of url: URL, completion: @escaping (Result<[SauceResult], Error>) -> Void) {
        HostService.uploadImage(of: url) { result in
            switch result {
            case let .success(imageURL):
                AF.request("https://saucenao.com/search.php", parameters: [
                    "db": 999,
                    "url": imageURL
                ]).responseString { resp in
                    switch resp.result {
                    case let .success(data):
                        guard let doc = try? SwiftSoup.parse(data) else {
                            completion(.failure(Utils.makeError(domain: "SearchAPI", description: "搜寻失败：HTML 无法解析")))
                            return
                        }

                        guard let elements = try? doc.select("div.result") else {
                            completion(.failure(Utils.makeError(domain: "SearchAPI", description: "搜寻失败：无匹配结果")))
                            return
                        }

                        var results = [SauceResult]()
                        for element in elements {
                            if let title = try? element.select(".resulttitle").first(),
                               let preview = try? element.select(".resultimage img").first(),
                               let illust = try? element.select(".resultcontentcolumn > a").first(),
                               let author = try? element.select(".resultcontentcolumn > a").last(),
                               let preview_src = try? (preview.hasAttr("data-src") ? preview.attr("data-src") : preview.attr("src")) {
                                
                                results.append(SauceResult(title: try! title.text(),
                                                           preview: preview_src,
                                                           illust_id: try! illust.text(),
                                                           illust_link: try! illust.attr("href"),
                                                           author_name: try! author.text(),
                                                           author_link: try! author.attr("href")))
                            }
                        }

                        completion(.success(results))
                        break
                        
                    case let .failure(error):
                        completion(.failure(error))
                    }
                }
                
                
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
