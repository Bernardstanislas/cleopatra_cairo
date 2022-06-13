#!/bin/bash
set -e
echo "Cleaning old results"
rm -f results
rm -f fibonacci.json
rm -f factorial.json
rm -rf oriac

echo "Building cleopatra ..."
cargo build --release

echo "Compiling Fibonacci cairo program"
cairo-compile fibonacci.cairo --output fibonacci.json

cleo_fibonacci_time=$( (time ../target/release/cleopatra-run fibonacci.json) 2>&1 &)
echo "Cleopatra VM Fibonacci time:" >> results
echo "$cleo_fibonacci_time" >> results

cairo_fibonacci_time=$( (time cairo-run --program fibonacci.json) 2>&1 &)
echo -e "\nOriginal Cairo VM Fibonacci time:" >> results
echo "$cairo_fibonacci_time" >> results

echo "Compiling factorial cairo program"
cairo-compile factorial.cairo --output factorial.json

cleo_factorial_time=$( (time ../target/release/cleopatra-run factorial.json) 2>&1 &)
echo -e "\nCleopatra VM factorial time:" >> results
echo "$cleo_factorial_time" >> results

cairo_factorial_time=$( (time cairo-run --program factorial.json) 2>&1 &)
echo -e "\nOriginal Cairo VM factorial time:" >> results
echo "$cairo_factorial_time" >> results

cat results

echo "Cleaning results"
rm results
rm -f fibonacci.json
rm -f factorial.json
rm -rf oriac
