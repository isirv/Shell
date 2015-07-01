#bin/bash

#文件同步
rsync -avz --exclude '.git/' --exclude 'config/' --exclude '.gitignore' --exclude 'README.md'  --exclude 'access.log' --exclude 'error.log' --exclude '.DS_Store' --exclude 'config.js' --exclude 'npm-debug.log' --exclude 'log/'  --delete --password-file=/tmp/rsyncd.secrets /Users/space/WorkSpace/www/LyWebNode root@182.92.189.177::node
