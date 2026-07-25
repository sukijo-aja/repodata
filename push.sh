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
    # Mengambil semua nama file json kecuali index.json itu sendiri, lalu diformat menjadi array JSON
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
