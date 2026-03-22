@echo off
echo Adding changes...
git add .
echo Committing changes...
git commit -m "Update README with images"
echo Pushing to GitHub...
git push
if %errorlevel% neq 0 (
    echo Push failed. Trying to set upstream to main...
    git push --set-upstream origin main
)
if %errorlevel% neq 0 (
    echo Push failed. Trying to set upstream to master...
    git push --set-upstream origin master
)
echo Done.
pause