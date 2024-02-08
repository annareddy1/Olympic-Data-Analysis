/*******************************************/
/*  Group Project. Final Report	   */
/*******************************************/

/* create a libname for my own created folder */
LIBNAME mylib "~/STAT5740HW";

/*******************************************/
/*  1. Create the Analysis Dataset		   */
/*******************************************/

/* Reading and importing data from the CSV file into the mylib.athlete_events dataset */
/* Deleting observations with missing values in Age, Weight, or Height */
Data mylib.athlete_events;
INFILE '/home/u62134436/STAT5740HW/athlete_events.csv' DLM=',' DSD MISSOVER;
    INPUT ID Name $ Sex $ Age Height Weight Team $
          NOC $ Games $ Year $ Season $ City $ Sport $ Event $ Medal $;
IF (Age="" OR Weight="" OR Height="") THEN DELETE;
RUN;

/* Creating additional variables: Medal_Num, Age_Category, BMI, BMI_Category*/
data mylib.athlete_events_analyzed;
    set mylib.athlete_events;
    
    IF Medal ~= "NA" THEN Medal_Num = 1; ELSE Medal_Num = 0;
    
    /* Create age categories */
    IF Age < 20 then Age_Category = 'Under 20';
    ELSE IF Age >= 20 and Age < 30 then Age_Category = '20-29';
    ELSE IF Age >= 30 and Age < 40 then Age_Category = '30-39';
    ELSE IF Age >= 40 then Age_Category = '40 and above';
    
    BMI = Weight / ((Height/100) ** 2);
    /* Create BMI categories */
    IF BMI < 18.5 then BMI_Category = 'Underweight';
    ELSE IF BMI >= 18.5 and BMI < 24.9 THEN BMI_Category = 'Normal';
    ELSE IF BMI >= 25 and BMI < 29.9 THEN BMI_Category = 'Overweight';
    ELSE IF BMI >= 30 THEN BMI_Category = 'Obese';
    
RUN;

/* Displaying variable information for mylib.athlete_events dataset */
ODS PDF FILE="/home/u62134436/STAT5740HW/Group_Contents_0.pdf";
TITLE "Question 0: Contents of Complete Data Set Ready For Analysis";
TITLE2 "Group 20:  Rithika Annareddy";
PROC CONTENTS DATA=mylib.athlete_events_analyzed VARNUM;
RUN;
ODS PDF CLOSE;

/* Specific question: Can age and BMI be used to predict the chances of winning a medal? */
/* Variables to Include:
    1) Team: Team of the athlete
    2) Sport: Sport of the athlete
    3) Name: Name of the athlete
    4) Age: Age of the athlete
    5) Age_Category: Category variable to categorize the age of the athlete.
    6) BMI: BMI of the category
    7) BMI_Category: Category variable to categorize the BMI of the athlete.
    8) Medal_Num: indicator variable to show if a medal has been won
*/ 
PROC SQL;
   CREATE TABLE DominantAthletes AS
   SELECT
      Team,
      Sport,
      Name,
      Medal_num,
      SUM(Medal_num) AS total_won,
      Age,
      Age_Category,
      BMI,
      BMI_Category,
      year
   FROM
      mylib.athlete_events_analyzed
   GROUP BY
      Age_Category, BMI_Category
   ORDER BY
      total_won desc;
QUIT;

/*******************************************/
/*  3. Create Table One					   */
/*******************************************/

/* Summary Statistics table for Age, BMI, and Medal Wins by Age and BMI Categories*/
ODS PDF FILE="/home/u62134436/STAT5740HW/MyResults/Group_Summary.pdf";
TITLE "Question 3: Summary Table";
TITLE2 "Summary Statistics for Age, BMI, and Medal Wins by Age and BMI Categories";
PROC MEANS DATA=DominantAthletes N MEAN SUM;
   CLASS Age_Category BMI_Category;
   VAR Age BMI Medal_num;
RUN;
ODS PDF CLOSE;

/* Regression Analysis for Age, BMI as independent variables and total_won as dependent*/
ODS PDF FILE="/home/u62134436/STAT5740HW/MyResults/Group_RegAnanlysis.pdf";
TITLE "Question 3: Regression Analysis";
TITLE2 "Regression Analysis for Age, BMI as independent variables and total_won as dependent";
PROC REG DATA=DominantAthletes;
	MODEL total_won = BMI Age;
RUN;
ODS PDF CLOSE;

/*******************************************/
/*  4. Create Graphics					   */
/*******************************************/

/* Set the output location and image properties for the graph */
/* Create a vertical box plot to visualize total medals won based on Age and BMI categories */
/* Scatter plot with transparency to show the distribution of total medals won */

ODS LISTING GPATH="/home/u62134436/STAT5740HW/MyResults" IMAGE_DPI=300;
ODS GRAPHICS / RESET IMAGENAME="ProblemSpecificQuestion2" OUTPUTFMT=PNG
		HEIGHT=3in WIDTH=3in;
TITLE "Question 4: Chances of Winning a Medal Based on Age and BMI";
PROC SGPLOT DATA=DominantAthletes;
	VBOX total_won / CATEGORY=Age_Category GROUP=BMI_Category TRANSPARENCY=0.6;
	XAXIS LABEL="Age Category";
    YAXIS LABEL="Total Medals Won";
RUN;
ODS LISTING CLOSE;

/*******************************************/
/*  5. Preliminary Analysis				   */
/*******************************************/

/* How does the expected total number of wins depend on the Age AND BMI */
/* Performed a formal regression analysis with total_won as dependent, Age and BMI as independent variables */ 
	
/* Main Effects Only */

ODS LISTING GPATH="/home/u62134436/STAT5740HW/MyResults" IMAGE_DPI=300;
ODS GRAPHICS / RESET IMAGENAME="ProblemSpecificQuestion_main" OUTPUTFMT=PNG
		HEIGHT=3in WIDTH=3in;
TITLE "Question 5: Total Wins Prediction: Main Effects of Age and BMI";
PROC REG DATA=DominantAthletes PLOTS(MAXPOINTS=None)= RESIDUALS;
   MODEL total_won = Age BMI;
RUN;
ODS LISTING CLOSE;

/* Performed a formal regression analysis with total_won as dependent, Age and BMI as independent variables */ 
/* Included the Interaction variable Age*BMI as well in regresiion analysis */
/* Interaction Effect */

DATA DominantAthletes;
	SET DominantAthletes;
	Age_times_BMI = Age*BMI;
RUN;

ODS LISTING GPATH="/home/u62134436/STAT5740HW/MyResults" IMAGE_DPI=300;
ODS GRAPHICS / RESET IMAGENAME="ProblemSpecificQuestion_interaction" OUTPUTFMT=PNG
		HEIGHT=3in WIDTH=3in;
TITLE "Question 5: Total Wins Prediction: Interaction of Age and BMI";
PROC GLM DATA=DominantAthletes PLOTS(MAXPOINTS=None)= RESIDUALS;
	MODEL total_won = Age BMI Age_times_BMI;
RUN; 
ODS LISTING CLOSE;