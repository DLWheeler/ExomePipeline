rule avia:
    input: "combined.gvcf"
    output:"full_annot.txt.zip"
    params: batch ="-l nodes=1:gpfs -q ccr",rname="avia"
    shell: """
         perl Scripts/avia.pl {input}

           """

