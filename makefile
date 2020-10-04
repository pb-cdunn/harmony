D?=$(strip $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST)))))
#B=/pbi/collections/333/3330015/r64006_20190823_065515/2_B01/m64006_190824_131036.subreads.bam
#F=/pbi/dept/secondary/siv/references/Lambda_EagI_Digest/sequence/Lambda_EagI_Digest.fasta
G=/pbi/dept/secondary/siv/testdata/hgap/greg200k-sv2-ccs/
F=ref.fasta
H=$G/subreads.bam

go: harmony.pdf
ref: $F
$F:
	cat $G/ref1.fasta $G/ref2.fasta >| $F
build:
	ninja -v -C $D/build
conf:
	rm -rf $D/build/
	meson $D/build
#hifi.bam:
#	ccs $B $@ --log-level INFO
hifi.aligned.bam: $H
	pbmm2 align --best-n 1 --preset HiFi $F $^ $@
harm: hifi.aligned.bam
	$D/build/harmony $^ $F > 111
harmony.pdf: harm
	$D/scripts/single.R 111 222
	#Rscript -e 'source("$D/scripts/single.R", echo=TRUE)' m64006_190824_131036 m64006_190827_133700
.PHONY: build
