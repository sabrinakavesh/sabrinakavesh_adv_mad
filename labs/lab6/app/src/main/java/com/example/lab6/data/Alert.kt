package com.example.lab6.data

import com.example.lab6.data.database.favorite.Favorite
import com.squareup.moshi.JsonClass

@JsonClass(generateAdapter = true)
data class Alert (
	val category: String,
	val description: String,
	val id: String,
	val parkCode: String,
	val title: String,
	val url: String
){
//	companion object {
//		fun fromRoomFavorite(fav: Favorite): Alert {
//			return Alert(fav.alert_id, fav.title, fav.category,
//				fav.description, fav.parkCode, fav.url)
//		}

		//methods for converting to and from room entities
		fun getRoomFavorite(): Favorite {
			return Favorite(id, title, category, description, parkCode, url)
		}

		companion object {
			fun fromRoomFavorite(fav: Favorite): Alert {
				return Alert(fav.alert_id, fav.title, fav.category,
					fav.description, fav.parkCode, fav.url)
			}

//			fun fromRoomTypes(fav: Favorite): AlertDetails {
//
//				//construct and return the converted object
//				return AlertDetails(fav.alert_id,
//					fav.title,
//					fav.category,
//					fav.description,
//					fav.parkCode,
//					fav.url)
//			}
		}
//	}
}


//@JsonClass(generateAdapter = true)
//data class AlertDetails (
//	val category: String,
//	val description: String,
//	val id: String,
//	val parkCode: String,
//	val title: String,
//	val url: String
//)


//@JsonClass(generateAdapter = true)
//data class AlertDetails (
//	val id: String,
//	val category: String,
//	val description: String,
//	val parkCode: String,
//	val title: String,
//	val url: String
//) {
//	//methods for converting to and from room entities
//	fun getRoomFavorite(): Favorite {
//		return Favorite(id, title, category, description, parkCode, url)
//	}
//
//	companion object {
//		fun fromRoomTypes(fav: Favorite): AlertDetails {
//
//			//construct and return the converted object
//			return AlertDetails(fav.alert_id,
//				fav.title,
//				fav.category,
//				fav.description,
//				fav.parkCode,
//				fav.url)
//		}
//	}
//}

@JsonClass(generateAdapter = true)
data class SearchResponse (
	val data: Set<Alert>,
	val limit: Int,
	val total: Int
)

//api key: mwuGfWMmJrQx2hFBlpH2nejJIhp59MORy5isxbnv
//url: https://developer.nps.gov/api/v1/alerts?q=\()&api_key=mwuGfWMmJrQx2hFBlpH2nejJIhp59MORy5isxbnv