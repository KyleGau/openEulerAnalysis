git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git /data/repos/linux
cd /data/repos/linux
git log --all --numstat -M -C --full-history --pretty=tformat:"STARTOFTHECOMMIT:linux%n%H;%T;%P;%an;%ae;%at;%cn;%ce;%ct;%s%n%b%nNOTES%N" > /data/repos/linux.log
cat /data/repos/linux.log | perl ~/openEulerAnalysis/extrgitPLog.pl > /data/repos/linux.delta
