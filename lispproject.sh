#!/bin/bash
# Check arguments
if (( $# != 2 ))
then
  echo "Usage: lispproject.sh name-of-project directory-within-which-project-directory-should-be-created"
  exit 1
fi

# Check if directory already exists
if [ -d "$2" ]; then
  # Control will enter here if $DIRECTORY exists.
    echo "Directory $2 exists already, leaving it alone."
else
  # Create directory
  mkdir -p $2
fi

cd $2

# Get the project template
git clone https://github.com/analyticd/lisp-project-template.git $1
cd $1

# Modify project template 
sed -i.old "s|lisp-project-template|$1|g" lisp-project-template.asd 
# Alternatively, if on old unix, use next three lines instead of above line.
# sed "s|lisp-project-template|$1|g" lisp-project-template.asd > tmp
# rm lisp-project-template.asd
# mv tmp lisp-project-template.asd
sed -i.old "s|lisp-project-template|$1|g" lisp-project-template-test.asd
# Alternatively, if on old unix, use next three lines instead of above line.
# sed "s|lisp-project-template|$1|g" lisp-project-template-test.asd > tmp
# rm lisp-project-template-test.asd
# mv tmp lisp-project-template-test.asd
mv README.org.template README.org
sed -i.old "s|lisp-project-template|$1|g" README.org
# Alternatively, if on old unix, use next three lines instead of above line.
# sed "s|lisp-project-template|$1|g" README.md > tmp
# rm README.md
# mv tmp README.md

cd src
sed -i.old "s|lisp-project-template|$1|g" package.lisp
# Alternatively, if on old unix, use next three lines instead of above line.
# sed "s|lisp-project-template|$1|g" package.lisp > tmp
# rm package.lisp
# mv tmp package.lisp
sed -i.old "s|lisp-project-template|$1|g" main.lisp 
# Alternatively, if on old unix, use next three lines instead of above line.
# sed "s|lisp-project-template|$1|g" main.lisp > tmp
# rm main.lisp
# mv tmp main.lisp
# Remove the temp files sed created
rm *.old

cd ..
# Remove the temp files sed created
rm *.old
cd test
sed -i.old "s|lisp-project-template|$1|g" package.lisp
# Alternatively, if on old unix, use next three lines instead of above line.
# sed "s|lisp-project-template|$1|g" package.lisp > tmp
# rm package.lisp
# mv tmp package.lisp
sed -i.old "s|lisp-project-template|$1|g" test.lisp 
# Alternatively, if on old unix, use next three lines instead of above line.
# sed "s|lisp-project-template|$1|g" test.lisp > tmp
# rm test.lisp
# mv tmp test.lisp

# Remove the temp files sed created
rm *.old
cd ..

# Change the file names to match the project name
mv lisp-project-template.asd $1.asd
mv lisp-project-template-test.asd $1-test.asd

# Get rid of .git repo from project template
rm -rf .git 
# Create a new git repo for this project
git init .

# Info
echo "Project located here:"
echo `pwd`
echo ""
echo "Files in project:"
echo ""
ls -l
