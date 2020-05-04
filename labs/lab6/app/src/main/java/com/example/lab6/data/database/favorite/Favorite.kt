package com.example.lab6.data.database.favorite

import androidx.room.Entity
import androidx.room.PrimaryKey

@Entity(tableName = "favorites_table")
data class Favorite (
	@PrimaryKey val alert_id: String,
	val title: String,
	val description: String,
	val category: String,
	val parkCode: String,
	val url: String
)