/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-01-01';
SELECT name FROM animals WHERE animals.neutered = true AND animals.escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE animals.name = 'Agumon' OR animals.name = 'Pikachu';
SELECT name, escape_attempts FROM animals WHERE animals.weight_kg > 10.5;
SELECT * FROM animals WHERE animals.neutered = true;
SELECT * FROM animals WHERE animals.name != 'Gabumon';
SELECT * FROM animals WHERE animals.weight_kg >= 10.4 AND animals.weight_kg <= 17.3;

START TRANSACTION;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

START TRANSACTION;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
SELECT * FROM animals;
COMMIT;
SELECT * FROM animals;

START TRANSACTION;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

START TRANSACTION;
DELETE FROM animals WHERE animals.date_of_birth > '2022-01-01';
SAVEPOINT sp1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO sp1;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) FROM animals;
SELECT COUNT(escape_attempts) FROM animals WHERE animals.escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, SUM(escape_attempts) as total_escape_attempts FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

SELECT name FROM animals JOIN owners ON owners_id = owners.id WHERE owners.full_name = 'Melody Pond';
SELECT animals.name FROM animals JOIN species ON species_id = species.id WHERE species.name = 'Pokemon';
SELECT owners.full_name, animals.name FROM animals RIGHT JOIN owners ON owners_id = owners.id;
SELECT species.name, COUNT(*) FROM animals JOIN species ON species_id = species.id GROUP BY species.name;
SELECT animals.name FROM animals JOIN species ON species_id = species.id JOIN owners ON owners_id = owners.id WHERE species.name = 'Digimon' AND owners.full_name = 'Jennifer Orwell';
SELECT animals.name FROM animals JOIN owners ON owners_id = owners.id WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;
SELECT animals.owners_id, owners.full_name, COUNT(*) FROM animals JOIN owners ON owners_id = owners.id GROUP BY animals.owners_id, owners.full_name ORDER BY COUNT(*) DESC LIMIT 1;
