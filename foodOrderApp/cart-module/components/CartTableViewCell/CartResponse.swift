//
//  CartResponse.swift
//  foodOrderApp
//
//  Created by Kerem Safa Dirican on 14.09.2022.
//

import Foundation

// MARK: - CartResponse
class CartResponse: Codable {
    let sepetYemekler: [SepetYemekler]?
    let success: Int?

    enum CodingKeys: String, CodingKey {
        case sepetYemekler = "sepet_yemekler"
        case success
    }

    init(sepetYemekler: [SepetYemekler], success: Int) {
        self.sepetYemekler = sepetYemekler
        self.success = success
    }
}

// MARK: - SepetYemekler
class SepetYemekler: Codable {
    let sepetYemekID, yemekAdi, yemekResimAdi, yemekFiyat: String?
    let yemekSiparisAdet, kullaniciAdi: String?

    enum CodingKeys: String, CodingKey {
        case sepetYemekID = "sepet_yemek_id"
        case yemekAdi = "yemek_adi"
        case yemekResimAdi = "yemek_resim_adi"
        case yemekFiyat = "yemek_fiyat"
        case yemekSiparisAdet = "yemek_siparis_adet"
        case kullaniciAdi = "kullanici_adi"
    }

    init(sepetYemekID: String, yemekAdi: String, yemekResimAdi: String, yemekFiyat: String, yemekSiparisAdet: String, kullaniciAdi: String) {
        self.sepetYemekID = sepetYemekID
        self.yemekAdi = yemekAdi
        self.yemekResimAdi = yemekResimAdi
        self.yemekFiyat = yemekFiyat
        self.yemekSiparisAdet = yemekSiparisAdet
        self.kullaniciAdi = kullaniciAdi
    }
}
