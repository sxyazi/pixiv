//
//  Data.swift
//  Pixiv
//
//  Created by fuwaika on 2021/2/8.
//

import Foundation

class Mock {
    public static var sauceResults: [SauceResult] {
        var results: [SauceResult] = []

        for _ in 0 ..< 5 {
            results.append(SauceResult(title: "LUCIFER",
                                       preview: "https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/4e2207ce-b8f7-4d86-bc56-ecec5a28c0ee/ddnncti-c29494b2-8717-4c80-8302-8166c784ea4c.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOiIsImlzcyI6InVybjphcHA6Iiwib2JqIjpbW3sicGF0aCI6IlwvZlwvNGUyMjA3Y2UtYjhmNy00ZDg2LWJjNTYtZWNlYzVhMjhjMGVlXC9kZG5uY3RpLWMyOTQ5NGIyLTg3MTctNGM4MC04MzAyLTgxNjZjNzg0ZWE0Yy5wbmcifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6ZmlsZS5kb3dubG9hZCJdfQ.2rkyOIKcmtvhJ-k0_yKZEBTGvirUq-xK7wFuzdM4GqQ",
                                       illust_id: "825781158",
                                       illust_link: "https://deviantart.com/view/825781158",
                                       author_name: "sana37",
                                       author_link: "https://www.deviantart.com/sana37"))
        }

        return results
    }
    
    public static var appService: AppService {
        let service = AppService()
        service.showIllusts(from: sauceResults)

        return service
    }
}
