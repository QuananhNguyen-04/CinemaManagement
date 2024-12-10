// app.js

// Simulated API response
const movies = [
    {
        id: 1,
        title: "Avatar: The Way of Water",
        poster: "https://via.placeholder.com/200x300?text=Avatar",
        releaseDate: "2024-12-18",
    },
    {
        id: 2,
        title: "The Batman",
        poster: "https://via.placeholder.com/200x300?text=Batman",
        releaseDate: "2024-03-04",
    },
    {
        id: 3,
        title: "Top Gun: Maverick",
        poster: "https://via.placeholder.com/200x300?text=Top+Gun",
        releaseDate: "2024-06-10",
    },
];

// Function to create movie cards
function createMovieCard(movie) {
    return `
        <div class="movie-card" data-id="${movie.id}">
            <img src="${movie.poster}" alt="${movie.title}" class="movie-poster">
            <h2 class="movie-title">${movie.title}</h2>
            <p class="movie-date">Release Date: ${movie.releaseDate}</p>
        </div>
    `;
}

// Function to dynamically load movies
function loadMovies() {
    const movieList = document.getElementById("movie-list");
    movieList.innerHTML = movies.map(createMovieCard).join("");
}

// Initialize
document.addEventListener("DOMContentLoaded", loadMovies);
