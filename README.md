# Hypertherm Scrap Reduction
Project for Hypertherm for the Thayer School of Engineering Data Analytics Project Lab course. 
Professor Geoffrey Parker 
Spring Term 2024
Team Members: Kishore Kumaran, Vibha Visvanathan Kamala, Roshni Govind, Pranav Dharmadhikari  
Project title: Reducing Carbon Emission by Minimizing Steel Waste

## Project background 

### Docs for the project
* [Final Presentation](https://drive.google.com/file/d/1ZOuMiVnZNY-P22lvO5lX4LpsUD0mofU_/view?usp=drive_link)
* Ask me directly for other docs at kishore.kumaran.gr@dartmouth.edu or kishore.kumaran04@gmail.com

### Sample slides that convey the project
See some of the most important sample slides from our presentation

![Reducing Carbon Emission by Minimizing Steel Waste-images-0](https://github.com/kishorekumaran04/hypertherm_scrap_reduction/assets/30934994/8216286a-2d3b-4646-a433-1deceef16c88)

![Reducing Carbon Emission by Minimizing Steel Waste-images-2](https://github.com/kishorekumaran04/hypertherm_scrap_reduction/assets/30934994/99cc6371-47a5-40a2-8b2b-a35522c731c4)


![Reducing Carbon Emission by Minimizing Steel Waste-images-4](https://github.com/kishorekumaran04/hypertherm_scrap_reduction/assets/30934994/fe3d7249-d972-4e68-8483-d879c80edc5f)

![Reducing Carbon Emission by Minimizing Steel Waste-images-5](https://github.com/kishorekumaran04/hypertherm_scrap_reduction/assets/30934994/cefbbbd1-57e6-4563-8920-2aae062f6c64)

![Reducing Carbon Emission by Minimizing Steel Waste-images-11](https://github.com/kishorekumaran04/hypertherm_scrap_reduction/assets/30934994/053ed5dd-01e9-4675-8365-c8221844fa33)

![Reducing Carbon Emission by Minimizing Steel Waste-images-13](https://github.com/kishorekumaran04/hypertherm_scrap_reduction/assets/30934994/5715601d-2fa6-4010-8a75-bf1eacd79c9e)

![Reducing Carbon Emission by Minimizing Steel Waste-images-16](https://github.com/kishorekumaran04/hypertherm_scrap_reduction/assets/30934994/c9102e60-cfba-47fc-9c3f-d03df9625773)

![Reducing Carbon Emission by Minimizing Steel Waste-images-19](https://github.com/kishorekumaran04/hypertherm_scrap_reduction/assets/30934994/2e65a6e4-6e6c-4214-a527-4a8e7784a644)

![Reducing Carbon Emission by Minimizing Steel Waste-images-21](https://github.com/kishorekumaran04/hypertherm_scrap_reduction/assets/30934994/e6dc9cba-dd8e-4e0e-b04b-15706b7753f6)

![Reducing Carbon Emission by Minimizing Steel Waste-images-22](https://github.com/kishorekumaran04/hypertherm_scrap_reduction/assets/30934994/184a1b78-4e87-4bcc-8392-b393946cfc06)

![Reducing Carbon Emission by Minimizing Steel Waste-images-23](https://github.com/kishorekumaran04/hypertherm_scrap_reduction/assets/30934994/0cc9f813-e3a8-468e-aad5-15c7b79560c6)

![Reducing Carbon Emission by Minimizing Steel Waste-images-26](https://github.com/kishorekumaran04/hypertherm_scrap_reduction/assets/30934994/280897ab-d6dd-4304-8fca-0470a6750718)


### Hypertherm
Hypertherm was founded in 1968 and is headquartered in Hanover, NH. It has around 2,000 employees and is a 100% employee-owned company. The company has a strong global presence with operations and partner representation across several continents. It is a leading manufacturer of industrial cutting systems and software solutions. The company specializes in producing advanced plasma, laser, and waterjet cutting technologies, which are used in a variety of industries, from manufacturing to shipbuilding. Their innovative, diverse product portfolio of advanced tools and software help businesses precisely cut and shape materials for their specific needs, resulting in higher productivity, better product quality, and reduced operating costs. By integrating advanced cutting technologies with intelligent software solutions, Hypertherm helps businesses efficiently cut and shape steel, ultimately saving time, money, and resources.

### Project goals & scope 
The overarching purpose of this project is to reduce the environmental impact of steel sheet cutting through the prediction of the best nesting algorithm for a particular combination of parts. Hypertherm currently has multiple nesting algorithms which performs well for different combination of parts but no way to determine which algorithm excels at any given combination of parts to be nested. Thus, customers select algorithms based on intuition and habit and if the algorithm gives a 'good enough' efficiency, the customer proceeds with the metal cutting. In this project, we plan to use Hypertherm’s CEIP (Customer Experience Improvement Program) dataset to analyze the relationship between part features, nesting features, and nesting algorithms. Ultimately, we aim to use the features in this data to predict which combination of parts and algorithms maximizes utilization. 

## Database Info

* Unique values (number of unique jobs)
* dbo.Part - 2637599 - 2.6 million
* dbo.Nest - 3688620 - 3.7 million
* dbo.AutoNest - 865559 - 865 thousand 

### Details on selection of data from the SQL database

SELECT COUNT(*) FROM dbo.Part => 30,970,284 rows 
SELECT COUNT(*) FROM dbo.Nest => 8,711,803 rows 
SELECT COUNT(*) FROM dbo.AutoNest => 1,911,518 rows 
NUMBER OF DISTINCT JOBS: 
SELECT COUNT(DISTINCT ixJobSummary) AS JobCount FROM dbo.Part => 2,637,599 jobs 
SELECT COUNT(DISTINCT ixJobSummary) AS JobCount FROM dbo.Nest => 3,688,620 jobs 
NUMBER OF JOBS SHARED BETWEEN dbo.NEST & dbo.Part => 2,537,550 
Jobs in dbo.Part but not in dbo.Nest => 49 
Jobs in dbo.Nest but not in dbo.Part => 1,051,070 

## Tasks 

## Data Cleaning 
* The `Data Cleaning` folder contains the SQL scripts and commands used to select do analysis on the dataset for the project. 
* `Data Cleaning/data_cleaning.sql` - final SQL script used to produce the cleaned data. 

## Results
* Data cleaning 
* Documentation of the database, the task, and the process 
* Explanation of the project and why it's important 
* Verification of LCAs - based on the utilization numbers in the database, analyze how much money, steel, and carbon emissions could be prevented by increasing utilization. Give the environmental context and explain how this would help Hypertherm achieve its sustainability goals. If possible, give specifics - e.g. if utilization was increased by 10% across the board, what would that give Hypertherm? What strategies or changes could increase utilization like this? 
* Proof that ML/DL is a productive approach 
* Our well-documented, well-commented code in a Github
* Exploratory data analysis 
* Data visualizations 
* Machine learning model initial results 
* Recommendations for what data might be needed in the future
* Impact articulation and ensuring that this project is applied within the organization for emissions reduction & steel saving 
