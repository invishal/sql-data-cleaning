
## Overview

This project focuses on cleaning and standardizing raw order data stored in the `orders_cleaned` table. The dataset initially contains issues such as duplicate records, missing values, inconsistent formats, and invalid entries.

The following SQL queries are used step-by-step to improve data quality and make the dataset ready for analysis.

---

##  Data Cleaning Steps

###  1. Rename Column

Renamed `customer_id` to `customer_name` for better clarity and consistency.

---

###  2. Detect Duplicate Records

Identified duplicate rows based on key fields like customer name, email, city, order date, and amount.

---

###  3. Remove Duplicate Records

Deleted duplicate entries while keeping the record with the minimum `order_id` for each group.

---

###  4. Identify Null Email Values

Filtered records where the `email` field is missing.

---

###  5. Handle Missing Emails

Replaced all NULL email values with a default placeholder (`unknow@gmail.com`).

---

###  6. Detect Invalid Emails

Identified emails that do not follow a valid format (missing `@` or domain).

---

###  7. Fix Invalid Email

Manually corrected specific invalid email entries.

---

###  8. Remove Extra Spaces (Customer Name)

Trimmed leading and trailing spaces from `customer_name`.

---

###  9. Fix City Name Errors

Corrected inconsistent city spellings (e.g., "Mum Bai" → "Mumbai").

---

###  10. Remove Extra Spaces (City)

Cleaned up extra spaces in the `city` column.

---

###  11–13. Standardize Date Formats

Converted different date formats into a consistent SQL DATE format:

* `yyyy-dd-mm`
* `mm-dd-yyyy`
* `dd-mm-yyyy`

Used `STR_TO_DATE()` function with regex filtering to correctly parse formats.

---

###  14. Identify Missing Dates

Detected records where `order_date` is NULL.

---

###  15. Handle Missing Dates

Replaced NULL dates with a default value (`2024-01-01`).

---

###  16. Fix Negative Amounts

Converted negative values in the `amount` column to positive using `ABS()`.

---

###  17. Handle Null Amounts

Replaced NULL values in `amount` with `0`.

---

###  18. Optimize Data Types

Modified column data types for better storage and performance:

* `order_id` → INT
* `customer_name` → VARCHAR(50)
* `email` → VARCHAR(50)
* `city` → VARCHAR(30)
* `order_date` → DATE
* `amount` → DECIMAL(10,2)

---

##  Final Outcome

After applying all transformations:

* Duplicate data is removed
* Missing values are handled
* Data formats are standardized
* Data types are optimized

The dataset is now clean, consistent, and ready for analysis or reporting.

