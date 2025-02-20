DROP TABLE IF EXISTS consumer CASCADE;
DROP TABLE IF EXISTS data CASCADE;
DROP TABLE IF EXISTS danger_level CASCADE;
DROP TABLE IF EXISTS recommendations CASCADE;
DROP TABLE IF EXISTS danger_assessment CASCADE;
DROP TABLE IF EXISTS input_data CASCADE;
DROP TABLE IF EXISTS risk_reduction CASCADE;

CREATE TABLE consumer (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL
    CHECK (email ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
);

CREATE TABLE data (
    id SERIAL PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    source VARCHAR(255) NOT NULL,
    id_consumer INT REFERENCES consumer (id) ON DELETE CASCADE
);

CREATE TABLE danger_level (
    id SERIAL PRIMARY KEY,
    value INT NOT NULL CHECK (value BETWEEN 0 AND 100),
    update_date DATE NOT NULL,
    id_consumer INT REFERENCES consumer (id) ON DELETE CASCADE
);

CREATE TABLE recommendations (
    id SERIAL PRIMARY KEY,
    text TEXT NOT NULL,
    category VARCHAR(100) NOT NULL,
    id_consumer INT REFERENCES consumer (id) ON DELETE CASCADE
);

CREATE TABLE danger_assessment (
    id SERIAL PRIMARY KEY,
    method VARCHAR(255) NOT NULL,
    result TEXT NOT NULL,
    id_consumer INT REFERENCES consumer (id) ON DELETE CASCADE
);

CREATE TABLE input_data (
    id SERIAL PRIMARY KEY,
    parameters TEXT NOT NULL,
    id_danger_assessment INT REFERENCES danger_assessment (id) ON DELETE CASCADE
);

CREATE TABLE risk_reduction (
    id SERIAL PRIMARY KEY,
    actions TEXT NOT NULL,
    id_recommendations INT REFERENCES recommendations (id) ON DELETE CASCADE
);
