-- Data Cleaning using MySQL inspired by Alex the Analyst Data Cleaning course.

-- Updating/removing NULL values by finding the connection with another column
UPDATE a 
SET a.PropertyAddress = IFNULL(a.PropertyAddress, b.PropertyAddress) 
FROM NashvilleHousing a
JOIN NashvilleHousing b ON a.ParcelID = b.ParcelID
WHERE a.PropertyAddress IS NULL;

-- Removing time from date
UPDATE NashvilleHousing
SET SaleDate CONVERT(Date, SaleDate); 

-- Extract address into individual columns (address, city)
-- Create new columns:
ALTER TABLE NashvilleHousing
ADD Address VARCHAR AFTER PropertyAddress;

ALTER TABLE NashvilleHousing
ADD City VARCHAR AFTER Address;

-- Extraction:
SELECT SUBSTRING(PropertyAddress, 1, INSTR(PropertyAddress, ':') - 1) as Address, 
SUBSTRING(PropertyAddress, INSTR(PropertyAddress, ':') + 1, CHAR_LENGTH(PropertyAddress)) as City
FROM NashvilleHousing

UPDATE NashvilleHousing
SET Address = SUBSTRING(PropertyAddress, 1, INSTR(PropertyAddress, ':') - 1);

UPDATE NashvilleHousing
SET City = SUBSTRING(PropertyAddress, INSTR(PropertyAddress, ':') + 1, CHAR_LENGTH(PropertyAddress)) as City

