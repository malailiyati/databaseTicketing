-- USERS
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  role VARCHAR(50) DEFAULT 'user',
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

-- PROFILE
CREATE TABLE profile (
  id SERIAL PRIMARY KEY,
  firstName VARCHAR(100) NOT NULL,
  lastName VARCHAR(100) NOT NULL,
  phone VARCHAR(20) NOT NULL,
  users_id INT REFERENCES users(id),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

-- DIRECTOR
CREATE TABLE director (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

-- MOVIES
CREATE TABLE movies (
  id SERIAL PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  director_id INT REFERENCES director(id) NOT NULL,
  poster VARCHAR(255) NOT NULL,
  background_poster VARCHAR(255) NOT NULL,
  releaseDate DATE,
  duration INTERVAL,
  synopsis TEXT,
  popularity INT,
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

-- GENRES
CREATE TABLE genres (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL
);

-- CAST
CREATE TABLE cast (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL
);

-- RELASI MOVIE - GENRE (MANY TO MANY)
CREATE TABLE movie_genre (
  movie_id INT REFERENCES movies(id),
  genre_id INT REFERENCES genres(id)
);

-- RELASI MOVIE - CAST (MANY TO MANY)
CREATE TABLE movie_cast (
  movie_id INT REFERENCES movies(id),
  cast_id INT REFERENCES cast(id)
);

-- TIME
CREATE TABLE time (
  id SERIAL PRIMARY KEY,
  time VARCHAR(100) NOT NULL,
);

-- LOCATION
CREATE TABLE location (
  id SERIAL PRIMARY KEY,
  location VARCHAR(255) NOT NULL
);

-- CINEMA
CREATE TABLE cinema (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  price int NOT NULL
);

-- SCHEDULE
CREATE TABLE schedule (
  id SERIAL PRIMARY KEY,
  movie_id INT REFERENCES movies(id),
  time_id INT REFERENCES time(id),
  location_id INT REFERENCES location(id),
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);

-- SEATS
CREATE TABLE seats (
  id SERIAL PRIMARY KEY,
  seat_number VARCHAR(70) NOT NULL,
  is_sold BOOLEAN DEFAULT FALSE
);

-- ORDER_SEAT
CREATE TABLE order_detail (
  order_id INT REFERENCES orders(id),
  seat_id INT REFERENCES seats(id)
);

-- PAYMENTS
CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    method VARCHAR(70) NOT NULL
)

-- ORDERS
CREATE TABLE orders (
  id SERIAL PRIMARY KEY,
  users_id INT REFERENCES users(id),
  schedule_id INT REFERENCES schedule(id),
  payment_id INT REFERENCES payments(id),
  totalPrice INT,
  fullName VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  phone VARCHAR(100) NOT NULL,
  isPaid boolean DEFAULT 'false'
  qr_code TEXT NOT NULL
  created_at TIMESTAMP,
  updated_at TIMESTAMP
);



