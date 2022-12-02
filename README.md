# Molecular epidemiology of the COVID-19 pandemic in Chicago
<b>Ted Ling Hu</b>, <b>Lacy M. Simons</b>, Taylor J. Dean, Estefany Rios Guzman, Matthew T. Caputo, Arghavan Alisoltani, Chao Qi, Michael Malczynski, Timothy Blanke, Lawrence J. Jennings, Michael G. Ison, Chad J. Achenbach, Ramon Lorenzo-Redondo, Egon A. Ozer, & <b>Judd F. Hultquist</b>

<hr>

This repository contains the scripts needed to generate the figures and analysis as reported in Ling Hu and Simons et al 2022 (Unpublished). The script may need to be adapted to the local environment. Due to IRB constraints we are unable to share clinical data used to generate this data. We do however include GISAID accession IDs used to generate the trees in Figure 2. 


# Highlights
<hr>
<ul>
  <li>The second confirmed case of SARS-CoV-2 was discovered in Chicago. </li>
  <li>Since then, Chicago has accumulated over 1.4 million cases and 15,000 deaths.</li>
  <li>Genomic surveillance conducted by Northwestern University reveals that when accounting for epidemiolpogical, demographic and clinical (including vaccination) data, viral clades are not significantly associated with clinical severity.</li>
</ul>

# Summary
<hr>
This single center retrospective study examines the phylogenetics of SARS-CoV-2 in light of patient demographics and clinical outcomes over a two-year period during the COVID-19 pandemic in Chicago.  Between March 17th, 2020 to March 17th, 2022, 14,252 residual diagnostic nasopharyngeal swabs were collected from adult patients; of which 2,114 were subjected to whole genome sequencing.  Surges in case counts correlated highly with the emergence of new variants and five unique waves were identified over the two-year period. Analysis of electronic health records revealed that clade, sex, race, age, number of comorbidities and vaccination doses before infection play an important role in determining patient admission to the hospital.  Statistical analysis also revealed that viral load is associated with clade and vaccination status.  When considering the evolution in the standard of care and seasonality, viral clade was not significantly associated with outcome, disease severity, or clinical lab values among hospitalized patients.


# Dependencies
<hr>
Python
<ul>
  <li> Pandas </li>
  <li> Numpy </li>
  <li> statsmodels </li>
  <li> scipy </li>
  <li> collections </li>
  <li> itertools </li>
  <li> datetime </li>
  <li> sklearn </li>
  <li> seaborn </li>
  <li> math </li>
  <li> matplotlib </li>
</ul>
R
<ul>
  <li> dplyr </li>
  <li> emmeans </li>
  <li> treeio </li>
  <li> ggtree </li>
  <li> emmeapeans </li>
  <li> ggtreeExtra </li>
  <li> ggplot2 </li>
  <li> RColorBrewer </li>
</ul>

MAFFT v7.453

MEGAX v10.1.8.69

IQ-Tree v2.0.5
<ul>
  <li> ModelFinder </li>
</ul>
TreeTime v0.7.6

# Data
<hr>

### Figure 1

<a href="https://github.com/tedlinghu/molecular_epidemiology_covid19_chicago/blob/main/Data/chicago_hosp_cdph.csv">Chicago hospitalizations from CDPH</a> 

<a href="https://github.com/tedlinghu/molecular_epidemiology_covid19_chicago/blob/main/Data/chicago_hosp_idph.csv">Chicago hospitalizations from IDPH</a>

<a href="https://github.com/tedlinghu/molecular_epidemiology_covid19_chicago/blob/main/Data/chicago_cases_test_desths_idph.csv.csv">Chicago cases and deaths from IDPH</a>

<a href="https://github.com/tedlinghu/molecular_epidemiology_covid19_chicago/blob/main/Data/cook_county_cases_test_desths_idph.csv">Cook County cases and deaths from IDPH</a>

<a href="https://github.com/tedlinghu/molecular_epidemiology_covid19_chicago/blob/main/Data/chicago_vax_idph.csv">Chicago vaccination from IDPH</a>

<a href="https://github.com/tedlinghu/molecular_epidemiology_covid19_chicago/blob/main/Data/cook_vax_idph.csv">Cook County vaccination from IDPH</a>

### Figure 2

<a href="https://github.com/tedlinghu/molecular_epidemiology_covid19_chicago/blob/main/Data/cook_county_clades_gisaid.csv">Cook County clades from GISAID</a>

<a href="https://github.com/tedlinghu/molecular_epidemiology_covid19_chicago/blob/main/Data/cook_chicago_cases_idph.csv">Cook County and Chicago cases from IDPH</a>


# Phylogenetic analyses

### Alignment

mafft --auto --thread -1 --keeplength --addfragments Sequences.fasta NC_045512.fasta > Aligned.fasta

### IQtree2 ML Phylogenies

iqtree2 -s Aligned.fasta -T AUTO --alrt 1000 #for Chicago phylogeny also -B 1000 was used

### Treetime

treetime --confidence --relax 1.0 0.5 --aln Aligned.fasta --tree Aligned.fasta.treefile --dates dates.csv --coalescent skyline --clock-filter 4 --clock-rate 0.0008 --clock-std-dev 0.0004 --branch-length-mode marginal

### Mugration (for ancestral state reconstruction)
#### Use Clade, US state, or Country depending on the phylogeny

treetime mugration --tree TreeTime_Out/timetree.nexus --states geo.csv --attribute geo_loc 

### Sequence IDs from GISAID

<a href="https://github.com/tedlinghu/molecular_epidemiology_covid19_chicago/blob/main/Data/usa_sequenceid_gisaid.csv">USA sequence ID from GISAID</a>

<a href="https://github.com/tedlinghu/molecular_epidemiology_covid19_chicago/blob/main/Data/global_sequenceid_gisaid.csv">Global sequence ID from GISAID</a>

<a href="https://github.com/tedlinghu/molecular_epidemiology_covid19_chicago/blob/main/Data/final_sequences_accession_IDs.xlsx
">Accession IDs for sequences from Northwestern</a>
