cat <<__EOT__
$1ディレクトリに以下のテンプレートファイルをコピーします！
.github/ISSUE_TEMPLATE.md
.github/PULL_REQUEST_TEMPLATE.md
.commit_template
__EOT__

cp -r .github $1
cp .commit_template $1
cp .gitignore $1
# emoji prefix
cd $1
git config commit.template .commit_template
