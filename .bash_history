exit
ll
cd .local
ll
cd ..
chsh
ls
ll
ln -s /usr/share/data-minor-bioinf/assembly/oil_R1.fastq
ll
ln -s /usr/share/data-minor-bioinf/assembly/oil_R2.fastq
ln -s /usr/share/data-minor-bioinf/assembly/oilMP_S4_L001_R1_001.fastq 
ln -s /usr/share/data-minor-bioinf/assembly/oilMP_S4_L001_R2_001.fastq 
ll
seqtk sample -s1510 oil_R1.fastq 5000000 > sub1.fq
seqtk sample -s1510 oil_R2.fastq 5000000 > sub2.fq
seqtk sample -s1510 oilMP_S4_L001_R1_001.fastq 15000000 > submp1.fq
seqtk sample -s1510 oilMP_S4_L001_R2_001.fastq 15000000 > submp2.fq
mkdir fastqc
ls *.fastqc | xargs -P 4 -tI{} fastqc -o fastqc {}
ll
ls *.fq | xargs -P 4 -tI{} fastqc -o fastqc {}
ll
cd fastqc
ll
cd ../
ll
mkdir multiqc
multiqc -o multiqc fastqc
cd multiqc/
ll
cd multiqc_data/
ll
platanus_trim sub1.fq sub2.fq
platanus_trim_internal submp1.fq submp2.fq 
platanus_internal_trim submp1.fq submp2.fq 
ll
rm *.fq
ll
mkdir trimmed_fastqc
ls trimmed_fastqc/* | xargs -P 4 -tI{} fastqc -o trimmed_fastqc {}
mkdir trimmed_fastq
mv -v fastq/*trimmed trimmed_fastq
mv -v trimmed trimmed_fastq
mv -v *trimmed trimmed_fastq
ls trimmed_fastqc/* | xargs -P 4 -tI{} fastqc -o trimmed_fastqc {}
ls trimmed_fastq/* | xargs -P 4 -tI{} fastqc -o trimmed_fastqc {}
ll
mkdir trimmed_multiqc
multiqc -o trimmed_multiqc trimmed_fastqc
screen -h
screen -S dineev_plat
htop
cd trimmed_fastq
ll
