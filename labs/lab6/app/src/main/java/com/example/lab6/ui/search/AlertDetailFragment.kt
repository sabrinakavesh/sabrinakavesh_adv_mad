package com.example.lab6.ui.search

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import com.example.lab6.R
import com.google.android.material.bottomnavigation.BottomNavigationView

/**
 * A simple [Fragment] subclass.
 */
class AlertDetailFragment : Fragment() {

	private lateinit var sharedSearchViewModel: SharedSearchViewModel

	override fun onCreateView(
		inflater: LayoutInflater, container: ViewGroup?,
		savedInstanceState: Bundle?
	): View? {

		//hide the bottom nav since we've moved down in the view hierarchy
		activity?.findViewById<BottomNavigationView>(R.id.nav_view)?.visibility =
			android.view.View.GONE
		val root = inflater.inflate(R.layout.fragment_alert_detail_view, container, false)
//references to the necessary views

		val alertTitleTextView = root.findViewById<TextView>(R.id.alertTitleTextView)
		val categoryTextView = root.findViewById<TextView>(R.id.categoryTextView)
		val descriptionTextView = root.findViewById<TextView>(R.id.descriptionTextView)

		sharedSearchViewModel = ViewModelProvider(requireActivity()).get(SharedSearchViewModel::class.java)

		//we'll populate the details in this Observer as soon as we get them
//		sharedSearchViewModel.alertDetails.observe(viewLifecycleOwner, Observer {
//			Log.i("recipeLogging", "Selected recipe instructions: ${it.}")
//
//			//get ingredient names
//			val ingredientList = mutableListOf<String>()
//			for(ingredient in it.extendedIngredients) {
//				ingredientList.add(ingredient.originalString)
//			}
//			//add instantiate and use adapter for recyclerview
//			val adapter = IngredientsRecyclerAdapter(requireContext(), ingredientList)
//			ingredientListView.adapter = adapter
//
//			//set instructions textview
//			instructionsTextView.text = it.instructions
//		})


		//we'll use this Observer to set the titles ASAP
		sharedSearchViewModel.selectedAlert.observe(viewLifecycleOwner, Observer{
			//set the title in the action bar
			(activity as AppCompatActivity?)?.supportActionBar?.title = it.title
			//set the title textview
			alertTitleTextView.text = it.title
			categoryTextView.text = it.category
			descriptionTextView.text = it.description
		})

		return root
	}

}
