# hyperthermDAPL
Project for Hypertherm for the Thayer School of Engineering Data Analytics Project Lab course. 
Professor Geoffrey Parker 
Spring Term 2024
Team Members: Kishore Kumaran, Vibha Visvanathan Kamala, Roshni Govind, Pranav Dharmadhikari  
Project title: Reducing Carbon Emission by Minimizing Steel Waste

## Project background 

### Docs for the project
* [Final Presentation]([https://docs.google.com/presentation/d/1dStRV1ZOExTIJEzfsv0eXDAbw8WIKH-mX-2jgdKO9Rw/edit?usp=drive_link](https://drive.google.com/file/d/1ZOuMiVnZNY-P22lvO5lX4LpsUD0mofU_/view?usp=drive_link)) 
* Ask me directly for other docs at kishore.kumaran.gr@dartmouth.edu or kishore.kumaran04@gmail.com

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
