DROP DATABASE layoff_DB;
CREATE DATABASE layoff_DB;
USE layoff_DB;

-- https://www.kaggle.com/datasets/swaptr/layoffs-2022
-- import the data
SELECT * FROM layoffs LIMIT 10;


/* first thing we want to do is create a staging table.
This is the one we will work on and clean the data. 
We need to preserve the raw data in case something happens */
CREATE TABLE layoffs_copy LIKE layoffs;
INSERT INTO layoffs_copy SELECT * FROM layoffs;
SELECT * FROM layoffs_copy;

-- now when we are data cleaning we usually follow a few steps
-- 1. check for duplicates and remove any
-- 2. standardize data and fix errors
-- 3. Look at null values and see what 
-- 4. remove any columns and rows that are not necessary

################################################################################