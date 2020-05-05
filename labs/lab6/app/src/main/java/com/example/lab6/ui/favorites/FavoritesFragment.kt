package com.example.lab6.ui.favorites

import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.MenuItem
import android.view.View
import android.view.ViewGroup
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.navigation.NavController
import androidx.navigation.Navigation
import androidx.recyclerview.widget.RecyclerView
import com.example.lab6.R
import com.example.lab6.data.Alert
import com.example.lab6.ui.adapters.AlertRecyclerAdapter

class FavoritesFragment : Fragment(), AlertRecyclerAdapter.AlertItemListener {

	private lateinit var favVM: SharedFavoritesViewModel
	private lateinit var favRecyclerView: RecyclerView
	private lateinit var adapter: AlertRecyclerAdapter
	private lateinit var navController: NavController


	override fun onCreateView(
		inflater: LayoutInflater,
		container: ViewGroup?,
		savedInstanceState: Bundle?
	): View? {
		favVM =
			ViewModelProvider(this).get(SharedFavoritesViewModel::class.java)

		navController = Navigation.findNavController(requireActivity(), R.id.nav_host_fragment)

		val root = inflater.inflate(R.layout.fragment_favorites, container, false)
		favRecyclerView = root.findViewById(R.id.favoritesRecyclerView)


		adapter = AlertRecyclerAdapter(requireContext(), emptyList<Alert>(), this)
		favRecyclerView.adapter = adapter

		//add observer for new favorites in database
		favVM.favoriteAlertList.observe(viewLifecycleOwner, Observer {
			adapter.alertList = it
			adapter.notifyDataSetChanged()
		})


////		val root = inflater.inflate(R.layout.fragment_favorites, container, false)
//		val textView: TextView = root.findViewById(R.id.text_favorites)
//
//		//listen for updates to our LiveData object
//		favoritesViewModel.text.observe(viewLifecycleOwner, Observer {
//			textView.text = it
//		})
//
//		favoritesViewModel.favoriteList.observe(viewLifecycleOwner, Observer {
//			Log.i(LOG_TAG, it.toString())
//		})
		return root
	}

	override fun onAlertItemClick(alert: Alert) {
		favVM.favSelected(alert)
		navController.navigate(R.id.action_navigation_favorites_to_alertDetailFragment)
	}

//	override fun onAlertItemClick(alert: Alert) {
//		favVM.fav(alert)
//		navController.navigate(R.id.action_searchResultsFragment_to_alertDetailFragment)
//	}
//	override fun onAlertLongClick(alert: Alert) {
//
//		val dialogBuilder = AlertDialog.Builder(requireContext())
//		dialogBuilder.setMessage("Do you want to remove this recipe from your favorites?")
//			.setCancelable(false)
//			// positive button text and action
//			.setPositiveButton("YES") { dialog, _ ->
//				favVM.removeAlertFromFavorites(alert.id)
//				Toast.makeText(requireContext(),"Recipe removed from Favorites!", Toast.LENGTH_SHORT).show()
//				dialog.dismiss()
//			}
//			// negative button text and action
//			.setNegativeButton("NO") {
//					dialog, _ -> dialog.cancel()
//			}
//
//		val alert = dialogBuilder.create()
//		alert.setTitle("Remove Favorite")
//		alert.show()
//	}
}