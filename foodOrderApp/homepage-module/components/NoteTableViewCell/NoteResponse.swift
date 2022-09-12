//
//  NoteResponse.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 12.09.2022.
//

import Foundation

// MARK: - NoteResponse
class NoteResponse: Codable {
    let yemekler: [Yemekler]?
    let success: Int?

    init(yemekler: [Yemekler], success: Int) {
        self.yemekler = yemekler
        self.success = success
    }
}

// MARK: - Yemekler
class Yemekler: Codable {
    let yemekID, yemekAdi, yemekResimAdi, yemekFiyat: String?

    enum CodingKeys: String, CodingKey {
        case yemekID = "yemek_id"
        case yemekAdi = "yemek_adi"
        case yemekResimAdi = "yemek_resim_adi"
        case yemekFiyat = "yemek_fiyat"
    }

    init(yemekID: String, yemekAdi: String, yemekResimAdi: String, yemekFiyat: String) {
        self.yemekID = yemekID
        self.yemekAdi = yemekAdi
        self.yemekResimAdi = yemekResimAdi
        self.yemekFiyat = yemekFiyat
    }
}

