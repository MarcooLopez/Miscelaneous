
For running several jobs in the server, include a basic header as the below one in your R script

```
#!/usr/bin/env Rscript
# Time job will take to execute (HH:MM:SS format)
#PBS -l walltime=02:00:00
# Memory needed by the job
#PBS -l mem=20gb
# Make output and error files the same file
#PBS -j oe
# Give the job a name
#PBS -N prefix
#PBS -t 1-300
```

where the variable 't' will index the job number. 
Then you can indicate to your R script which job to run. For instance,

```
rm(list=ls())
job <- as.integer(Sys.getenv("PBS_ARRAYID"))
```

Integer variable 'job' can be used in your script to run a single indexed job (partition, cycle, iteration, etc).

Finally, you can submmit to run your R script just by typing in terminal 

```
qsub Rscript_name.R
```
