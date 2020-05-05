package com.example.lab6.ui.search.results

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ProgressBar
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.constraintlayout.widget.ConstraintSet
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.NavController
import androidx.navigation.Navigation
import androidx.recyclerview.widget.RecyclerView
import com.example.lab6.LOG_TAG
import com.example.lab6.R
import com.example.lab6.data.Alert
import com.example.lab6.ui.adapters.AlertRecyclerAdapter
import com.example.lab6.ui.search.SharedSearchViewModel

/**
 * A simple [Fragment] subclass.
 */
class SearchResultsFragment : Fragment(),
	AlertRecyclerAdapter.AlertItemListener {

	private lateinit var sharedSearchViewModel: SharedSearchViewModel
	private lateinit var loadingBar: ProgressBar
	private lateinit var constraintLayout: ConstraintLayout
	private lateinit var recyclerView: RecyclerView
	private lateinit var navController: NavController

	override fun onCreateView(
		inflater: LayoutInflater,
		container: ViewGroup?,
		savedInstanceState: Bundle?
	): View? {

		//instantiate nav controller reference using its id from the xml of the main activity layout
		navController = Navigation.findNavController(requireActivity(), R.id.nav_host_fragment)

		//instance of ViewModel
		sharedSearchViewModel = ViewModelProvider(requireActivity()).get(SharedSearchViewModel::class.java)

		val root = inflater.inflate(R.layout.fragment_search_results, container, false)
		recyclerView = root.findViewById(R.id.recyclerView)
		constraintLayout = root.findViewById(R.id.resultsConstraintLayout)

		//loading bar with constraints
		loadingBar = ProgressBar(requireContext())
		loadingBar.id = 1
		constraintLayout.addView(loadingBar)

		var constraints = ConstraintSet()
		constraints.clone(constraintLayout)
		constraints.connect(loadingBar.id, ConstraintSet.RIGHT, constraintLayout.id, ConstraintSet.RIGHT, 8)
		constraints.connect(loadingBar.id, ConstraintSet.LEFT, constraintLayout.id, ConstraintSet.LEFT, 8)
		constraints.connect(loadingBar.id, ConstraintSet.TOP, constraintLayout.id, ConstraintSet.TOP, 32)

		constraints.applyTo(constraintLayout)

		//subscribe to data changes in the repository class via the ViewModel
		sharedSearchViewModel.alertData.observe(viewLifecycleOwner, Observer{
			//instantiate adapter
			val adapter =
				AlertRecyclerAdapter(
					requireContext(),
					it,
					this
				)
			//set the adapter to the recyclerview
			recyclerView.adapter = adapter

			toggleLoading(false)
		})

		return root
	}

	override fun onResume() {
		toggleLoading(true)
		super.onResume()
	}

	private fun toggleLoading(loading: Boolean) {
		if(loading && sharedSearchViewModel.searchLoading) {
			recyclerView.visibility = View.INVISIBLE
			loadingBar.visibility = View.VISIBLE
			//we don't want to show the loading indicator unless we perform a new search

		} else if(!loading && sharedSearchViewModel.searchLoading){
			recyclerView.scaleY = 0.0f
			recyclerView.pivotY = 0.0f
			recyclerView.visibility = View.VISIBLE
			recyclerView.animate().scaleY(1.0f).duration = 300
			loadingBar.visibility = View.GONE

			sharedSearchViewModel.searchLoading = false
		} else {
			loadingBar.visibility = View.GONE
		}
	}

	override fun onAlertItemClick(alert: Alert) {
		Log.i(LOG_TAG, alert.toString())

		sharedSearchViewModel.selectedAlert.value = alert
		navController.navigate(R.id.action_searchResultsFragment_to_alertDetailFragment)
	}

}
