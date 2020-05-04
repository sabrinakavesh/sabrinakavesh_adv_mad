package com.example.lab6.data.database

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import com.example.lab6.data.database.favorite.Favorite
import com.example.lab6.data.database.favorite.FavoriteDAO

@Database(entities = arrayOf(Favorite::class), version = 3, exportSchema = false)
abstract class AppDatabase : RoomDatabase() {
//	abstract fun favoriteWithDetailsDAO(): FavoriteWithDetailsDAO
	abstract fun favoriteDAO(): FavoriteDAO
//	abstract fun instructionDAO(): InstructionDAO
//	abstract fun ingredientDAO(): IngredientDAO

	companion object {
		var INSTANCE: AppDatabase? = null

		fun getDatabase(context: Context): AppDatabase {
			val tempInstance = INSTANCE
			//return the instance if it already exists
			if(tempInstance != null) return tempInstance
			//otherwise need to create the instance
			//lock the monitor of the companion object so it can't be access by another thread while we create the database (makes this part of the code thread safe)
			synchronized(this) {
				val instance = Room.databaseBuilder(context.applicationContext, AppDatabase::class.java, "recipe_database").fallbackToDestructiveMigration().build()
				INSTANCE = instance
				return instance
			}
		}
	}
}