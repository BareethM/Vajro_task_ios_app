//
//  HomeModel.swift
//  HomeUI
//
//  Created by Bareeth on 23/01/23.
//

import Foundation


struct HomeData : Codable {
    let articles : [Articles]
    let status : String?

    enum CodingKeys: String, CodingKey {

        case articles = "articles"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        articles = try values.decodeIfPresent([Articles].self, forKey: .articles)!
        status = try values.decodeIfPresent(String.self, forKey: .status)
    }

}


struct Articles : Codable {
    let id : Int?
    let title : String?
    let created_at : String?
    let body_html : String?
    let blog_id : Int?
    let author : String?
    let user_id : Int?
    let published_at : String?
    let updated_at : String?
    let summary_html : String?
    let template_suffix : String?
    let handle : String?
    let tags : String?
    let admin_graphql_api_id : String?
    let image : Image?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case created_at = "created_at"
        case body_html = "body_html"
        case blog_id = "blog_id"
        case author = "author"
        case user_id = "user_id"
        case published_at = "published_at"
        case updated_at = "updated_at"
        case summary_html = "summary_html"
        case template_suffix = "template_suffix"
        case handle = "handle"
        case tags = "tags"
        case admin_graphql_api_id = "admin_graphql_api_id"
        case image = "image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        body_html = try values.decodeIfPresent(String.self, forKey: .body_html)
        blog_id = try values.decodeIfPresent(Int.self, forKey: .blog_id)
        author = try values.decodeIfPresent(String.self, forKey: .author)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        published_at = try values.decodeIfPresent(String.self, forKey: .published_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        summary_html = try values.decodeIfPresent(String.self, forKey: .summary_html)
        template_suffix = try values.decodeIfPresent(String.self, forKey: .template_suffix)
        handle = try values.decodeIfPresent(String.self, forKey: .handle)
        tags = try values.decodeIfPresent(String.self, forKey: .tags)
        admin_graphql_api_id = try values.decodeIfPresent(String.self, forKey: .admin_graphql_api_id)
        image = try values.decodeIfPresent(Image.self, forKey: .image)
    }

}


struct Image : Codable {
    let created_at : String?
    let alt : String?
    let width : Int?
    let height : Int?
    let src : String?

    enum CodingKeys: String, CodingKey {
        case created_at = "created_at"
        case alt = "alt"
        case width = "width"
        case height = "height"
        case src = "src"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        alt = try values.decodeIfPresent(String.self, forKey: .alt)
        width = try values.decodeIfPresent(Int.self, forKey: .width)
        height = try values.decodeIfPresent(Int.self, forKey: .height)
        src = try values.decodeIfPresent(String.self, forKey: .src)
    }

}

