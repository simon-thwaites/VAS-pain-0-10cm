# VAS-pain-0-10cm
R-Shiny app for a 0-10cm visual analogue scale (VAS) score for knee pain. Electronic VAS scoring is well described (see References).

Working on RStudio Version 1.3.959
R Base Package 4.0.0

Required Libraries: 
- shiny
- shinyjs
- googlesheets4

## Use
- Writes to a Googlesheet so Google account required.
- You will be prompted to login via your web browser at first use, and to confirm this with a "1" in the RStudio console, after using the app. 
- Must have initalised a Googlesheet with the following 3 columns headers:


| studyID | VASscore | Date |
|---------|----------|------|

- paste yor sheet's URL into `vasSheetUrl`:

```
vasSheetUrl <- "your_sheet_URL"
```

- Researcher to input studyID, participant to use input slider to select VAS pain.
- If studyID is not empty, `Confirm` button will be enabled.
- If `Confirm` button is pressed, `Submit` button will be enabled.
- Any changes to studyID or input slider will disable `Submit` button.
- Changes must be re-confirmed before submitting.
- Each `Submit` will append the displayed table values to a new row.

## References
- Delgado DA, Lambert BS, Boutris N, et al. Validation of Digital Visual Analog Scale Pain Scoring With a Traditional Paper-based Visual Analog Scale in Adults. JAAOS Global Research & Reviews 2018;2(3)
- Kos D, Raeymaekers J, Van Remoortel A, et al. Electronic visual analogue scales for pain, fatigue, anxiety and quality of life in people with multiple sclerosis using smartphone and tablet: a reliability and feasibility study. Clinical rehabilitation 2017;31(9):1215-25. doi: 10.1177/0269215517692641
- Haefeli M, Elfering A. Pain assessment. Eur Spine J 2006;15 Suppl 1(Suppl 1):S17-S24. doi: 10.1007/s00586-005-1044-x [published Online First: 2005/12/01]
- Bird M-L, Callisaya ML, Cannell J, et al. Accuracy, Validity, and Reliability of an Electronic Visual Analog Scale for Pain on a Touch Screen Tablet in Healthy Older Adults: A Clinical Trial. Interact J Med Res 2016;5(1):e3-e3. doi: 10.2196/ijmr.4910

## Author
Simon Thwaites July 2020

simon.thwaites@adelaide.edu.au

simon.thwaites.biomech@gmail.com
