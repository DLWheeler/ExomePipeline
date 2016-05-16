rule gatk_mutect2:
    input: normal=lambda wildcards: config['project']['pairs'][wildcards.x][0]+".realign.bam",
           tumor=lambda wildcards: config['project']['pairs'][wildcards.x][1]+".realign.bam"
    output: vcf="{x}.paired.vcf",
#           stats="{x}.stats.out",
#           wig="{x}.wig.txt"
    params: gatk=config['bin']['GATK'],genome=config['references']['GENOME'],cosmic=config['references']['MUTECTCOSMIC'],snpsites=config['references']['SNPSITES'],rname="pl:mutect2"
    threads: 4
    shell: "{params.gatk} -T MuTect2 -R {params.genome} -I:tumor {input.tumor} -I:normal {input.normal} --read_filter BadCigar --dbsnp {params.snpsites} -nct {threads} -o {output.vcf} -L 22"