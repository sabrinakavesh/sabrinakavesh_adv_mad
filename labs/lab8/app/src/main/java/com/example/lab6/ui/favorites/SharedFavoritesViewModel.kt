package com.example.lab6.ui.favorites

import android.app.Application
import androidx.lifecycle.*
import com.example.lab6.data.Alert
import com.example.lab6.data.AlertDetails
import com.example.lab6.data.FavoriteRepository
import com.example.lab6.data.database.favorite.Favorite

class SharedFavoritesViewModel(app: Application) : AndroidViewModel(app) {

	private val favRepo = FavoriteRepository(app)

	val favDetails: MutableLiveData<AlertDetails> = favRepo.favoriteDetails

	val favoriteAlertList: MutableLiveData<List<Alert>> = favRepo.favoriteList



	//get selected favorites details and update live data
	fun favSelected(alert: Alert) {
		favRepo.getDetailsForAlert(alert)
	}

	//pass new favorite to repo class for transform and insertion
	fun addFavorite(alert: AlertDetails) {
		favRepo.addFavorite(alert)
	}

	fun removeAlertFromFavorites(id: String) = favRepo.removeAlertFromFavorites(id)


	val isFavorite = favRepo.alertIsFavorite

	fun isAlertFavoriteId(id: String) {
		favRepo.isAlertFavoriteId(id)
	}

}

