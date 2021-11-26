git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git /data/repos/linux
cd linux
git log --all --numstat -M -C --full-history --pretty=tformat:"STARTOFTHECOMMIT:linux%n%H;%T;%P;%an;%ae;%at;%cn;%ce;%ct;%s%n%b%nNOTES%N" | gzip > /data/repos/linux.log.gz
gunzip -c /data/repos/linux.log.gz | perl bin/extrgitPlog.perl | gzip > /data/repos/linux.delta.gz