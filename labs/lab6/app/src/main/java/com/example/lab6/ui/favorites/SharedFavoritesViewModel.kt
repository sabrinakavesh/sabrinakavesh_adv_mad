package com.example.lab6.ui.favorites

import android.app.Application
import android.util.Log
import androidx.lifecycle.*
import com.example.lab6.data.Alert
import com.example.lab6.data.AlertDetails
import com.example.lab6.data.FavoriteRepository
import com.example.lab6.data.database.AppDatabase
import com.example.lab6.data.database.favorite.Favorite
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch

class SharedFavoritesViewModel(app: Application) : AndroidViewModel(app) {

	private val favRepo = FavoriteRepository(app)

	val favDetails: MutableLiveData<AlertDetails> = favRepo.favoriteDetails

	val favoriteAlertList: MutableLiveData<List<Alert>> = MutableLiveData()

	private val favoriteListObserver =  Observer<List<Favorite>> {
		val allAlerts = mutableListOf<Alert>()

		for(fav in it) {
			allAlerts.add(Alert.fromRoomFavorite(fav))
		}

		favoriteAlertList.value = allAlerts
	}


	init {
		favRepo.favoriteRoomList.observeForever(favoriteListObserver)
	}

	override fun onCleared() {
		favRepo.favoriteRoomList.removeObserver(favoriteListObserver)
		super.onCleared()
	}

	//get selected favorites details and update live data
	fun favSelected(alert: Alert) {
		favRepo.getDetailsForAlert(alert)
	}

	//pass new favorite to repo class for transform and insertion
	fun addFavorite(alert: AlertDetails) {
		favRepo.addFavorite(alert)
	}

	fun removeAlertFromFavorites(id: String) = favRepo.removeAlertFromFavorites(id)


	val isFavorite = favRepo.recipeIsFavorite

	fun isAlertFavoriteId(id: String) {
		favRepo.isAlertFavoriteId(id)
	}

}

