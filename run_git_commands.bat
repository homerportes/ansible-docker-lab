@echo off
echo === Step 1: Git Status ===
git --no-pager status
echo.
echo === Step 2: Git Add ===
git add -A
echo.
echo === Step 3: Git Commit ===
git commit -m "Update README with images"
echo.
echo === Step 4: Git Push ===
git push origin
if %ERRORLEVEL% EQU 128 (
    echo.
    echo === Push failed with upstream error, running recovery commands ===
    echo === Step 5: Setting upstream branch ===
    git branch -u origin/main 2>nul || git branch -u origin/master
    echo.
    echo === Step 6: Git Push (retry) ===
    git push origin
)
