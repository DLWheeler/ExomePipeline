rule qualimap:
    input:  "{x}.dedup.bam"
    output: "QC/{x}.qualimapReport"
    threads: 8 
    params: qualimap=config['bin'][pfamily]['QUALIMAP'],organism=config['references'][pfamily]['ORGANISM'],regions=config['references'][pfamily]['REFFLAT'],rname="pl:qualimap"
#    shell:  "{params.qualimap} bamqc -bam {input} -c gd {params.organism} -outfile {output} -gff {params.regions} -outformat HTML -nw 500 -p NON-STRAND-SPECIFIC -nt {threads}"
    shell:  "{params.qualimap} bamqc -bam {input} -c gd {params.organism} -outdir {output} -gff {params.regions} -outformat HTML -nw 500 -p NON-STRAND-SPECIFIC"