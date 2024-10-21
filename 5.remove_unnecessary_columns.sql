-- 4. remove any columns and rows we really dont need 
-- remove records with null values for both total_laid_off and percentage_laid_off
DELETE FROM layoffs_new WHERE total_laid_off IS NULL AND percentage_laid_off IS NULL;
SELECT * FROM layoffs_new;

-- remove row_num column we created
ALTER TABLE layoffs_new DROP COLUMN row_num;
SELECT COUNT(*) FROM layoffs_new;
SELECT * FROM layoffs_new;

################################################################################