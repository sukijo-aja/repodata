#!/bin/bash

# Memeriksa apakah pesan commit diberikan
if [ -z "$1" ]; then
    echo "Gunakan: ./push.sh \"Pesan commit\""
    exit 1
fi

echo "Generate index file..."
# Pindah ke direktori dalam subshell agar tidak mengubah working directory utama
(
    cd data/muslimapp/products/ || exit
    printf "[\n" > index.json
    ls *.json | grep -v "index.json" | awk '{print "  \""$0"\""}' | paste -sd ",\n" >> index.json
    printf "\n]\n" >> index.json
)

(
    cd data/muslimapp/khutbah/ || exit
    printf "[\n" > index.json
    ls *.json | grep -v "index.json" | awk '{print "  \""$0"\""}' | paste -sd ",\n" >> index.json
    printf "\n]\n" >> index.json
)

echo "Menambahkan perubahan..."
git add .

echo "Menyimpan commit: $1"
git commit -m "$1"

echo "Mendorong ke remote repository..."
git push

echo "Selesai!"
