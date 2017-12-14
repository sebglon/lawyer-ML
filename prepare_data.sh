#!/bin/bash
set -e

PROJECT_DIR=$PWD
echo "Current dir: $PROJECT_DIR"

# download legi archive (only changed file)
#wget -m  ftp://echanges.dila.gouv.fr/LEGI -P $PROJECT_DIR/lig_data/

# extract all current code and TNC XML
#cd $PROJECT_DIR/data
#rm -f $PROJECT_DIR/data/*
#for f in $PROJECT_DIR/lig_data/echanges.dila.gouv.fr/LEGI/legi*.tar.gz; do
#    echo "start extract file $f"
#    tar -zxf $f --absolute-names --wildcards --no-anchored '*/legi/global/code_et_TNC_en_vigueur/code_en_vigueur/LEGI/TEXT/*.xml' --transform='s:.*/::' -C  $PROJECT_DIR/data/;
#done

# prepare data with perl
echo "start perl append"
mkdir -p $PROJECT_DIR/transformed
rm $PROJECT_DIR/transformed/append_legi.txt
touch $PROJECT_DIR/transformed/append_legi.txt
for filename in $PROJECT_DIR/data/*.xml; do
       line=$( $PROJECT_DIR/legi.pl "$filename")
        printf "\n\r%s\n\r" "$line"  >> ./transformed/append_legi.txt
done
