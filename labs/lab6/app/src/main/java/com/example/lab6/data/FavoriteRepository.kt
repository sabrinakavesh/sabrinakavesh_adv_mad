package com.example.lab6.data

import android.app.Application
import android.util.Log
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.example.lab6.LOG_TAG
import com.example.lab6.data.database.AppDatabase
import com.example.lab6.data.database.favorite.Favorite
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.launch

class FavoriteRepository(val app: Application) {
	private val db = AppDatabase.getDatabase(app)

	//dao references
//	private val favoriteWithDetails = db.favoriteWithDetailsDAO()
	private val favoriteDAO = db.favoriteDAO()
//	private val ingredientDAO = db.ingredientDAO()
//	private val instructionDao = db.instructionDAO()

	//get reference to the live data object
	val favoriteRoomList: LiveData<List<Favorite>> = favoriteDAO.getAllFavorites()

	//transforms RecipeWithDetails to Favorite, List<Instructions>, List<Ingredients> and adds to Room using DAOs
	fun addFavorite(alert: Alert) {
		CoroutineScope(Dispatchers.IO).launch {
			//insert the favorite
			favoriteDAO.insertFavorite(alert.getRoomFavorite())
			//insert each instruction
//			for(instruction in alert.getRoomInstructions()) {
//				instructionDAO.insertInstruction(instruction)
//			}
//			//insert each ingredient
//			for(ingredient in recipe.getRoomIngredients()) {
//				ingredientDAO.insertIngredient(ingredient)
//			}
		}
	}

	val favoriteDetails: MutableLiveData<Alert> = MutableLiveData()

	fun getDetailsForAlert(alert: Alert) {
		CoroutineScope((Dispatchers.IO)).launch {
			val fav = favoriteDAO.getFavorite(alert.id)
//			val instructions = instructionDAO.getInstructionsForRecipe(fav.recipe_id)
//			val ingredients = ingredientDAO.getIngredientsForRecipe(fav.recipe_id)
//
			favoriteDetails.postValue(Alert.fromRoomFavorite(fav))
		}
	}

	fun removeAlertFromFavorites(id: String) {
		CoroutineScope(Dispatchers.IO).async {
			favoriteDAO.removeFavorite(id)
		}
	}

	val recipeIsFavorite = MutableLiveData<Boolean>()

	fun isAlertFavoriteId(id: String) {
		CoroutineScope(Dispatchers.IO).launch {
			val favorite = favoriteDAO.getFavorite(id)
			Log.i(LOG_TAG, "Looking for favorite, found ${favorite}")
			recipeIsFavorite.postValue( favorite != null)
		}
	}

//	init {
//		//put some dummy data into our data base
//		CoroutineScope(Dispatchers.IO).launch {
//			favoriteDAO.insertFavorite(Favorite("4C3095E2-1DD8-B71B-0BAC8E16AABF3113", "Area Closures in Canyon", "Some destinations are unavailable because of construction related to the Canyon Overlooks and Trails Restoration Project.", "Information", "yell", "https://www.nps.gov/yell/planyourvisit/canyonprojects.htm"))
////			instructionDao.insertInstruction(Instruction(recipe_id = 1, number = 1, step = "cry"))
////			instructionDao.insertInstruction(Instruction(recipe_id = 2, number = 1, step = "boil water"))
////			ingredientDAO.insertIngredient(Ingredient(recipe_id = 1, name = "pasta", amount = 1.0, unit = "whole"))
//		}
//
//	}

//	fun getInstructionsForRecipe(recipeId: Int) {
//		CoroutineScope(Dispatchers.IO).launch {
//			Log.i(LOG_TAG, instructionDao.getInstructionsForRecipe(recipeId).toString())
//		}
//	}
//
//	fun getIngredientsForRecipe(recipeId: Int) {
//		CoroutineScope(Dispatchers.IO).launch {
//			Log.i(LOG_TAG, ingredientDAO.getIngredientsForRecipe(recipeId).toString())
//		}
//	}



}