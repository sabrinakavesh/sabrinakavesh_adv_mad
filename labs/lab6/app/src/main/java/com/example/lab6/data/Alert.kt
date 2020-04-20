package com.example.lab6.data

import com.squareup.moshi.JsonClass

@JsonClass(generateAdapter = true)
data class Alert (
	val category: String,
	val description: String,
	val id: String,
	val parkCode: String,
	val title: String,
	val url: String
)

@JsonClass(generateAdapter = true)
data class AlertDetails (
	val category: String,
	val description: String,
	val parkCode: String,
	val title: String,
	val url: String
)

@JsonClass(generateAdapter = true)
data class SearchResponse (
	val data: Set<Alert>,
	val limit: Int,
	val total: Int
)

//api key: mwuGfWMmJrQx2hFBlpH2nejJIhp59MORy5isxbnv
//url: https://developer.nps.gov/api/v1/alerts?q=\()&api_key=mwuGfWMmJrQx2hFBlpH2nejJIhp59MORy5isxbnv