## 🔧 Example: Merging Two NetCDF Files

This is a real-case example that demonstrates merge output from two source NetCDF files into one.

### ⚠️ Issue Observed
After merging, variable values appear to be replaced with extremely large numbers—likely due to missing data being filled with default *fill values*.  

### 📦 Requirements

```
module load netcdf nco
```
