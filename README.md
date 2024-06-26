# MASCOT-Skyline for MERS

Background reading:

[Muller et al.](https://www.biorxiv.org/content/10.1101/2024.03.06.583734v2)

[MASCOT tutorial](https://github.com/nicfel/MascotSkyline-Tutorial)

Things to make sure you have on your comp:

[BEAST2 (with MASCOT package)](https://www.beast2.org/)
[Tracer](https://beast.community/tracer) 

## How to run MASCOT-Skyline

### Prepare sequences
Life with BEAST is much easier if the strain names has both the date and the host name. So that it looks like this example from mpox `MPXV-USA-IL-IDPH-073_NorthAmerica_2022-06-30`. 

The easiest way to do this is via the custom script in this folder called `data_prep.sh` which takes in a nextstrain metadata file as well as the aligned.fasta and formats it correctly. 

_Of note_, there are a lot of things that are hardcoded in this script so you need to go in to change the file names as well as the columns that are found in your metadata file. 

Once updated, you can run the script via the command line using `./data_prep.sh`

This will create a new folder called `beast/` which will contain your formatted FASTA file. 

### Preparing the XML

BEAST works using an XML which contains all the information it needs to run the analysis. The easiest way to make the XML is via BEAUTI which should be included as part of the folder where BEAST can be found. 

Open up BEAUTI and import the alignment like seen in the MASCOT-Skyline tutorial above.

For tip dates, the character delimeter is `_` so you can ask beauti to extract tip dates based on this character. 

We'll be using similar priors as the [Dudas MERS paper](https://elifesciences.org/articles/31257) which are:
- HKY + \gamma substitution model
- Relaxed molecular clock with a lognormal distribution
- exponetial prior on migration rates with a mean of 1.0

We can estimate about 10 Nes per host? we can play around with it. 

As you'll see in the tutorial, we need to make sure to put normal distribution priors on the Nes but we'll cover that in person. 

### Running the XML
While you can run BEAST in the command line, the easiest way is to go to your BEAST folder, open the BEAST application which will bring up the GUI. From there, you can just find your file and test to see if it runs

### Running on the cluster
It'd be good for us to run it in the cluster as it'll take a while to run. I dont think you have a cluster account so I can run it for us. 

I'll make a folder and everything and update this document with the path name so that you can access it if you want!

### visualizing the runs
Using Tracer, you can visualize the runs to look at MCMC convergence and ESS values (which is a measure of how many independent samples are extracted from the MCMC chain. As a heuristic, you want an ESS of at least 100 for the parameters you're most interested in.)

### Analysis 

_we'll go over all this when I get back!_

You can make an MCC tree, which is a summary version of the posterior set of trees that BEAST output as a `.trees` file using the application TreeAnnotator, which should be part of the beast folder when you downloaded it. 

You can view the MCC tree via icytree.com

I have a really unruly notebook that is included here called `skyline_ne.ipynb` that I dont think you'll need but I'll work on updating it so that it's clean and annotate it if you need it. 

