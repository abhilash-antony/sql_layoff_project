-- 3. Look at Null Values
SELECT * FROM layoffs_new WHERE industry IS NULL;
SELECT * FROM layoffs_new WHERE company LIKE 'airbnb%';
/* upon inspection, we see that airbnb is a travel, but one of them just isn't populated.
There can be others as well like this.
so, we write a query that if there is another row with the same company name, 
it will update it to the non-null industry values
makes it easy so if there were more, we wouldn't have to manually check them all */
UPDATE layoffs_new t1 JOIN layoffs_new t2 ON t1.company = t2.company
SET t1.industry = t2.industry WHERE t1.industry IS NULL AND t2.industry IS NOT NULL;

SELECT * FROM layoffs_new WHERE total_laid_off IS NULL;
SELECT * FROM layoffs_new WHERE percentage_laid_off IS NULL;
-- both of these columns has null values and it is not critical

-- however, if there are records with null values for both total_laid_off and percentage_laid_off, then it seems useless
SELECT * FROM layoffs_new WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;

################################################################################