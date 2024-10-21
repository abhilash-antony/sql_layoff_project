-- 2. Standardize Data

-- remove white spaces from the column company
UPDATE layoffs_new SET company = TRIM(company);

-- if we look at industry it looks like we have some null and empty rows, let's take a look at these
SELECT DISTINCT industry FROM layoffs_new ORDER BY industry;

-- crypto, crypto currency and cryptocurrency are the same
SELECT * FROM layoffs_new WHERE industry LIKE 'Crypto%';

-- make them all 'Crypto'
UPDATE layoffs_new SET industry = 'Crypto' WHERE industry LIKE 'Crypto%';

-- also there are empty spaces, converting them to NULL
UPDATE layoffs_new SET industry = NULL WHERE industry = '';
SELECT DISTINCT industry FROM layoffs_new ORDER BY industry;
-- redundant industries and empty spaces are removed

-- look at the location column
SELECT DISTINCT location FROM layoffs_new ORDER BY location; -- no issue

-- look at country
SELECT DISTINCT country FROM layoffs_new ORDER BY country;

-- wee see that there are two United States where one has a period at the end
SELECT company, country FROM layoffs_new WHERE country LIKE 'United States.'; -- 4 errorrs

-- remove the trailing period from them
UPDATE layoffs_new SET country = 'United States' WHERE country LIKE 'United States%';

-- date column is in text datatype; need to convert date from text to date
SELECT `date` FROM layoffs_new;
SELECT `date`, STR_TO_DATE(`date`, '%m/%d/%Y') as `datetime` FROM layoffs_new;

-- change values in date column to a format of date
UPDATE layoffs_new SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');
SELECT `date` FROM layoffs_new;

-- but though it is in date format, it is still text, so now need to convert to date datatype
ALTER TABLE layoffs_new MODIFY COLUMN `date` DATE;

################################################################################