B=/pbi/collections/333/3330015/r64006_20190823_065515/2_B01/m64006_190824_131036.subreads.bam
F=/pbi/dept/secondary/siv/references/Lambda_EagI_Digest/sequence/Lambda_EagI_Digest.fasta

build:
	ninja -v -C build
conf:
	rm -rf build/
	meson build
ccs:
	ccs m64006_190824_131036.subreads.bam m64006_190824_131036.hifi.bam --log-level INFO
align:
	pbmm2 align --best-n 1 --preset HiFi ref.fasta m64006_190824_131036.hifi.bam m64006_190824_131036.hifi.aligned.bam
harm:
	build/src/harmony m64006_190824_131036.hifi.aligned.bam ref.fasta > m64006_190824_131036
harmony.pdf:
	scripts/single.R m64006_190824_131036 m64006_190827_133700
.PHONY: build
