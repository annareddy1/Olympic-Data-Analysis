# SAS-Olympic-Data-Analysis
This report explores the historical dataset of the modern Olympic Games, including games from Athens 1896 to Rio 2016. These Olympic Games are global sporting events held every four years that bring together athletes from diverse nations to highlight their talents internationally. In the report, we investigate each participant's characteristics to determine an athlete's performance and success. Examining the athlete pool may provide key insight into what characteristics determine the winners. This study aims to determine whether an athletes’ characteristics may relate to the chances of winning a medal; if yes, what characteristics may relate to the chance of winning a medal.

### Sources
The dataset includes historical information on the Olympic games from Athens 1896 to Rio 2016. The data is scraped from www.sports-reference.com, it was a result of an incredible amount of research by a group of Olympic history enthusiasts and self-proclaimed 'statisticians'. 

### Variables
<img src="/B8921748-7CE2-4451-9D62-278FCEC8F955_4_5005_c.jpeg" width="200" height="300">

In our study, we focus on the variables Team, Sport, Name, Medal_num, total_won, Age, Age_Category, BMI, BMI_Category, year. A binary variable (Medal_num) was created for medals won to indicate whether a medal had been won (1) or lost (0). Variables were also created to contain values for sum of medals won (total_won), age categories (Age_Category), BMI using weight and height (BMI), and BMI Category (BMI_Category) respectively. Age is recorded in years and BMI is recorded in kilogram/meter^2. Age_Category is created from Age. The Age_Category are 20-29, 30-39, 40 and above, and under 20. BMI_Category is created from BMI. The BMI_Category are Normal, Obese, Overweight, and Underweight.

### Summary
<img src="/0E98E3EC-3D0D-4E51-BE62-866309903BBB.jpeg" width="400" height="500">

The data set including duplicate athlete names contains 206165 entries. There are 17 variables in the dataset and their characteristics are summarized in the first table above. From the Q1: Summary table, we can see that 20-29 Age_Category and Normal BMI have the highest medal wins while Under 20 Age_Category and Obese BMI have the lowest medal wins.

### Specific Question

#### Methods
For the specific question, I aimed to assess whether age and BMI could serve as predictors for an athlete's likelihood of winning a medal. The relevant parameters included Team, Sport, Name, Age, Age_Category, BMI, BMI_Category, and Medal_Num. The null hypothesis assumed that age and BMI do not have a significant impact on winning a medal, the alternative hypothesis assumed a significant relationship between age and BMI. We used regression analysis, using the PROC REG procedure in SAS, to model the dependent variable 'total_won' against the independent variables Age and BMI. We will also check if interaction term is needed in similar fashion.

#### Results
<img src="/28C355AB-42DB-4B68-B6E1-57857CF740EA.jpeg" width="300" height="300">

<img src="/602208E4-9CBC-476F-9489-ADAD0BCF2021.jpeg" width="300" height="300">

<img src="/CBA9634A-B4D7-4AE0-98C3-55C4822D5CC1.jpeg" width="300" height="300">

<img src="/C2772F4E-C279-4D53-8170-64DCC5F50CC6.jpeg" width="300" height="300">

<img src="/D17A2474-7032-45EE-AE20-C55609F1F070.jpeg" width="300" height="300">

The results revealed a significant relationship between Age, BMI, and the chances of winning a medal. The scatter plot illustrated a clear trend, indicating that athletes with certain age and BMI categories had higher chances of winning medals. The regression analysis further supported these findings, with both Age and BMI showing statistically significant coefficients with p values less than 0.01. Athletes in specific age and BMI categories demonstrated variations in their total medal wins. The r squared with interaction term is 0.1 and the r squared with main effects only is 0.08. If the model with the interaction term has a higher r squared, it suggests that including interactions improves the model's ability to
explain the variance in the dependent variable but only slightly.

### Discussion
In summary, the analysis suggests that age and BMI have an influence in predicting an athlete's success in winning medals. However, it is crucial to acknowledge the limitations of the regression analysis, such as assumption that residuals are independent, possibility of outliers, and assumptions associated with regression analysis such as if the relationship is nonlinear, it cannot identify the relationship. The findings contribute valuable insights into the factors influencing athletic success.

# References
Heesoo37. "120 Years of Olympic History: Athletes and Results". Kaggle dataset (2018). https://www.kaggle.com/datasets/heesoo37/120-years-of-olympic-history-athletes-and-results

