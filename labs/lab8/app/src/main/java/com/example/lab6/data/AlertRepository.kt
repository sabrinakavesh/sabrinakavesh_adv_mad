package com.example.lab6.data

import android.app.Application
import android.util.Log
import androidx.annotation.WorkerThread
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.Observer
import com.example.lab6.BASE_URL
import com.example.lab6.LOG_TAG
import com.example.lab6.utils.FileHelper
import com.example.lab6.utils.NetworkHelper
import com.squareup.moshi.JsonAdapter
import com.squareup.moshi.Moshi
import com.squareup.moshi.Types
import com.squareup.moshi.kotlin.reflect.KotlinJsonAdapterFactory
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import retrofit2.Retrofit
import retrofit2.converter.moshi.MoshiConverterFactory


class AlertRepository(val app: Application) {
	//parameterized type property for Moshi
	private val listType = com.squareup.moshi.Types.newParameterizedType(List::class.java, List::class.java)

	//properties for retrofit
	private var retrofit: Retrofit = Retrofit.Builder()
		.baseUrl(BASE_URL)
		.addConverterFactory(MoshiConverterFactory.create())
		.build()
	private var service: NPSService

	//fetch the data when the class is instantiated
	init {
		//init the service instance
		service = retrofit.create(NPSService::class.java)
	}

	//    Observer for when the user enters text and presses search in the SearchFragment
	val searchTermEntered =  Observer<String> {
		CoroutineScope(Dispatchers.IO).launch {
			getAlertData(it)
		}
	}

	//LiveData object consisting of our recipe data
	//we will publish from this class and subscribe from our fragment
	val alertData = MutableLiveData<List<Alert>>()

	//get the raw text from our json file and update the LiveData object with the parsed data
	@WorkerThread
	private suspend fun getAlertData(searchTerm: String) {
		Log.i(LOG_TAG, searchTerm)
		if(NetworkHelper.networkConnected(app)) {
			val response = service.searchAlerts(searchTerm).execute()
			if(response.body() != null) {
				//successful request
				val responseBody = response.body()
				alertData.postValue(responseBody?.data?.toList())
			} else {
				//there was an error with the request (or server)
				Log.e(LOG_TAG, "Could not search alerts. Error code: ${response.code()}")
			}
		}
	}

	//    This portion of the class is dedicated to fetching detail for a specific recipe and updating the LiveData object

//	val alertSelectedObserver =  Observer<Alert> {
//		CoroutineScope(Dispatchers.IO).launch {
//			getAlertDetails(it)
//		}
//	}
//
//	//LiveData for the recipe details
//	val alertDetails = MutableLiveData<AlertDetails>()
////
//	@WorkerThread
//	private suspend fun getAlertDetails(forAlert: Alert) {
//		if(NetworkHelper.networkConnected(app)) {
//			val response = service.alertDetails(forAlert.id).execute()
//			if(response.body() != null) {
//				alertDetails.postValue(response.body())
//			} else {
//				Log.e(LOG_TAG, "Could not find details for ${forAlert.title}.Error code ${response.code()}")
//			}
//		}

//		val detailsText = FileHelper.readTextFromAssets(app, "sampleData.json")
//
//		val moshi = Moshi.Builder().add(KotlinJsonAdapterFactory()).build()
//		val adapter: JsonAdapter<AlertDetails> = moshi.adapter(AlertDetails::class.java)
//
//		//update our LiveData object with the results of our parsing
//		alertDetails.value = adapter.fromJson(detailsText)
//	}

}