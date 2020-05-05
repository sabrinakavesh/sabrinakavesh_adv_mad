package com.example.lab6.data

import android.app.Application
import android.util.Log
import androidx.lifecycle.MutableLiveData
import com.example.lab6.LOG_TAG
import com.google.firebase.firestore.QuerySnapshot
import com.google.firebase.firestore.ktx.firestore
import com.google.firebase.ktx.Firebase

class FavoriteRepository(val app: Application) {
	private val db = Firebase.firestore

	val favoriteList = MutableLiveData<List<Alert>>()
	val favoriteDetails = MutableLiveData<AlertDetails>()
	private val allData: MutableMap<String, AlertDetails> = mutableMapOf()

	val alertIsFavorite = MutableLiveData<Boolean>()

	init {
		db.collection("favorites")
			.addSnapshotListener { snapshot, e ->
				if(e != null) {
					Log.e(LOG_TAG, "Listen failed.", e)
					return@addSnapshotListener
				}
				if (snapshot != null) {
					parseAllData(snapshot)
				} else {
					Log.d(LOG_TAG, "Current data: null")
				}

			}

	}

	private fun parseAllData(result: QuerySnapshot) {
		val allFavorites = mutableListOf<Alert>()
		for(doc in result) {
			//get the data from the document
			val id: String = doc.getString("id")!!
			val title: String = doc.getString("title")!!
			val category: String = doc.getString("category")!!
			val description: String = doc.getString("description")!!
			val parkCode: String = doc.getString("parkCode")!!
			val url: String = doc.getString("url")!!

			//add to all favorites array
			allFavorites.add(Alert(
				id,
				title,
				parkCode,
				url,
				category,
				description
			))

			allData[id] = AlertDetails(
				id,
				title,
				parkCode,
				url,
				category,
				description
			)
		}

		Log.i(LOG_TAG, "allData: $allData")

		favoriteList.value = allFavorites
	}

//	private fun getRecipeInstructions(dbArray: ArrayList<*>): List<Instruction> {
//		val instructions = mutableListOf<Instruction>()
//		for(obj in dbArray) {
//			val map = obj as HashMap<*, *>
//			instructions.add(
//				Instruction(
//					(map["number"] as String).toInt(),
//					map["step"] as String
//				))
//		}
//
//		return instructions
//	}

//	private fun getRecipeIngredients(dbArray: ArrayList<*>): Set<Ingredient> {
//		val ingredients = mutableSetOf<Ingredient>()
//		for(obj in dbArray) {
//			val map = obj as HashMap<*, *>
//			ingredients.add(Ingredient(map["originalString"] as String,
//				map["name"] as String,
//				(map["amount"] as String).toDouble(),
//				map["unit"] as String
//			))
//		}
//		return ingredients
//	}

	fun isAlertFavoriteId(id: String) {
		alertIsFavorite.value = allData.containsKey(id)
	}



	fun getDetailsForAlert(alert: Alert) {
		favoriteDetails.value = allData[alert.id]
	}

	fun removeAlertFromFavorites(id: String) {
		db.collection("favorites").document(id.toString()).delete()
	}

	fun addFavorite(alert: AlertDetails) {
		val alertMap = alertDetailsToHashMap(alert)

		db.collection("favorites").document(alert.id.toString())
			.set(alertMap)
			.addOnSuccessListener {
				Log.i(LOG_TAG, "Added favorite success!")
			}
			.addOnFailureListener { exception ->
				Log.w(LOG_TAG, "Error adding document.", exception)
			}
	}

	private fun alertDetailsToHashMap(alert: AlertDetails): HashMap<String, *> {
		val map = hashMapOf(
			"id" to alert.id,
			"title" to alert.title,
			"category" to alert.category,
			"description" to alert.description,
			"parkCode" to alert.parkCode,
			"url" to alert.url
		)
		return map
	}

//	private fun ingredientsToArrayOfMaps(ingredients: Set<Ingredient>): ArrayList<HashMap<String, *>> {
//		val ingredientArrayList = ArrayList<HashMap<String, *>>()
//
//		for(ingredient in ingredients) {
//			ingredientArrayList.add(hashMapOf(
//				"originalString" to ingredient.originalString,
//				"name" to ingredient.name,
//				"amount" to ingredient.amount.toString(),
//				"unit" to ingredient.unit
//			))
//		}
//		return ingredientArrayList
//	}

//	private fun instructionsToArrayOfMaps(instructions: List<Instruction>): ArrayList<HashMap<String, *>> {
//		val instructionArrayList = ArrayList<HashMap<String, *>>()
//
//		for(instruction in instructions) {
//			instructionArrayList.add(hashMapOf(
//				"number" to instruction.number.toString(),
//				"step" to instruction.step
//			))
//		}
//
//		return instructionArrayList
//	}

}