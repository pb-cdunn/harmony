D?=$(strip $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST)))))
B=/pbi/collections/333/3330015/r64006_20190823_065515/2_B01/m64006_190824_131036.subreads.bam
F=/pbi/dept/secondary/siv/references/Lambda_EagI_Digest/sequence/Lambda_EagI_Digest.fasta

build:
	ninja -v -C $D/build
conf:
	rm -rf $D/build/
	meson $D/build
hifi.bam:
	ccs $B $@ --log-level INFO
hifi.aligned.bam: hifi.bam
	pbmm2 align --best-n 1 --preset HiFi $F $^ $@
harm: hifi.aligned.bam
	$D/build/src/harmony $^ $F > m64006_190824_131036
harmony.pdf:
	$D/scripts/single.R m64006_190824_131036 m64006_190827_133700
.PHONY: build
