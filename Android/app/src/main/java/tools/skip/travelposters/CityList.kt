package tools.skip.travelposters

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.runtime.Composable
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import travel.posters.model.CityManager

@Composable
fun CityList(padding: PaddingValues) {
    val cityManager = CityManager.shared
    LazyVerticalGrid(columns = GridCells.Adaptive(minSize = 300.dp),
        contentPadding = padding,
        verticalArrangement = Arrangement.spacedBy(8.dp),
        horizontalArrangement = Arrangement.spacedBy(8.dp)
    ) {
        for (city in cityManager.allCities) {
            item {
                CityPoster(city, isFavorite = { cityManager.favoriteIDs.contains(city.id) }, setFavorite = { isFavorite ->
                    if (isFavorite && !cityManager.favoriteIDs.contains(city.id)) {
                        cityManager.favoriteIDs.append(city.id)
                    } else if (!isFavorite) {
                        cityManager.favoriteIDs.removeAll(where = { it == city.id })
                    }
                })
            }
        }
    }
}