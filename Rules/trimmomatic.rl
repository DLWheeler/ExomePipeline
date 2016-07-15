rule trimmomatic:
    input:  "{x}.R1."+config['project']['filetype'],
            "{x}.R2."+config['project']['filetype']
    output: one="{x}.R1.trimmed.fastq.gz",
            two="{x}.R1.trimmed.unpair.fastq.gz",
            three="{x}.R2.trimmed.fastq.gz",
            four="{x}.R2.trimmed.unpair.fastq.gz",
            log="{x}.trimmomatic.log"
    params: trimmomatic=config['bin'][pfamily]['TRIMMOMATIC'],
            adapterfile=config['references'][pfamily]['trimmomatic.adapters'],rname="pl:trimmomatic"
    threads: 4
    shell:  """
            {params.trimmomatic} PE -threads {threads} -trimlog {output.log} -phred33 {input[0]} {input[1]} {output.one} {output.two} {output.three} {output.four} ILLUMINACLIP:{params.adapterfile}:3:30:10 LEADING:10 TRAILING:10 SLIDINGWINDOW:4:20 MINLEN:20
           """

# MAXINFO:50:0.8     



