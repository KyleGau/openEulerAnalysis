git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux
cd linux
git log --all --numstat -M -C --full-history --pretty=tformat:"STARTOFTHECOMMIT:linux%n%H;%T;%P;%an;%ae;%at;%cn;%ce;%ct;%s%n%b%nNOTES%N" | gzip > ../data/linux.log.gz
gunzip -c data/linux.log.gz | perl bin/extrgitPlog.perl | gzip > data/linux.delta.gz