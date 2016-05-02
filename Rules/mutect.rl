rule mutect:
       input:  normal=lambda wildcards: config['project']['pairs'][wildcards.x][1]+".realign.bam",
               tumor=lambda wildcards: config['project']['pairs'][wildcards.x][0]+".realign.bam"
       output: vcf="{x}.vcf",
               stats="{x}.stats.out",
#               wig="{x}.wig.txt"
       params: mutect=config['bin']['MUTECT'],genome=config['references']['MUTECTGENOME'],cosmic=config['references']['MUTECTCOSMIC'],snp=config['references']['MUTECTSNP'],rname="pl:mutect"
       shell:  """
{params.mutect} --analysis_type MuTect --reference_sequence {params.genome} --vcf {output.vcf} --cosmic {params.cosmic} {params.snp} --input_file:normal {input.normal} --input_file:tumor {input.tumor} --out {output.stats} -rf BadCigar 

"""
#--coverage_file {output.wig}
#--dbsnp {params.snp}
