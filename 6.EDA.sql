/* Here we are jsut going to explore the data and find trends or patterns or anything interesting like outliers
normally when you start the EDA process you have some idea of what you're looking for
with this info we are just going to look around and see what we find!
the column 'total_laid_off' is more relevant than the column 'percentage _laid_off' */

SELECT * FROM layoffs_new;

-- max total laid off
SELECT MAX(total_laid_off) AS Max_Layoffs FROM layoffs_new; -- 12000

-- Looking at Percentage to see the range of these layoffs
SELECT MAX(percentage_laid_off),  MIN(percentage_laid_off)
FROM layoffs_new WHERE  percentage_laid_off IS NOT NULL; -- 1 means 100% means that company has winded up

-- Which companies had 1 which is basically 100 percent of they company laid off
SELECT * FROM layoffs_new WHERE  percentage_laid_off = 1;
-- looks like these all went out of business

-- largest compnay to shutdown
SELECT * FROM layoffs_new WHERE  percentage_laid_off = 1 ORDER BY total_laid_off DESC LIMIT 10; -- Katerra: 2434

-- if we order by funds_raised_millions we can see how big some of these companies were
SELECT * FROM layoffs_new WHERE  percentage_laid_off = 1
ORDER BY funds_raised_millions DESC LIMIT 10;

-- Companies with the biggest single Layoff on a single day
SELECT company, total_laid_off FROM layoffs_new ORDER BY 2 DESC LIMIT 5;

-- Companies with the most Total Layoffs
SELECT company, SUM(total_laid_off) as total_layoffs FROM layoffs_new 
GROUP BY company ORDER BY total_layoffs DESC LIMIT 5;

-- Date range
SELECT MIN(`date`) as `FROM`, MAX(`date`) AS `TO` FROM layoffs_new; -- Mar'20 to Mar'23
-- this is total in the past 3 years or in the dataset

-- layoffs by location
SELECT location, SUM(total_laid_off) FROM layoffs_new
GROUP BY location ORDER BY 2 DESC LIMIT 10;

-- layoffs by country
SELECT country, SUM(total_laid_off)
FROM layoffs_new GROUP BY country ORDER BY 2 DESC;

-- layoffs throughout the years
SELECT YEAR(date), SUM(total_laid_off) FROM layoffs_new 
WHERE `date` IS NOT NULL GROUP BY YEAR(date) ORDER BY 1 ASC;

-- layoffs throughout the months
SELECT MONTH(date), SUM(total_laid_off) FROM layoffs_new 
WHERE `date` IS NOT NULL GROUP BY MONTH(date) ORDER BY 1 ASC;

-- most affected industries
SELECT industry, SUM(total_laid_off)
FROM layoffs_new GROUP BY industry ORDER BY 2 DESC;

-- company's stage during the layoffs
SELECT stage, SUM(total_laid_off)
FROM layoffs_new GROUP BY stage ORDER BY 2 DESC;

-- layoffs in each months
SELECT SUBSTRING(`date`, 1, 7) AS `month`, SUM(total_laid_off) FROM layoffs_new 
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL GROUP BY `month` ORDER BY `month` ASC;

-- rolling total - like cumulative total - great for visualisation
WITH Rolling_Total AS (
SELECT SUBSTRING(`date`, 1, 7) AS `month`, SUM(total_laid_off) AS total_laid FROM layoffs_new 
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL GROUP BY `month` ORDER BY `month` ASC
)
SELECT `month`, total_laid, SUM(total_laid) 
OVER(ORDER BY `month`) AS rolling_total FROM Rolling_Total;
/* It shows a month by month progression. 
in 2020, it was 9600s, and by the end, we have 81000 layoffs
By 2021 end, we had 96800 layoffs, which means that the year 2021 was comparatively much better.
However, Things started changing dramatically in 2022, showing a high surge upto aroung 2.5 lakhs.
Besides this, the three months from 2023 is really devastating as is saw an increase of above 2 lakhs to get the total to the value close to 4 lakhs.
It has to be kept in mind that this is only the reported layoffs, the actual layoffs might go way beyond these numbers. */

-- lets look at Companies with the most Layoffs per year
SELECT company, SUM(total_laid_off) as total_layoffs FROM layoffs_new 
GROUP BY company ORDER BY total_layoffs DESC LIMIT 10; -- Companies with the most Total Layoffs

-- layoffs per year for all the companies
SELECT company, YEAR(`date`) AS years, SUM(total_laid_off) AS total_laid_off
FROM layoffs_new GROUP BY company, YEAR(`date`) ORDER BY company ASC;

-- ranking companies who laid off the most per year
WITH Company_Year (Company, Years, total_laid_off) AS 
(
  SELECT company, YEAR(`date`) AS years, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_new GROUP BY company, YEAR(`date`)
)
, Company_Year_Rank AS (
  SELECT company, years, total_laid_off, DENSE_RANK()
		OVER (
			PARTITION BY years ORDER BY total_laid_off DESC
		) AS ranking
  FROM Company_Year
)
SELECT company, years, total_laid_off, ranking FROM Company_Year_Rank
WHERE ranking <= 3 -- max 3 ranks
AND years IS NOT NULL ORDER BY years ASC, total_laid_off DESC;

#######################################################################################################