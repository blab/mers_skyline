# multiple sequence alignment file prep for beauti
# make sure there are no duplicate strain names prior to running
# usage:
# ./data_prep.sh


mkdir ../beast/
cp ../nextstrain-build/phylogenetic/results/metadata.tsv ../beast/
cp ../nextstrain-build/phylogenetic/results/aligned.fasta ../beast/
cd ../data/beast/

#make new strain name col with format name_hct_date
awk -F"," 'OFS="\t" {$1=$2"_"$3"_"$16; print}' metadata.tsv > meta.tsv

remove spaces from strain names
awk -F"\t" 'OFS="\t" {gsub("/[[:blank:]]/", "",$1); print}' meta.tsv > tmp && mv tmp meta.tsv

rename column as 'strain'
awk -F"\t" 'OFS="\t" {sub(/label_"time"_"subgroup"/,"strain",$1); print}' meta.tsv > tmp && mv tmp meta.tsv

#make key,value file kv.txt with 1st col 'strain', 2nd col 'strain_hct_date'
awk 'NR==1{OFS="\t";save=$2;print $2,$1}NR>1{print $2,$1,save}' meta.tsv > kv.txt
awk '!($3="")' kv.txt

awk '{gsub(/"/, ""); print}' kv.txt > tmp && mv tmp kv.txt

#replace old strain names in alignment .fasta  with new strain names
cat aligned.fasta | seqkit replace --ignore-case --kv-file "kv.txt" --pattern "^(\w+)" --replacement "{kv}" > beast-alignment.fasta



