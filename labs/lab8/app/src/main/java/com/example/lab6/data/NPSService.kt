package com.example.lab6.data

import com.example.lab6.API_KEY
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Path
import retrofit2.http.Query

interface NPSService {
	@GET("alerts?api_key=${API_KEY}")
	fun searchAlerts(@Query("q") searchTerm: String): Call<SearchResponse>

//	@GET("alerts?apiKey=${API_KEY}")
//	fun alertDetails(@Path("id") id: String): Call<Alert>

}