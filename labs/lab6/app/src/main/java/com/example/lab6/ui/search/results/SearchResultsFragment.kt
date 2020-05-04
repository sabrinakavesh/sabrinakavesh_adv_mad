package com.example.lab6.ui.search.results

import android.os.Bundle
import android.util.Log
import androidx.fragment.app.Fragment
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
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
		})

		return root
	}

	override fun onAlertItemClick(alert: Alert) {
		Log.i(LOG_TAG, alert.toString())

		sharedSearchViewModel.selectedAlert.value = alert
		navController.navigate(R.id.action_searchResultsFragment_to_alertDetailFragment)
	}

}
