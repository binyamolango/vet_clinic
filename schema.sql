/* Database schema to keep the structure of entire database. */

CREATE TABLE animals (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(15),
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg NUMERIC(10,2)
);

ALTER TABLE animals ADD species VARCHAR(50);

CREATE TABLE owners (
    id BIGSERIAL,
    full_name VARCHAR(30),
    age INT,
    PRIMARY KEY(id) 
);

CREATE TABLE species (
    id BIGSERIAL PRIMARY KEY,
    name VARCHAR(30)
);

ALTER TABLE animals DROP COLUMN species;
ALTER TABLE animals ADD COLUMN species_id INT, ADD CONSTRAINT fk_species_id FOREIGN KEY(species_id) REFERENCES species(id);
ALTER TABLE animals ADD COLUMN owners_id INT, ADD CONSTRAINT fk_owners_id FOREIGN KEY (owners_id) REFERENCES owners(id);

CREATE TABLE vets (
    id BIGSERIAL NOT NULL PRIMARY KEY,
    name VARCHAR(30),
    age INT,
    date_of_graduation DATE
);

CREATE TABLE specializations (
    species_id INT,
    vets_id INT
);
ALTER TABLE specializations ADD CONSTRAINT fk_species_id FOREIGN KEY(species_id) REFERENCES species(id);
ALTER TABLE specializations ADD CONSTRAINT fk_vets_id FOREIGN KEY(vets_id) REFERENCES vets(id);

CREATE TABLE visits (
    animals_id INT,
    vets_id INT,
    date_of_visit DATE,
    CONSTRAINT fk_animals_id FOREIGN KEY(animals_id) REFERENCES animals(id),
    CONSTRAINT fk_vets_id FOREIGN KEY(vets_id) REFERENCES vets(id)
);

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX visits_animals_id ON visits(animals_id);
CREATE INDEX visits_vets_id ON visits(vets_id);
CREATE INDEX owners_email ON owners(email);
