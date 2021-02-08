//
//  Host.swift
//  Pixiv
//
//  Created by fuwaika on 2021/2/8.
//

import Foundation
import Alamofire

class HostService {
    private static let URL_UPLOAD_TOKEN = "https://sm.ms"
    private static let URL_UPLOAD_IMAGE = "https://sm.ms/api/v2/upload?inajax=1"

    public static func getToken(completion: @escaping (HTTPCookie?) -> Void) {
        AF.request(URL_UPLOAD_TOKEN).responseString { resp in
            guard let fields = resp.response?.allHeaderFields as? [String: String],
                  let url = resp.request?.url else {
                completion(nil)
                return
            }
            
            let cookies = HTTPCookie.cookies(withResponseHeaderFields: fields, for: url)
            for cookie in cookies where cookie.name == "SM_FC" {
                completion(cookie)
                return
            }

            completion(nil)
        }
    }

    public static func uploadImage(of url: URL, completion: @escaping (Result<String, Error>) -> Void) {
        getToken() { cookie in
            if let cookie = cookie {
                AF.session.configuration.httpCookieStorage?.setCookie(cookie)

                AF.upload(multipartFormData: { form in
                    form.append(url, withName: "smfile")
                    form.append("0".data(using: String.Encoding.utf8)!, withName: "file_id")
                }, to: URL_UPLOAD_IMAGE).responseDecodable(of: UploadResult.self) { resp in
                    switch resp.result {
                    case let .success(data):
                        if data.images == "" {
                            completion(.failure(Utils.makeError(domain: "HostAPI", description: "上传失败：" + data.error)))
                            return
                        }

                        completion(.success(data.images))

                    case let .failure(error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }
}
