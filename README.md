https://backlogtool.com/git-guide/vn/
git config --global user.name "Nghia Nguyen"
git config --global user.email "nghia.nguyen.jg@rvc.renesas.com"

Create a new repository

git clone git@gitlab.rvc.renesas.com:nghianguyen/calc.git
cd calc
touch README.md
git add README.md
git commit -m "add README"
git push -u origin master

Existing folder or Git repository

cd existing_folder
git init
git remote add origin git@gitlab.rvc.renesas.com:nghianguyen/calc.git
git add .
git commit
git push -u origin master
