package com.example.lab6.data.database.favorite

import androidx.lifecycle.LiveData
import androidx.room.Dao
import androidx.room.Insert
import androidx.room.OnConflictStrategy
import androidx.room.Query

@Dao
interface FavoriteDAO {
	@Insert(onConflict = OnConflictStrategy.REPLACE)
	fun insertFavorite(favorite: Favorite)

	@Query("SELECT * FROM favorites_table")
	fun getAllFavorites(): LiveData<List<Favorite>>

	@Query("SELECT * FROM favorites_table WHERE alert_id = :id")
	fun getFavorite(id: String): Favorite

	@Query("DELETE FROM favorites_table WHERE alert_id = :id")
	fun removeFavorite(id: String)
}