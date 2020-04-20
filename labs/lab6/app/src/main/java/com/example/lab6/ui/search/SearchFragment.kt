package com.example.lab6.ui.search

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.NavController
import androidx.navigation.Navigation
import androidx.recyclerview.widget.RecyclerView
import com.example.lab6.R
import com.example.lab6.data.Alert

class SearchFragment : Fragment(), SearchRecyclerAdapter.AlertItemListener {

    private lateinit var sharedSearchViewModel: SharedSearchViewModel
    private lateinit var recyclerView: RecyclerView
    private lateinit var navController: NavController

    override fun onCreateView(
            inflater: LayoutInflater,
            container: ViewGroup?,
            savedInstanceState: Bundle?
    ): View? {

        //instance of ViewModel
        sharedSearchViewModel = ViewModelProvider(requireActivity()).get(SharedSearchViewModel::class.java)

        //instantiate nav controller reference using its id from the xml of the main activity layout
        navController = Navigation.findNavController(requireActivity(), R.id.nav_host_fragment)

        val root = inflater.inflate(R.layout.fragment_search, container, false)
        recyclerView = root.findViewById(R.id.recyclerView)

        //subscribe to data changes in the repository class via the ViewModel
        sharedSearchViewModel.alertData.observe(viewLifecycleOwner, Observer {
            //instantiate adapter
            val adapter = SearchRecyclerAdapter(requireContext(), it, this)
            //set the adapter to the recyclerview
            recyclerView.adapter = adapter
        })

        return root
    }

    override fun onAlertItemClick(alert: Alert) {
        Log.i("alertLogging", alert.toString())
        sharedSearchViewModel.selectedAlert.value = alert
        navController.navigate(R.id.action_navigation_search_to_alertDetailFragment)
    }
}