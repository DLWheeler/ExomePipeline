rule gatk_realign2:
        input:  "{x}.dedup.bam"
        output: re="{x}.realign.bam",
                int="{x}.fin.bam.intervals"
        params: gatk=config['bin']['GATK'],
                genome=config['references']['GENOME'],
                novosort=config['bin']['NOVOSORT'],
                sam=config['bin']['SAMTOOLS'],
                picard3=config['bin']['PICARD3'],
                indelsites=config['references']['INDELSITES'],rname="pl:realign"
        shell:  "module load novocraft/3.02.10;{params.novosort} -t /scratch -s -i -o {output} {input};{params.sam} index {input};{params.gatk} -T RealignerTargetCreator -I {input} -R {params.genome} -known {params.indelsites} -o {output.int}; {params.gatk} -T IndelRealigner -R {params.genome} -I {input} -targetIntervals {output.int} -o {output.re}"
#        shell:  "{params.sam} index {input}; {params.sam} faidx {params.genome};  {params.gatk} -T RealignerTargetCreator -I {input} -R {params.genome} -known {params.indelsites} -o {output.int}; {params.gatk} -T IndelRealigner -R {params.genome} -I {input} -targetIntervals {output.int} -o {output.re}"
params: 
     threads: 1
     shell:  "module load novocraft/3.02.10;{params.novosort} -t /scratch -s -i -o {output} {input};"
