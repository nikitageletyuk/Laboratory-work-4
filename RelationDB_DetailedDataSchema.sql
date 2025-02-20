DROP TABLE IF EXISTS Consumer CASCADE;
DROP TABLE IF EXISTS Data CASCADE;
DROP TABLE IF EXISTS DangerLevel CASCADE;
DROP TABLE IF EXISTS Recommendations CASCADE;
DROP TABLE IF EXISTS DangerAssessment CASCADE;
DROP TABLE IF EXISTS InputData CASCADE;
DROP TABLE IF EXISTS RiskReduction CASCADE;

CREATE TABLE Consumer (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL CHECK (email ~ '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
);

CREATE TABLE Data (
    id SERIAL PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    source VARCHAR(255) NOT NULL,
    id_consumer INT REFERENCES Consumer(id) ON DELETE CASCADE
);

CREATE TABLE DangerLevel (
    id SERIAL PRIMARY KEY,
    value INT NOT NULL CHECK (value BETWEEN 0 AND 100),
    updateDate DATE NOT NULL,
    id_consumer INT REFERENCES Consumer(id) ON DELETE CASCADE
);

CREATE TABLE Recommendations (
    id SERIAL PRIMARY KEY,
    text TEXT NOT NULL,
    category VARCHAR(100) NOT NULL,
    id_consumer INT REFERENCES Consumer(id) ON DELETE CASCADE
);

CREATE TABLE DangerAssessment (
    id SERIAL PRIMARY KEY,
    method VARCHAR(255) NOT NULL,
    result TEXT NOT NULL,
    id_consumer INT REFERENCES Consumer(id) ON DELETE CASCADE
);

CREATE TABLE InputData (
    id SERIAL PRIMARY KEY,
    parameters TEXT NOT NULL,
    id_danger_assessment INT REFERENCES DangerAssessment(id) ON DELETE CASCADE
);

CREATE TABLE RiskReduction (
    id SERIAL PRIMARY KEY,
    actions TEXT NOT NULL,
    id_recommendations INT REFERENCES Recommendations(id) ON DELETE CASCADE
);
