rule gatk_merge_somatic_vcfs:
    input: expand("{s}"+".paired.vcf",s=pairs)
    output:"merged_somatic.vcf"
    params: gres="lscratch:100",gatk=config['bin']['GATK'],genome=config['references']['GENOME'],snpsites=config['references']['SNPSITES'],rname="CombineVariants"
    run:
        fl=os.popen("ls *.vcf").read().split()      
        var=" --variant "+" --variant ".join(fl)
        cmd="{params.gatk} -T CombineVariants -R {params.genome} --filteredrecordsmergetype KEEP_IF_ANY_UNFILTERED -o {output}"+var
        system(cmd)
