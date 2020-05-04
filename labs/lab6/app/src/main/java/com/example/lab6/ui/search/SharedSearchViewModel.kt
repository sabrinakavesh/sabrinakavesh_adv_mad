package com.example.lab6.ui.search

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.MutableLiveData
import com.example.lab6.data.Alert
import com.example.lab6.data.AlertRepository

class SharedSearchViewModel(app: Application) : AndroidViewModel(app) {

	//instantiate repository class
    private val alertRepo = AlertRepository(app)

    //get reference to LiveData object with a value of type List<Recipe>
    val alertData = alertRepo.alertData

//    val alertDetails = alertRepo.alertDetails

    val selectedAlert = MutableLiveData<Alert>()

    val searchUserInput = MutableLiveData<String>()

    var searchLoading = true

    //add the recipe repo observer
    init {
//        selectedAlert.observeForever(alertRepo.alertSelectedObserver)
        searchUserInput.observeForever(alertRepo.searchTermEntered)
    }

    //called when the ViewModel is no longer used
    override fun onCleared() {
        //remove observers added with observe forever to prevent memory leak
//        selectedAlert.removeObserver(alertRepo.alertSelectedObserver)
        searchUserInput.removeObserver(alertRepo.searchTermEntered)
        super.onCleared()
    }

}