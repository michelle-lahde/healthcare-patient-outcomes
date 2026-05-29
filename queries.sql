-- 1. Fix inconsistent name upper and lower casing
SET SQL_SAFE_UPDATES = 0;

UPDATE healthcare_dataset
SET Name = CONCAT(
  UPPER(LEFT(Name, 1)),
  LOWER(SUBSTRING(Name, 2, LOCATE(' ', Name) - 2)),
  ' ',
  UPPER(SUBSTRING(Name, LOCATE(' ', Name) + 1, 1)),
  LOWER(SUBSTRING(Name, LOCATE(' ', Name) + 2))
);

SET SQL_SAFE_UPDATES = 1;

-- 2. Patient count by medical condition
SELECT 
  `Medical Condition`, 
  COUNT(*) AS Patient_Count
FROM healthcare_dataset
GROUP BY `Medical Condition`
ORDER BY Patient_Count DESC;

-- 3. Average billing by admission type
SELECT 
  `Admission Type`,
  ROUND(AVG(`Billing Amount`), 2) AS Avg_Billing
FROM healthcare_dataset
GROUP BY `Admission Type`
ORDER BY Avg_Billing DESC;

-- 4. Average length of stay by condition
SELECT 
  `Medical Condition`,
  ROUND(AVG(DATEDIFF(`Discharge Date`, `Date of Admission`)), 1) AS Avg_Stay_Days
FROM healthcare_dataset
GROUP BY `Medical Condition`
ORDER BY Avg_Stay_Days DESC;

-- 5. Test result breakdown by condition
SELECT 
  `Medical Condition`,
  `Test Results`,
  COUNT(*) AS Count
FROM healthcare_dataset
GROUP BY `Medical Condition`, `Test Results`
ORDER BY `Medical Condition`, Count DESC;

-- 6. Average billing by insurance provider
SELECT 
  `Insurance Provider`,
  ROUND(AVG(`Billing Amount`), 2) AS Avg_Billing,
  COUNT(*) AS Patient_Count
FROM healthcare_dataset
GROUP BY `Insurance Provider`
ORDER BY Avg_Billing DESC;

-- 7. Average billing by medical condition
SELECT 
  `Medical Condition`,
  ROUND(AVG(`Billing Amount`), 2) AS Avg_Billing
FROM healthcare_dataset
GROUP BY `Medical Condition`
ORDER BY Avg_Billing DESC;
