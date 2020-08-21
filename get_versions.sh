#!/bin/bash

docker run dblodgett/hydrogeoenv-custom:latest \
python3 -c '
import pkg_resources

installed_packages = pkg_resources.working_set
installed_packages_list = sorted([f"{i.key}=={i.version}"
   for i in installed_packages])

print("\n".join(installed_packages_list))
' > docs/python_packages.txt

docker run dblodgett/hydrogeoenv-custom:latest \
Rscript -e '
ip <- as.data.frame(installed.packages()[, c(1,3:4)])
rownames(ip) <- NULL
ip <- ip[is.na(ip$Priority),1:2, drop=FALSE]
write.table(ip, row.names=FALSE, col.names=FALSE, quote = FALSE)
' > docs/r_packages.txt