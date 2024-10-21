# Layoffs Data Analysis and Cleaning Report Using SQL

## Introduction
This report presents the analysis and data cleaning process for a layoff dataset sourced from Kaggle. The aim is to ensure accurate insights through rigorous data preparation and exploration. The dataset contains key columns such as `company`, `industry`, `country`, `total_laid_off`, and `percentage_laid_off`. By cleaning and exploring the data, we aim to uncover trends and key metrics related to layoffs across various industries and regions.

## Data Loading and Staging

### Importing the Dataset
The dataset was imported into MySQL Workbench using the Table Data Import Wizard. This step loaded the raw data into a staging table, which was essential for maintaining a clean and accurate analysis environment.

### Creation of a Staging Table
A staging table was created to preserve the raw dataset before beginning the data-cleaning process. This ensured that the original data was kept intact for future reference or validation.

## Data Cleaning Process

### Removal of Duplicates
Removing duplicates is a crucial step in maintaining the accuracy of the dataset. Duplicates were flagged using a row numbering strategy, and any records that appeared more than once were removed. This process ensured that the data used for analysis was free of repetitive information, which could have skewed results.

### Standardization of Data
Data standardization involved cleaning specific columns:
- **Company Column**: Removed extra spaces to ensure consistency.
- **Industry Column**: Merged similar terms to avoid fragmentation, for example, combining variations of "Crypto" into a single term.
- **Country Column**: Cleaned to ensure uniformity, removing punctuation and standardizing country names.
- **Date Column**: Converted from text format to the proper `DATE` data type for easier temporal analysis.

### Handling Null Values
Null values were addressed to maintain the completeness of the dataset:
- **Industry Column**: Missing values were filled using existing data based on the company-level information.
- **Total Laid Off**: Records with missing data in both `total_laid_off` and `percentage_laid_off` columns were deleted to avoid incomplete entries affecting the analysis.

## Data Exploration and Trend Analysis

### Key Metrics and Trends
The exploration phase uncovered key metrics such as:
- **Maximum Layoffs**: The largest layoffs recorded in a single event.
- **Percentage Layoffs**: Identifying companies that laid off 100% of their workforce.
- **Companies That Ceased Operations**: Analyzing which companies completely ceased operations based on their percentage layoffs.
- **Impact of Funds Raised**: Exploring how companies with significant funding were affected by layoffs.

### Geographic and Temporal Trends
The analysis revealed geographic and temporal trends, including:
- **Layoffs by Country**: Identified the distribution of layoffs across various countries.
- **Yearly Trends**: Observed yearly patterns in layoffs and pinpointed peaks during significant economic periods.
- **Monthly Trends**: Broke down layoffs by month to detect any recurring patterns over time.

### Industry Analysis
A deeper look into industry trends showed:
- **Most Affected Industries**: Industries that were hit hardest by layoffs, with detailed breakdowns by company stage (e.g., startups versus established companies).
- **Layoffs by Company Stage**: Exploring how layoffs differed between early-stage companies and more established businesses.

## Advanced Trend Exploration

### Rolling Totals
Rolling totals were calculated to visualize how layoffs evolved over time. These metrics provided insights into the cumulative effect of layoffs, giving a clearer picture of the workforce reduction over extended periods.

### Company-Level Analysis
A detailed company-level analysis ranked organizations by the number of layoffs. The ranking helped identify which companies were most affected each year, using advanced ranking functions.

## Key Insights and Findings
The key findings of the analysis highlighted:
- Significant layoffs across specific industries such as technology and finance.
- Geographic regions most affected by layoffs, with countries like the United States seeing a high concentration of layoffs.
- A notable increase in layoffs during certain years, particularly in response to global economic downturns or crises.
  
These insights offer value to businesses, policymakers, and stakeholders, helping them understand layoff trends and take informed actions to mitigate future risks.

## Conclusion
This project involved cleaning, transforming, and analyzing a layoffs dataset to provide a clearer picture of global workforce reductions. The data cleaning process—removing duplicates, standardizing values, and handling null data—was essential for ensuring accurate analysis. Key trends in layoffs were identified, offering valuable insights for businesses and policymakers alike. Future analyses could incorporate additional datasets or focus on more granular trends in specific regions and industries, further enhancing the understanding of layoff dynamics.
