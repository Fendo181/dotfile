cat <<__EOT__
[$1]に以下のテンプレートファイルをコピーします！
.github/ISSUE_TEMPLATE.md
.github/PULL_REQUEST_TEMPLATE.md
.commit_template
__EOT__

cp -r .github $1
cp .commit_template $1
if [ -f $1/.gitignore ]; then
  echo "すでに存在しているので、.gitignoreはコピーしません"
  echo ".commit_templateを追記して下さい"
else
  echo ".gitignore"
  cp .gitignore $1
fi
# emoji prefix
cd $1
git config commit.template .commit_template
