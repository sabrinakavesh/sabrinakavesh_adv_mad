package com.example.lab6.ui.details

import android.annotation.SuppressLint
import android.os.Bundle
import android.util.Log
import android.view.*
import android.widget.*
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.constraintlayout.widget.ConstraintLayout
import androidx.constraintlayout.widget.ConstraintSet
import androidx.core.content.res.ResourcesCompat
import androidx.fragment.app.Fragment
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProvider
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.example.lab6.LOG_TAG
import com.example.lab6.R
import com.example.lab6.data.Alert
//import com.example.lab6.data.AlertDetails
import com.example.lab6.ui.favorites.SharedFavoritesViewModel
import com.example.lab6.ui.search.SharedSearchViewModel
import com.google.android.material.bottomnavigation.BottomNavigationView

/**
 * A simple [Fragment] subclass.
 */
class AlertDetailFragment : Fragment() {

	//view models
	private lateinit var sharedSearchViewModel: SharedSearchViewModel
	private lateinit var favoritesVM: SharedFavoritesViewModel

	//interface elements
	private lateinit var categoryTextView: TextView
	private lateinit var alertTitleTextView: TextView
	private lateinit var descriptionTextView: TextView
	private lateinit var descriptionTitleTextView: TextView
	private lateinit var categoryTitleTextView: TextView
	private lateinit var constraintLayout: ConstraintLayout


	//keep track of what recipe we are showing
	private var currentAlert: Alert? = null

//	private lateinit var loadingBar: ProgressBar

//	private var resumed = false

//	private val updateViewWithDetails = {
//		//set the current recipe
//		currentAlert = sharedSearchViewModel.selectedAlert
//
//		favoritesVM.isAlertFavoriteId(currentAlert?.id)
//
//		//set the title in the action bar
//		(activity as AppCompatActivity?)?.supportActionBar?.title = currentAlert?.title
//		//set the title textview
//		alertTitleTextView.text = currentAlert?.title
//
////		toggleLoading(false)
//
//	}

	@SuppressLint("ResourceType")
	override fun onCreateView(
		inflater: LayoutInflater, container: ViewGroup?,
		savedInstanceState: Bundle?
	): View? {
		//enable options meu
		setHasOptionsMenu(true)
//		//hide the bottom nav since we've moved down in the view hierarchy
//		activity?.findViewById<BottomNavigationView>(R.id.nav_view)?.visibility =
//			android.view.View.GONE
		val root = inflater.inflate(R.layout.fragment_alert_detail_view, container, false)
//references to the necessary views

		currentAlert = sharedSearchViewModel.selectedAlert

		favoritesVM.isAlertFavoriteId(currentAlert!!.id)

		//set the title in the action bar
		(activity as AppCompatActivity?)?.supportActionBar?.title = currentAlert?.title
		//set the title textview
		alertTitleTextView.text = currentAlert?.title
//		categoryTitleTextView.text = currentAlert?.category


		alertTitleTextView = root.findViewById(R.id.alertTitleTextView)
		categoryTextView = root.findViewById(R.id.categoryTextView)
		descriptionTextView = root.findViewById(R.id.descriptionTextView)
		descriptionTitleTextView = root.findViewById(R.id.descriptionTitleTextView)
		categoryTitleTextView = root.findViewById(R.id.categoryTitleTextView)
		constraintLayout = root.findViewById(R.id.detailConstraintLayout)

		//loading bar with constraints
//		loadingBar = ProgressBar(requireContext())
//		loadingBar.id = 1
//		constraintLayout.addView(loadingBar)
//
//		toggleLoading(true)

//		var constraints = ConstraintSet()
//		constraints.clone(constraintLayout)
//		constraints.connect(loadingBar.id, ConstraintSet.RIGHT, constraintLayout.id, ConstraintSet.RIGHT, 8)
//		constraints.connect(loadingBar.id, ConstraintSet.LEFT, constraintLayout.id, ConstraintSet.LEFT, 8)
//		constraints.connect(loadingBar.id, ConstraintSet.TOP, constraintLayout.id, ConstraintSet.TOP, 32)
//
//		constraints.applyTo(constraintLayout)


		sharedSearchViewModel = ViewModelProvider(requireActivity()).get(SharedSearchViewModel::class.java)
		favoritesVM = ViewModelProvider(requireActivity()).get(SharedFavoritesViewModel::class.java)

//		sharedSearchViewModel.selectedAlert.observe(viewLifecycleOwner, updateViewWithDetails)
//		favoritesVM.favDetails.observe(viewLifecycleOwner, updateViewWithDetails)

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


//		//we'll use this Observer to set the titles ASAP
//		sharedSearchViewModel.selectedAlert.observe(viewLifecycleOwner, Observer{
//			//set the title in the action bar
//			(activity as AppCompatActivity?)?.supportActionBar?.title = it.title
//			//set the title textview
//			alertTitleTextView.text = it.title
//			categoryTextView.text = it.category
//			descriptionTextView.text = it.description
//		})

		return root
	}

//	override fun onResume() {
//		//hide content widgets and show progress bar
//		resumed = true
//		toggleLoading(true)
//		super.onResume()
//	}

//	private fun toggleLoading(loading: Boolean) {
//		Log.i(LOG_TAG, "toggleLoading $loading $resumed")
//		if(loading) {
//			Log.i(LOG_TAG, "hiding content")
//			alertTitleTextView.alpha = 0.0f
//			categoryTextView.alpha = 0.0f
//			descriptionTextView.alpha = 0.0f
//			descriptionTitleTextView.alpha = 0.0f
//			categoryTitleTextView.alpha = 0.0f
////			loadingBar.visibility = View.VISIBLE
//
//		} else if(!loading && resumed){
//			Log.i(LOG_TAG, "fading content in")
//			alertTitleTextView.animate().alpha(1.0f).duration = 200
//			categoryTextView.animate().alpha(1.0f).duration = 200
//			descriptionTextView.animate().alpha(1.0f).duration = 200
//			descriptionTitleTextView.animate().alpha(1.0f).duration = 200
//			categoryTitleTextView.animate().alpha(1.0f).duration = 200
////			loadingBar.visibility = View.GONE
//
//			resumed = false
//		}
//	}

