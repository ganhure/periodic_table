#!/bin/bash
#echo -e "\n~~~ Periodic Table ~~~\n"

PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align --tuples-only -c"

# check if an argument has been provided
if [[ ! $1 ]]
then
echo "Please provide an element as an argument."
else
# check if element is a number
if [[ $1 =~ [0-9]+ ]]
then
# get element atomic number
ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE atomic_number=$1")
# if atomic number is empty it means element does not exist in our database
if [[ -z $ATOMIC_NUMBER ]]
then
echo "I could not find that element in the database."
else
# get element name
NAME=$($PSQL "SELECT name FROM elements WHERE atomic_number=$1")
# get element symbol
SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE atomic_number=$1")
# get element type
TYPE=$($PSQL "SELECT type FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE atomic_number=$1")
# get element atomic mass
ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties FULL JOIN elements USING(atomic_number) WHERE atomic_number=$1")
# get element melting point
MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties FULL JOIN elements USING(atomic_number) WHERE atomic_number=$1")
# get element boiling point
BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties FULL JOIN elements USING(atomic_number) WHERE atomic_number=$1")

echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
fi
# check if element is a name
elif [[ $1 =~ [a-z][a-z][a-z]+ ]]
then
# get element atomic number
ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE name ILIKE '$1'")
# if atomic number is empty it means element does not exist in our database
if [[ -z $ATOMIC_NUMBER ]]
then
echo "I could not find that element in the database."
else
# get element name
NAME=$($PSQL "SELECT name FROM elements WHERE name ILIKE '$1'")
# get element symbol
SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE name ILIKE '$1'")
# get element type
TYPE=$($PSQL "SELECT type FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE name ILIKE '$1'")
# get element atomic mass
ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties FULL JOIN elements USING(atomic_number) WHERE name ILIKE '$1'")
# get element melting point
MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties FULL JOIN elements USING(atomic_number) WHERE name ILIKE '$1'")
# get element boiling point
BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties FULL JOIN elements USING(atomic_number) WHERE name ILIKE '$1'")

echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
fi
# otherwise element must be a symbol
else 
# get element atomic number
ATOMIC_NUMBER=$($PSQL "SELECT atomic_number FROM elements WHERE symbol ILIKE '$1'")
# if atomic number is empty it means element does not exist in our database
if [[ -z $ATOMIC_NUMBER ]]
then
echo "I could not find that element in the database."
else
# get element name
NAME=$($PSQL "SELECT name FROM elements WHERE symbol ILIKE '$1'")
# get element symbol
SYMBOL=$($PSQL "SELECT symbol FROM elements WHERE symbol ILIKE '$1'")
# get element type
TYPE=$($PSQL "SELECT type FROM elements FULL JOIN properties USING(atomic_number) FULL JOIN types USING(type_id) WHERE symbol ILIKE '$1'")
# get element atomic mass
ATOMIC_MASS=$($PSQL "SELECT atomic_mass FROM properties FULL JOIN elements USING(atomic_number) WHERE symbol ILIKE '$1'")
# get element melting point
MELTING_POINT=$($PSQL "SELECT melting_point_celsius FROM properties FULL JOIN elements USING(atomic_number) WHERE symbol ILIKE '$1'")
# get element boiling point
BOILING_POINT=$($PSQL "SELECT boiling_point_celsius FROM properties FULL JOIN elements USING(atomic_number) WHERE symbol ILIKE '$1'")

echo "The element with atomic number $ATOMIC_NUMBER is $NAME ($SYMBOL). It's a $TYPE, with a mass of $ATOMIC_MASS amu. $NAME has a melting point of $MELTING_POINT celsius and a boiling point of $BOILING_POINT celsius."
fi
fi
fi


