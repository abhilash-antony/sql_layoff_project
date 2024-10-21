-- 1. Remove Duplicates
SELECT * FROM layoffs_copy;

-- get the count of duplicated rows.
SELECT company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) AS row_num
	FROM 
		layoffs_copy; -- date is in backticks because date is a keyword

-- look for rows that has repeated (more than once)
SELECT * FROM (
	SELECT company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) AS row_num
	FROM 
		layoffs_copy
) duplicates WHERE row_num > 1; 
    
-- CONFIRM
SELECT * FROM layoffs WHERE company = 'Casper'; -- two rows are duplicate of each other

-- these are the records we want to delete - where the row_num is > 1 

/* one solution is to create a new column and add those row numbers in. 
Then delete where row numbers are over 2, then delete that column 
Lets create a new table and do the same in the new table*/

CREATE TABLE `layoffs_new` (
`company` text, `location`text, `industry`text, `total_laid_off` INT,
`percentage_laid_off` text, `date` text, `stage`text, `country` text,
`funds_raised_millions` int, row_num INT -- include 'row_num' column besides existing ones
);

-- insert the values
INSERT INTO `layoffs_new`
(`company`, `location`, `industry`, `total_laid_off`, `percentage_laid_off`,
`date`, `stage`, `country`, `funds_raised_millions`, `row_num`)
SELECT 
`company`, `location`, `industry`, `total_laid_off`, `percentage_laid_off`,
`date`, `stage`, `country`, `funds_raised_millions`,
		ROW_NUMBER() OVER (
			PARTITION BY company, location, industry, total_laid_off,percentage_laid_off,`date`, stage, country, funds_raised_millions
			) AS row_num
FROM layoffs_copy;

SELECT * FROM layoffs_new;

-- turn off SAFE mode
SET SQL_SAFE_UPDATES = 0;

-- now that we have this we can delete rows were row_num is greater than 2
DELETE FROM layoffs_new WHERE row_num >= 2;

SELECT * FROM layoffs_new WHERE row_num != 1; -- empty

SELECT count(*) as Number_of_Records FROM layoffs_new;
-- five duplicated records are removed and we are free from duplicates now

################################################################################