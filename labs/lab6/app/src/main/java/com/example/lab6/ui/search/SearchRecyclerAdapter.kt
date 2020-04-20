package com.example.lab6.ui.search

import android.content.Context
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.lab6.data.Alert
import com.example.lab6.R

class SearchRecyclerAdapter(val context: Context, val alertList: List<Alert>, val itemListener: AlertItemListener) : RecyclerView.Adapter<SearchRecyclerAdapter.ViewHolder>() {
	//custom ViewHolder
	inner class ViewHolder(itemView: View) :
		RecyclerView.ViewHolder(itemView) {
		val titleText = itemView.findViewById<TextView>(R.id.titleTextView)
		val infoText = itemView.findViewById<TextView>(R.id.infoTextView)
	}
	//inflate the view for the item
	override fun onCreateViewHolder(parent: ViewGroup, viewType: Int):
			ViewHolder {
		val inflater = LayoutInflater.from(parent.context)
		val view = inflater.inflate(R.layout.alert_grid_item, parent,
			false)
		return ViewHolder(view)
	}
	//number of items in RecyclerView
	override fun getItemCount() = alertList.count()
	//set the data for the view
	override fun onBindViewHolder(holder: ViewHolder, position: Int) {
		val curAlert = alertList[position]
		holder.titleText.text = curAlert.title
		holder.infoText.text = "${curAlert.category} min"

		//pass the data item to the fragment click listener
		holder.itemView.setOnClickListener {
			itemListener.onAlertItemClick(curAlert)
		}
	}

	interface AlertItemListener {
		fun onAlertItemClick(alert: Alert)
	}


}