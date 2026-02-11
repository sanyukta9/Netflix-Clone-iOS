# 🎬 Netflix Clone — iOS App

> iOS Netflix clone built with Swift, UIKit, Firebase, and the TMDB API.

## Current Features:

### Home — Movie Categories
- `UITableView` with **5 horizontal category rows**, each by a nested `UICollectionView`
- Categories fetched live from the **TMDB API**:
  - **Now Playing** — `/movie/now_playing`
  - **Trending Now** — `/trending/movie/day`
  - **Popular Shows** — `/movie/popular`
  - **Top Rated** — `/movie/top_rated`
  - **Recommended For You** — `/movie/upcoming`
- Movie poster images loaded **asynchronously** via `URLSession`

### My Netflix — Profile Screen
- Profile UI layout for Sign In / Sign Up
- Guest mode shown when no user is logged in

---

## Work In Progress:

### 1. Top Navigation — "For \<User\>"
- Navigation bar shows **"For Guest"** when no user is logged in
- After successful **Sign In or Sign Up**, `Guest` is replaced with the user's **display name**

### 2. Search Functionality
- Live search using **TMDB `/search/movie` endpoint**
- Results displayed in a **3-column grid** `UICollectionView`

### 3. My Netflix — Sign In / Sign Up
- Supports both **Sign In** (existing users) and **Sign Up** (new users)
- **"Continue as Guest"** option skips auth and browses anonymously\

### 4. Movie Detail & Playback
- Tap any movie poster to open a **Movie Detail screen**
- Play button for future **video playback integration**

---