	override fun onCreateOptionsMenu(menu: Menu, inflater: MenuInflater) {
		inflater.inflate(R.menu.detail_menu, menu)

		favoritesVM.isFavorite.observe(viewLifecycleOwner, Observer {
			val item = menu.findItem(R.id.favoriteAlert)
			if(it) {
				setFavoriteMenuItemState(item, getString(R.string.remove))
			}
			else {
				setFavoriteMenuItemState(item, getString(R.string.save))
			}
		})
		super.onCreateOptionsMenu(menu, inflater)
	}

	private fun setFavoriteMenuItemState(menuItem: MenuItem, title: String) {
		menuItem.title = title
		if(title == getString(R.string.save)) {
			menuItem.icon = ResourcesCompat.getDrawable(
				resources,
				android.R.drawable.btn_star_big_off,
				null
			)
		} else if (title == getString(R.string.remove)) {
			menuItem.icon = ResourcesCompat.getDrawable(
				resources,
				android.R.drawable.btn_star_big_on,
				null
			)
		}
	}

	override fun onOptionsItemSelected(item: MenuItem): Boolean {
		//toggle icon and title when pressing the star
		if(item.itemId == R.id.favoriteAlert) {
			if (item.title == getString(R.string.save)) {
				setFavoriteMenuItemState(item, getString(R.string.remove))
				//pass new favorite to view model for persistence
				favoritesVM.addFavorite(currentAlert!!)
				showFavToast("ADD")
			} else {
//				favoritesVM.removeAlertFromFavorites(currentAlert.id)
				confirmFavRemove(item)
			}
		}

		return super.onOptionsItemSelected(item)
	}

	private fun showFavToast(type: String) {
		if(type == "ADD") {
			Toast.makeText(requireContext(),"Alert added to Favorites!", Toast.LENGTH_LONG).show()
		} else {
			Toast.makeText(requireContext(),"Alert removed from Favorites!", Toast.LENGTH_SHORT).show()
		}
	}

	private fun confirmFavRemove(item: MenuItem) {
		val dialogBuilder = AlertDialog.Builder(requireContext())
		dialogBuilder.setMessage("Do you want to remove this alert from your favorites?")
			.setCancelable(false)
			// positive button text and action
			.setPositiveButton("YES") { dialog, _ ->
				favoritesVM.removeAlertFromFavorites(currentAlert!!.id)
				setFavoriteMenuItemState(item, getString(R.string.save))
				showFavToast("REMOVE")
				dialog.dismiss()
			}
			// negative button text and action
			.setNegativeButton("NO") {
					dialog, _ -> dialog.cancel()
			}

		val alert = dialogBuilder.create()
		alert.setTitle("Remove Favorite")
		alert.show()
	}


}
