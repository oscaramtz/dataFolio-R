# Reproducible research checklist

## Do: Start with good science

- __REMEMBER__: garbage in, garbage out
- Coherent, focused questions simplifies many problems
- Working with good collaborators reinforces good practices
- Something that´s interesting to you will (hopefully) motivate good habits
- Keep track of your software environment 

```{R}
sessionInfo()
```

## Do: Teach a computer
- If something needs to be done as part of your analysis/investigation, try to teash your computer to do it (even if you only need to do it once))
- In order to give your computer instructions, you need to write down exactly what you mean to do and how it should be done
- Teaching a computer almost garantees reproducibility

## Do: Set your seed
- Random nu,ber generators generate pseudo-random numbers based on an initial seed (usually a number or set of numbers)
    - In R you can use tje set.seed() function to set the seed and to specify the random number generator to use
- Setting the seed allows for the stream of random numbers to be exactly reproducible
- Whenever you generate random numbers for a non-trivial purpose, __always set the seed__

## Do: Think about the entire pipeline
- data analysis is a lengthy process; it is not just tables / figures / reports
- Raw data -> processed data -> analysis -> report
- How you got end is just as important as the end itself
-the more of the data analysis pipeline you can make reproducible, the better for everyone

## Don't: do things by hand

- Editing spreadsheets of data to "clean it up"

    - Removing outliers
    - QA / QC
    - Validating
    
- Editing tables or figures (e.g rounding, formatting)
- Downloading data from a web site (clicking links a web brower)
- Moving data around your computer; spliting / reformatting data files
- "We, re just going to do this once..."
- Things done by hand need to be precisely documented (this is harder than it sounds)

## Don't Point and click
- Many data processing / statistical analysis packages have graphical user interfaces (GUIs)
- GUIs are convenient / intuitive but actions you take with GUI can be difficult for other to reproduce
- Some GUIs procuce a log file or script which includes equivalent commands; these can be sbed for later examination
- In General, be careful with data analysis software that is highly interactive; ease of use can sometimes lead to non-reproducible analyses
- Other interactive softwares, such as text editors, are usually fine

## Don't: Save output
- Avoid saving data analysis output (tables, figures, summaries, processed data, etc.) except perhaps temporarily for porpuses
- If a stray output file cannot be easily connected with the means by which it was created, then it is not reproducible
- Save the data + code that generated the output, rather than the output itself
- Intermediate files are okay as long as there is clear documentation of how ther were created






