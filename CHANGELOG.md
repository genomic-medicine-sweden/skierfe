# genomic-medicine-sweden/nallo: Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.5.0dev - [XXXX-XX-XX]

### `Added`

- [#516](https://github.com/genomic-medicine-sweden/nallo/pull/516) - Added beta support for ONT R10 assembly
- [#531](https://github.com/genomic-medicine-sweden/nallo/pull/531) - Added missing credits to the README
- [#537](https://github.com/genomic-medicine-sweden/nallo/pull/537) - Added per-base depth output in d4 format from mosdepth

### `Changed`

- [#532](https://github.com/genomic-medicine-sweden/nallo/pull/532) - Updated template to nf-core/tools version 3.1.1
- [#535](https://github.com/genomic-medicine-sweden/nallo/pull/535) - Updated DeepVariant to 1.8.0 for SPRQ compatability
- [#536](https://github.com/genomic-medicine-sweden/nallo/pull/536) - Downgraded Sniffles from 2.0.7 to 1.0.12 due to missing calls

### `Removed`

### `Fixed`

### Parameters

| Old parameter | New parameter      |
| ------------- | ------------------ |
|               | `--hifiasm_preset` |

> [!NOTE]
> Parameter has been updated if both old and new parameter information is present.
> Parameter has been added if just the new parameter information is present.
> Parameter has been removed if new parameter information isn't present.

### Module updates

| Tool        | Old version | New version |
| ----------- | ----------- | ----------- |
| hifiasm     | 0.19.8      | 0.24.0      |
| deepvariant | 1.6.1       | 1.8.0       |
| sniffles    | 2.0.7       | 1.0.12      |
| mosdepth    | 0.3.8       | 0.3.10      |

> [!NOTE]
> Version has been updated if both old and new version information is present.
> Version has been added if just the new version information is present.
> Version has been removed if new version information isn't present.

## 0.4.0 - [2025-01-15]

### `Added`

- [#345](https://github.com/genomic-medicine-sweden/nallo/pull/345) - Added first version of a metro map
- [#346](https://github.com/genomic-medicine-sweden/nallo/pull/346) - Added nf-test to call_svs
- [#351](https://github.com/genomic-medicine-sweden/nallo/pull/351) - Added sample name to sniffles2 VCF
- [#352](https://github.com/genomic-medicine-sweden/nallo/pull/352) - Added (hidden) `params.extra_<tool>_options` for the test profile to modkit, vep, paraphase and hifiasm
- [#356](https://github.com/genomic-medicine-sweden/nallo/pull/356) - Added missing SNV and PED file to output documentation
- [#363](https://github.com/genomic-medicine-sweden/nallo/pull/363) - Added Zenodo link
- [#366](https://github.com/genomic-medicine-sweden/nallo/pull/366) - Added sorting of samples when creating PED files, so the output is always the same
- [#367](https://github.com/genomic-medicine-sweden/nallo/pull/367) - Added Severus as the default SV caller, together with a `--sv_caller` parameter to choose caller
- [#371](https://github.com/genomic-medicine-sweden/nallo/pull/371) - Added `FOUND_IN=caller` tags to SV output
- [#388](https://github.com/genomic-medicine-sweden/nallo/pull/388) - Added longphase as the default phaser
- [#388](https://github.com/genomic-medicine-sweden/nallo/pull/388) - Added single-sample tbi output to the short variant calling subworkflow
- [#393](https://github.com/genomic-medicine-sweden/nallo/pull/393) - Added a new `--minimap2_read_mapping_preset` parameter
- [#403](https://github.com/genomic-medicine-sweden/nallo/pull/403) - Added `FOUND_IN=hificnv` tags to CNV calling output
- [#408](https://github.com/genomic-medicine-sweden/nallo/pull/408) - Added a new subworkflow to annotate SVs
- [#417](https://github.com/genomic-medicine-sweden/nallo/pull/417) - Added `FOUND_IN=deepvariant` tags to SNV calling output
- [#418](https://github.com/genomic-medicine-sweden/nallo/pull/418) - Added a check for unique input filenames for each sample
- [#419](https://github.com/genomic-medicine-sweden/nallo/pull/419) - Added support for SV filtering using input BED file ([#348](https://github.com/genomic-medicine-sweden/nallo/issues/348))
- [#429](https://github.com/genomic-medicine-sweden/nallo/pull/429) - Added nf-test to CNV calling
- [#429](https://github.com/genomic-medicine-sweden/nallo/pull/429) - Added SVDB to merge CNV calling results
- [#430](https://github.com/genomic-medicine-sweden/nallo/pull/430) - Added a GitHub action to build and publish docs to GitHub Pages
- [#431](https://github.com/genomic-medicine-sweden/nallo/pull/431) - Added files needed to automatically build and publish docs to GitHub Pages
- [#435](https://github.com/genomic-medicine-sweden/nallo/pull/435) - Added nf-test to rank variants
- [#445](https://github.com/genomic-medicine-sweden/nallo/pull/445) - Added FOUND_IN tag and nf-test to rank variants
- [#446](https://github.com/genomic-medicine-sweden/nallo/pull/446) - Added the vcfstatsreport from DeepVariant to snv calling
- [#450](https://github.com/genomic-medicine-sweden/nallo/pull/450) - Added ranking of SVs (and CNVs)
- [#451](https://github.com/genomic-medicine-sweden/nallo/pull/451) - Added support for running methylation subworkflow without phasing
- [#451](https://github.com/genomic-medicine-sweden/nallo/pull/451) - Added nf-test to methylation
- [#491](https://github.com/genomic-medicine-sweden/nallo/pull/491) - Added a changelog reminder action
- [#496](https://github.com/genomic-medicine-sweden/nallo/pull/496) - Added a subworkflow to filter variants

### `Changed`

- [#344](https://github.com/genomic-medicine-sweden/nallo/pull/344) - Changed version to 0.4.0dev
- [#346](https://github.com/genomic-medicine-sweden/nallo/pull/346) - Renamed structural_variant_calling to call_svs
- [#351](https://github.com/genomic-medicine-sweden/nallo/pull/351) - Changed from using sniffles to bcftools to merge SV calls from multiple samples
- [#351](https://github.com/genomic-medicine-sweden/nallo/pull/351) - Renamed the structural variant output files and directories
- [#352](https://github.com/genomic-medicine-sweden/nallo/pull/352) - Changed fastq conversion to run only when the assembly workflow is active
- [#352](https://github.com/genomic-medicine-sweden/nallo/pull/352) - Changed FastQC to run on BAM files to remove concatenation of fastq files
- [#352](https://github.com/genomic-medicine-sweden/nallo/pull/352) - Changed FastQC from the main workflow to QC_ALIGNED_READS, updated output directories and documentation
- [#352](https://github.com/genomic-medicine-sweden/nallo/pull/352) - Combined `--skip_raw_read_qc` and `--skip_aligned_read_qc` parameters into `--skip_qc`
- [#355](https://github.com/genomic-medicine-sweden/nallo/pull/355) - Updated paraphase to compress and index VCFs within the module
- [#365](https://github.com/genomic-medicine-sweden/nallo/pull/365) - Changed CI to only use nf-test for pipeline tests
- [#381](https://github.com/genomic-medicine-sweden/nallo/pull/381) - Updated CI nf-test version to 0.9.0
- [#382](https://github.com/genomic-medicine-sweden/nallo/pull/382) - Changed vep_plugin_files description in schema and docs
- [#388](https://github.com/genomic-medicine-sweden/nallo/pull/388) - Changed phasing output structure and naming, and updated docs
- [#393](https://github.com/genomic-medicine-sweden/nallo/pull/393) - Changed the default minimap2 preset for PacBio data from `map-hifi` to `lr:hqae`
- [#397](https://github.com/genomic-medicine-sweden/nallo/pull/397) - Changed `pipelines_testdata_base_path` to pin a specific commit
- [#402](https://github.com/genomic-medicine-sweden/nallo/pull/402) - Updated broken test profile link added in [#397](https://github.com/genomic-medicine-sweden/nallo/pull/397)
- [#403](https://github.com/genomic-medicine-sweden/nallo/pull/403) - Changed `ADD_FOUND_IN_TAG` process to allow input files to be named the same as output, fixed header line description and removed bcftools view versions in header
- [#403](https://github.com/genomic-medicine-sweden/nallo/pull/403) - Revert [#404](https://github.com/genomic-medicine-sweden/nallo/pull/404)
- [#404](https://github.com/genomic-medicine-sweden/nallo/pull/404) - Changed to only run nf-tests where files have changes compared to the base branch
- [#407](https://github.com/genomic-medicine-sweden/nallo/pull/407) - Changed echtvar example file in docs
- [#410](https://github.com/genomic-medicine-sweden/nallo/pull/410) - Updated genmod to version 3.8.3
- [#411](https://github.com/genomic-medicine-sweden/nallo/pull/411) - Updated longphase module to most recent version. ([#409](https://github.com/genomic-medicine-sweden/nallo/issues/409)).
- [#416](https://github.com/genomic-medicine-sweden/nallo/pull/416) - Updated WhatsHap to 2.3 and added the `--use-supplementary` flag to use supplementary reads for phasing by default. Changed modules to use biocontainers instead of custom containers. ([#296](https://github.com/genomic-medicine-sweden/nallo/issues/296))
- [#417](https://github.com/genomic-medicine-sweden/nallo/pull/417) - Updated SNV annotation tests to use correct configuration, and snapshot the md5sum, and summary of the variants
- [#418](https://github.com/genomic-medicine-sweden/nallo/pull/418) - Changed the default value of `--alignment_processes` from 1 to 8, meaning the pipeline will perform parallel alignment by default
- [#418](https://github.com/genomic-medicine-sweden/nallo/pull/418) - Changed the order of input files to samtools merge to be sorted on filename, avoiding unstable nf-test snapshots
- [#422](https://github.com/genomic-medicine-sweden/nallo/pull/422) - Updated nf-core/tools template to v3.0.1
- [#423](https://github.com/genomic-medicine-sweden/nallo/pull/423) - Updated metro map
- [#428](https://github.com/genomic-medicine-sweden/nallo/pull/428) - Changed from using bcftools to SVDB for SV merging
- [#429](https://github.com/genomic-medicine-sweden/nallo/pull/429) - Updated HiFiCNV to 1.0.0
- [#429](https://github.com/genomic-medicine-sweden/nallo/pull/429) - Refactored the CNV calling subworkflow
- [#429](https://github.com/genomic-medicine-sweden/nallo/pull/429) - Changed SV and CNV calling outputs, merging is now done per family
- [#431](https://github.com/genomic-medicine-sweden/nallo/pull/431) - Changed `CITATIONS.md` to `docs/CITATIONS.md`,
- [#433](https://github.com/genomic-medicine-sweden/nallo/pull/433) - Updated docs and README.
- [#434](https://github.com/genomic-medicine-sweden/nallo/pull/434) - Updated the SVDB merge module to fix unstable CALL_SVS tests
- [#435](https://github.com/genomic-medicine-sweden/nallo/pull/435) - Updated and refactored processes and workflows related to variant ranking
- [#438](https://github.com/genomic-medicine-sweden/nallo/pull/438) - Updated pipeline tests to use functions in nft-utils instead of checking hardcoded paths
- [#440](https://github.com/genomic-medicine-sweden/nallo/pull/440) - Updated hifiasm to 0.20 with new default parameters for telomeres and scaffolding ([#295](https://github.com/genomic-medicine-sweden/nallo/issues/295))
- [#441](https://github.com/genomic-medicine-sweden/nallo/pull/441) - Changed the minimap2 preset for hifi reads back to `map-hifi`
- [#443](https://github.com/genomic-medicine-sweden/nallo/pull/443) - Refactored reference channel assignments
- [#443](https://github.com/genomic-medicine-sweden/nallo/pull/443) - Updated schemas for `vep_plugin_files` and `snp_db`
- [#451](https://github.com/genomic-medicine-sweden/nallo/pull/451) - Simplified methylation subworkflow
- [#474](https://github.com/genomic-medicine-sweden/nallo/pull/474) - Updated VEP and CADD channels to fix bugs introduced in [#443](https://github.com/genomic-medicine-sweden/nallo/pull/443)
- [#479](https://github.com/genomic-medicine-sweden/nallo/pull/479) - Replaced bgzip tabix with bcftools sort in rank variants to fix [#457](https://github.com/genomic-medicine-sweden/nallo/issues/457)
- [#480](https://github.com/genomic-medicine-sweden/nallo/pull/480) - Updated ranking of SVs to work with multiple families per project
- [#484](https://github.com/genomic-medicine-sweden/nallo/pull/484) - Updated metro map and added SVG version
- [#485](https://github.com/genomic-medicine-sweden/nallo/pull/485) - Updated repeat expansion annotation to annotate per family instead of per sample
- [#486](https://github.com/genomic-medicine-sweden/nallo/pull/486) - Updated nf-core modules
- [#487](https://github.com/genomic-medicine-sweden/nallo/pull/487) - Changed CI tests to only run tests where changes have been made
- [#488](https://github.com/genomic-medicine-sweden/nallo/pull/488) - Changed naming of input parameters
- [#489](https://github.com/genomic-medicine-sweden/nallo/pull/489) - Updated nf-core template to 3.0.2
- [#493](https://github.com/genomic-medicine-sweden/nallo/pull/493) - Refactored `nallo.nf` to remove many nested ifs and easier to follow logic
- [#493](https://github.com/genomic-medicine-sweden/nallo/pull/493) - Updated rank_variants dependencies with sv_annotation
- [#498](https://github.com/genomic-medicine-sweden/nallo/pull/498) - Updated CI to fix CI failures after merge
- [#502](https://github.com/genomic-medicine-sweden/nallo/pull/502) - Changed to annotating and ranking SNVs per family instead of per project
- [#502](https://github.com/genomic-medicine-sweden/nallo/pull/502) - Changed output documentation and structure to match `sample` and `family` for all variants
- [#502](https://github.com/genomic-medicine-sweden/nallo/pull/502) - Changed the way of validating the samplesheet to remove outputing false errors with `ifEmpty`
- [#505](https://github.com/genomic-medicine-sweden/nallo/pull/505) - Updated TRGT to 1.2.0
- [#506](https://github.com/genomic-medicine-sweden/nallo/pull/506) - Updated documentation
- [#507](https://github.com/genomic-medicine-sweden/nallo/pull/507) - Changed the default value of `ch_hgnc_ids` to allow running without `--filter_variants_hgnc_ids` introduced in [#496](https://github.com/genomic-medicine-sweden/nallo/pull/443)
- [#509](https://github.com/genomic-medicine-sweden/nallo/pull/509) - Updated documentation to fix mistakes
- [#510](https://github.com/genomic-medicine-sweden/nallo/pull/510) - Changed the MultiQC methods description to update dynamically based on `ch_versions`
- [#512](https://github.com/genomic-medicine-sweden/nallo/pull/512) - Changed one `single_sample` to `sample` and one `multi_sample` to `family` output directories missed in [#502](https://github.com/genomic-medicine-sweden/nallo/pull/502)
- [#512](https://github.com/genomic-medicine-sweden/nallo/pull/512) - Changed all `*_snv_*` to `*_snvs_*` for published output files to match `snvs`, `cnvs`, `svs` and `repeats`.
- [#513](https://github.com/genomic-medicine-sweden/nallo/pull/513) - Updated CITATIONS.md link in README
- [#523](https://github.com/genomic-medicine-sweden/nallo/pull/523) - Updated to filter more than one family per run, missed in [#496](https://github.com/genomic-medicine-sweden/nallo/pull/496)

### `Removed`

- [#352](https://github.com/genomic-medicine-sweden/nallo/pull/352) - Removed the fqcrs module
- [#356](https://github.com/genomic-medicine-sweden/nallo/pull/356) - Removed filter_vep section from output documentation since it is not in the pipeline
- [#379](https://github.com/genomic-medicine-sweden/nallo/pull/379) - Removed VEP Plugins from testdata ([genomic-medicine-sweden/test-datasets#16](https://github.com/genomic-medicine-sweden/test-datasets/pull/16))
- [#388](https://github.com/genomic-medicine-sweden/nallo/pull/388) - Removed support for co-phasing SVs with HiPhase, as the officially supported caller (pbsv) is not in the pipeline
- [#412](https://github.com/genomic-medicine-sweden/nallo/pull/412) - Removed `bcftools/index`, as indexing is handled by other modules and no references remained. ([#377](https://github.com/genomic-medicine-sweden/nallo/issues/377))
- [#502](https://github.com/genomic-medicine-sweden/nallo/pull/502) - Removed support for automatically creating an echvar database with SNVs and INDELs
- [#502](https://github.com/genomic-medicine-sweden/nallo/pull/502) - Removed `containts_affected` logic from the snv-calling workflow, since this was previously changed to be checked before pipeline start

### `Fixed`

- [#370](https://github.com/genomic-medicine-sweden/nallo/pull/370) - Fixed unsorted variants in SNV outputs ([#362](https://github.com/genomic-medicine-sweden/nallo/issues/362))
- [#381](https://github.com/genomic-medicine-sweden/nallo/pull/381) - Fixed `--vep_cache` not working as expected with tar.gz cache downloaded from VEP, updated testdata in [genomic-medicine-sweden/test-datasets#17](https://github.com/genomic-medicine-sweden/test-datasets/pull/17)
- [#382](https://github.com/genomic-medicine-sweden/nallo/pull/382) - Fixed broken links and formatting in documentation
- [#393](https://github.com/genomic-medicine-sweden/nallo/pull/393) - Fixed minimap2 preset for ONT data being overwritten to `map-ont` when it should have been `lr:hq`, due to different settings in index and alignment processes [#392](https://github.com/genomic-medicine-sweden/nallo/issues/392)
- [#402](https://github.com/genomic-medicine-sweden/nallo/pull/402) - Fixed double sample names in HiFiCNV output
- [#438](https://github.com/genomic-medicine-sweden/nallo/pull/438) - Fixed missing/malformed software versions in `ADD_FOUND_IN_TAG`, `ADD_MOST_SEVERE_CSQ`, `ADD_MOST_SEVERE_PLI`, `SAMPLESHEET_PED`, `SOMALIER_PED` and `TRGT`
- [#444](https://github.com/genomic-medicine-sweden/nallo/pull/444) - Fixed genmod assigning wrong models on chromosome X when named `chrX` ([#343](https://github.com/genomic-medicine-sweden/nallo/issues/343))
- [#502](https://github.com/genomic-medicine-sweden/nallo/pull/502) - Fixed genmod only scoring compounds in one family [#501](https://github.com/genomic-medicine-sweden/nallo/issues/501)

### Parameters

| Old parameter                    | New parameter                     |
| -------------------------------- | --------------------------------- |
| `--skip_aligned_read_qc`         | `--skip_qc`                       |
| `--skip_raw_read_qc`             | `--skip_qc`                       |
|                                  | `--sv_caller`                     |
|                                  |  `--minimap2_read_mapping_preset` |
| `--genome`                       |                                   |
| `--igenomes_ignore`              |                                   |
| `--max_cpus`                     |                                   |
| `--max_memory`                   |                                   |
| `--max_time`                     |                                   |
| `--validationShowHiddenParams`   |                                   |
| `--validationSkipDuplicateCheck` |                                   |
| `--validationS3PathCheck`        |                                   |
| `--monochromeLogs`               | `--monochrome_logs`               |
|                                  | `--filter_variants_hgnc_ids`      |
|                                  | `--filter_snvs_expression`        |
|                                  | `--filter_svs_expression`         |
| `--skip_short_variant_calling`   | `--skip_snv_calling`              |
| `--skip_assembly_wf`             | `--skip_genome_assembly`          |
| `--skip_mapping_wf`              | `--skip_alignment`                |
| `--skip_methylation_wf`          | `--skip_methylation_pileups`      |
| `--skip_phasing_wf`              | `--skip_phasing`                  |
| `--variant_caller`               | `--snv_caller`                    |
| `--parallel_snv`                 | `--snv_calling_processes`         |
| `--cadd_prescored`               | `--cadd_prescored_indels`         |
| `--snp_db`                       | `--echtvar_snv_databases`         |
| `--variant_catalog`              | `--stranger_repeat_catalog`       |
| `--bed`                          | `--target_regions`                |
| `--hificnv_xy`                   | `--hificnv_expected_xy_cn`        |
| `--hificnv_xx`                   | `--hificnv_expected_xx_cn`        |
| `--hificnv_exclude`              | `--hificnv_excluded_regions`      |
| `--reduced_penetrance`           | `--genmod_reduced_penetrance`     |
| `--score_config_snv`             | `--genmod_score_config_snvs`      |
| `--score_config_sv`              | `--genmod_score_config_svs`       |
| `--parallel_alignments`          | `--alignment_processes`           |
| `--svdb_dbs`                     | `--svdb_sv_databases`             |

> [!NOTE]
> Parameter has been updated if both old and new parameter information is present.
> Parameter has been added if just the new parameter information is present.
> Parameter has been removed if new parameter information isn't present.

### Module updates

| Tool                  | Old version | New version |
| --------------------- | ----------- | ----------- |
| fqcrs                 | 0.1.0       |
| severus               |             | 1.1         |
| longphase             |             | 1.7.3       |
| genmod                | 3.8.2       | 3.9         |
| WhatsHap              | 2.2         | 2.3         |
| SVDB                  |             | 2.8.2       |
| hifiasm               | 0.19.8      | 0.20.0      |
| HiFiCNV               | 0.1.7       | 1.0.0       |
| samtools/faidx        | 1.2         | 1.21        |
| samtools/index        | 1.2         | 1.21        |
| samtools/merge        | 1.2         | 1.21        |
| stranger              | 0.9.1       | 0.9.2       |
| multiqc               | 1.21        | 1.25.1      |
| ensemblvep/filter_vep |             | 113         |
| TRGT                  | 0.4.0       | 1.2.0       |
| bcftools/merge        | 1.2         |             |

> [!NOTE]
> Version has been updated if both old and new version information is present.
> Version has been added if just the new version information is present.
> Version has been removed if new version information isn't present.

## 0.3.2 - [2024-09-20]

### `Fixed`

- [#396](https://github.com/genomic-medicine-sweden/nallo/pull/396) - Fixed the release test profile not working, by pinning the testdata used [#395](https://github.com/genomic-medicine-sweden/nallo/issues/395)

## 0.3.1 - [2024-09-11]

### `Fixed`

- [#359](https://github.com/genomic-medicine-sweden/nallo/pull/359) - Fixed single sample SNV VCFs containing variants from all samples, resuling in a large number of empty GT calls

## 0.3.0 - [2024-08-29]

### `Added`

- [#230](https://github.com/genomic-medicine-sweden/nallo/pull/230) - Added nf-test to the short variant calling workflow
- [#231](https://github.com/genomic-medicine-sweden/nallo/pull/231) - Added initial tests for ONT data
- [#234](https://github.com/genomic-medicine-sweden/nallo/pull/234) - Added a `--deepvariant_model_type` parameter to override the model type set by `--preset`
- [#239](https://github.com/genomic-medicine-sweden/nallo/pull/239) - Added initial nf-test to the pipeline
- [#243](https://github.com/genomic-medicine-sweden/nallo/pull/243) - Added nf-test to the short variant annotation workflow
- [#245](https://github.com/genomic-medicine-sweden/nallo/pull/245) - Added repeat annotation with Stranger
- [#252](https://github.com/genomic-medicine-sweden/nallo/pull/252) - Added a new `SCATTER_GENOME` subworkflow
- [#255](https://github.com/genomic-medicine-sweden/nallo/pull/255) - Added a new `RANK_VARIANTS` subworkflow to rank SNVs using genmod
- [#261](https://github.com/genomic-medicine-sweden/nallo/pull/261) - Added a `--skip_rank_variants` parameter to skip the rank_variants subworkflow
- [#264](https://github.com/genomic-medicine-sweden/nallo/pull/264) - Added a `project` column to the sampleheet
- [#266](https://github.com/genomic-medicine-sweden/nallo/pull/266) - Added CADD to dynamically calculate indel CADD-scores
- [#270](https://github.com/genomic-medicine-sweden/nallo/pull/270) - Added SNV phasing stats to MultiQC
- [#271](https://github.com/genomic-medicine-sweden/nallo/pull/271) - Added a `--skip_aligned_read_qc` parameter to skip the qc aligned reads subworkflow
- [#314](https://github.com/genomic-medicine-sweden/nallo/pull/314) - Added a `--vep_plugin_files` parameter to separate VEP plugins from cache
- [#320](https://github.com/genomic-medicine-sweden/nallo/pull/320) - Added complete citations to CITATIONS.md and MultiQC report

### `Changed`

- [#232](https://github.com/genomic-medicine-sweden/nallo/pull/232) - Changed to softer `--preset` requirements, non-supported subworkflows can now be explicitly enabled if necessary
- [#232](https://github.com/genomic-medicine-sweden/nallo/pull/232) - Changed `--skip_repeat_wf` to default to true for preset ONT_R10
- [#233](https://github.com/genomic-medicine-sweden/nallo/pull/233) - Changed the CNV calling workflow to allow calling using ONT data
- [#235](https://github.com/genomic-medicine-sweden/nallo/pull/235) - Changed the ONT_R10 preset to not allow phasing with HiPhase
- [#240](https://github.com/genomic-medicine-sweden/nallo/pull/240) - Reorganize processes in the snv annotation and short variant calling workflows
- [#240](https://github.com/genomic-medicine-sweden/nallo/pull/240) - GLNexus multisample output is now decomposed and normalized
- [#244](https://github.com/genomic-medicine-sweden/nallo/pull/244) - Updated VEP with more annotations
- [#245](https://github.com/genomic-medicine-sweden/nallo/pull/245) - Merged (multisample) repeats from TRGT is now output even if there's only one sample
- [#245](https://github.com/genomic-medicine-sweden/nallo/pull/245) - Split the repeat analysis workflow into one calling and one annotation workflow, `--skip_repeat_wf` becomes `--skip_repeat_calling` and `--skip_repeat_annotation`
- [#246](https://github.com/genomic-medicine-sweden/nallo/pull/246) - Renamed processes and light refactoring of the short variant calling workflow
- [#246](https://github.com/genomic-medicine-sweden/nallo/pull/246) - Use groupKey to remove bottleneck in the short variant calling workflow
- [#247](https://github.com/genomic-medicine-sweden/nallo/pull/247) - Updated nft-bam to 0.3.0 and added BAM reads to snapshot
- [#247](https://github.com/genomic-medicine-sweden/nallo/pull/247) - Changed minimap2 preset from `map-ont` to `lr:hq` for `--preset ONT_R10`
- [#250](https://github.com/genomic-medicine-sweden/nallo/pull/250) - Run mosdepth with `--fast-mode` and add to MultiQC report
- [#251](https://github.com/genomic-medicine-sweden/nallo/pull/251) - Switched from annotating single sample VCFs to annotating a multisample VCF, splitting the VCF per sample afterwards to keep outputs almost consistent
- [#256](https://github.com/genomic-medicine-sweden/nallo/pull/256) - Changed Stranger to annotate single-sample VCFs instead of a multi-sample VCF
- [#258](https://github.com/genomic-medicine-sweden/nallo/pull/258) - Updated test profile parameters to speed up tests
- [#260](https://github.com/genomic-medicine-sweden/nallo/pull/260) - Updated DeepVariant to 1.6.1 and htslib (tabix) to 1.20
- [#261](https://github.com/genomic-medicine-sweden/nallo/pull/261) - Changed SNV annotation to run in parallel
- [#261](https://github.com/genomic-medicine-sweden/nallo/pull/261) - Changed SNV output file names and directory structure
- [#262](https://github.com/genomic-medicine-sweden/nallo/pull/262) - Updated README
- [#264](https://github.com/genomic-medicine-sweden/nallo/pull/264) - Changed PED file creation from groovy script to process
- [#264](https://github.com/genomic-medicine-sweden/nallo/pull/264) - Changed all `multisample` filenames to `{project}` from samplesheet
- [#268](https://github.com/genomic-medicine-sweden/nallo/pull/268) - Only output unphased alignments when phasing is off
- [#268](https://github.com/genomic-medicine-sweden/nallo/pull/268) - Changed alignment output file names and directory structure
- [#270](https://github.com/genomic-medicine-sweden/nallo/pull/270) - Changed whatshap stats to always run, regardless of phasing software, and changed the output from `*.stats.tsv.gz` to `*.stats.tsv` to allow being picked up by MultiQC
- [#277](https://github.com/genomic-medicine-sweden/nallo/pull/277) - Allowed CNV calling as soon as SNV calling for a sample is finished
- [#278](https://github.com/genomic-medicine-sweden/nallo/pull/278) - Changed the SNV ranking to run in parallel per region
- [#300](https://github.com/genomic-medicine-sweden/nallo/pull/300) - Clarified and formatted nallo.nf
- [#304](https://github.com/genomic-medicine-sweden/nallo/pull/304) - Changed to treat (u)BAM as the primary input by skipping fastq conversion before aligning
- [#306](https://github.com/genomic-medicine-sweden/nallo/pull/306) - Updated echtvar version
- [#307](https://github.com/genomic-medicine-sweden/nallo/pull/307) - Changed somalier relate to also run per sample on sampes with unknown sex, removing the need to wait on all samples to finish aligment before starting variant calling
- [#307](https://github.com/genomic-medicine-sweden/nallo/pull/307) - Changed the removal of n_files from meta from bam_infer_sex to nallo.nf
- [#308](https://github.com/genomic-medicine-sweden/nallo/pull/308) - Updated nf-core modules, fixed warnings in local modules, added Dockerfile to fqcrs
- [#312](https://github.com/genomic-medicine-sweden/nallo/pull/312) - Changed echtvar encode database creation to use dynamic `${project}` from samplesheet
- [#313](https://github.com/genomic-medicine-sweden/nallo/pull/313) - Updated calling of variants in non-autosomal contigs for DeepVariant
- [#314](https://github.com/genomic-medicine-sweden/nallo/pull/314) - Changed VEP annotation added in #244 to not include SpliceAI
- [#317](https://github.com/genomic-medicine-sweden/nallo/pull/317) - Changed so that `--reduced_penetrance` and `--score_config_snv` is required by rank variants and not SNV annotation
- [#318](https://github.com/genomic-medicine-sweden/nallo/pull/318) - Updated docs and schema to clarify pipeline usage
- [#321](https://github.com/genomic-medicine-sweden/nallo/pull/321) - Changed the input to BUILD_INTERVALS to have `meta.id` when building intervals from reference
- [#323](https://github.com/genomic-medicine-sweden/nallo/pull/323) - Changed `parallel_alignment` to `parallel_alignments` in CI tests as well
- [#330](https://github.com/genomic-medicine-sweden/nallo/pull/330) - Updated README and version bump
- [#332](https://github.com/genomic-medicine-sweden/nallo/pull/332) - Changed the PED file input to genmod to include inferred sex from somalier
- [#333](https://github.com/genomic-medicine-sweden/nallo/pull/333) - Updated TRGT to 0.7.0 and added `meta.id` as output sample name

### `Removed`

- [#237](https://github.com/genomic-medicine-sweden/nallo/pull/237) - Removed the CONVERT_ONT_READNAMES module that was run before calling repeats with TRGT
- [#238](https://github.com/genomic-medicine-sweden/nallo/pull/238) - Removed the `--extra_gvcfs` parameter
- [#243](https://github.com/genomic-medicine-sweden/nallo/pull/243) - Removed VEP report from output files
- [#257](https://github.com/genomic-medicine-sweden/nallo/pull/257) - Removed obsolete TODO statements
- [#258](https://github.com/genomic-medicine-sweden/nallo/pull/258) - Removed VCF report from DeepVariant output
- [#264](https://github.com/genomic-medicine-sweden/nallo/pull/264) - Removed the option to provide extra SNF files to Sniffles with `--extra_snfs`
- [#305](https://github.com/genomic-medicine-sweden/nallo/pull/305) - Removed unused local module bcftools view regions
- [#319](https://github.com/genomic-medicine-sweden/nallo/pull/319) - Removed samtools reset before samtools fastq when converting BAM to FASTQ

### `Fixed`

- [#231](https://github.com/genomic-medicine-sweden/nallo/pull/231) - Fixed certain tags in input BAM files being transfered over to (re)aligned BAM
- [#252](https://github.com/genomic-medicine-sweden/nallo/pull/252) - Fixed duplicate SNVs in outputs when providing a BED-regions with overlapping regions
- [#267](https://github.com/genomic-medicine-sweden/nallo/pull/267) - Fixed warning where `MODKIT_PILEUP_HAPLOTYPES` would be defined more than once
- [#300](https://github.com/genomic-medicine-sweden/nallo/pull/300) - Fixed missing paraphase version
- [#427](https://github.com/genomic-medicine-sweden/nallo/pull/427) - Fixed duplicate RG tags in BAM files after mapping from uBAMs ([#426](https://github.com/genomic-medicine-sweden/nallo/issues/426)).

### Parameters

| Old parameter      | New parameter              |
| ------------------ | -------------------------- |
| `--skip_repeat_wf` | `--skip_repeat_calling`    |
| `--skip_repeat_wf` | `--skip_repeat_annotation` |
|                    | `--deepvariant_model_type` |
|                    | `--skip_rank_variants`     |
|                    | `--skip_aligned_read_qc`   |
|                    | `--cadd_resources`         |
|                    | `--cadd_prescored`         |
| `--split_fastq`    | `--parallel_alignments`    |
| `--extra_gvcfs`    |                            |
| `--extra_snfs`     |                            |
| `--dipcall_par`    | `--par_regions`            |
|                    | `--vep_plugin_files`       |

> [!NOTE]
> Parameter has been updated if both old and new parameter information is present.
> Parameter has been added if just the new parameter information is present.
> Parameter has been removed if new parameter information isn't present.

### Module updates

| Tool                        | Old version | New version |
| --------------------------- | ----------- | ----------- |
| deepvariant                 | 1.5.0       | 1.6.1       |
| tabix                       | 1.19.1      | 1.20        |
| echtvar                     | 0.1.7       | 0.2.0       |
| somalier                    | 0.2.15      | 0.2.18      |
| TRGT                        | 0.4.0       | 0.7.0       |
| cadd                        |             | 1.6.post1   |
| gawk                        |             | 5.3.0       |
| add_most_severe_consequence |             | v1.0        |
| add_most_severe_pli         |             | v1.0        |
| create_pedigree_file        |             | v1.0        |
| genmod                      |             | 3.8.2       |
| stranger                    |             | 0.9.1       |
| splitubam                   |             | 0.1.1       |
| fastp                       | 0.23.4      |             |

> [!NOTE]
> Version has been updated if both old and new version information is present.
> Version has been added if just the new version information is present.
> Version has been removed if new version information isn't present.

## 0.2.0 - [2024-06-26]

### `Added`

- [#148](https://github.com/genomic-medicine-sweden/nallo/pull/148) - Added somalier to automatically infer and update the sex of samples, replacing unknown entries with the inferred data. Requires a VCF with known polymorphic sites supplied with `--somalier_sites`.
- [#148](https://github.com/genomic-medicine-sweden/nallo/pull/148) - Added a `RG` tag to BAM-files during alignment with `ID:${meta.id}` and `SM:${meta.id}`
- [#159](https://github.com/genomic-medicine-sweden/nallo/pull/159) - Added the ability to use multiple input files per sample, by splitting and aligning each input file individually, then merging them post-alignment for streamlined processing
- [#162](https://github.com/genomic-medicine-sweden/nallo/pull/162) - Added paraphase, a "HiFi-based caller for highly similar paralogous genes"
- [#179](https://github.com/genomic-medicine-sweden/nallo/pull/179) - Added support for running without `--fasta`, when running subworklows that do not require a reference genome
- [#226](https://github.com/genomic-medicine-sweden/nallo/pull/226) - Added file-level output documentation

### `Changed`

- [#146](https://github.com/genomic-medicine-sweden/nallo/pull/146) - Template merge for nf-core/tools v2.14.1
- [#145](https://github.com/genomic-medicine-sweden/nallo/pull/145) - Bump to new dev version
- [#151](https://github.com/genomic-medicine-sweden/nallo/pull/151) - Cleaned up TRGT output directory
- [#152](https://github.com/genomic-medicine-sweden/nallo/pull/152) - Use prefix in modkit module. Bgzip, index and split outputs into phased/unphased directories
- [#153](https://github.com/genomic-medicine-sweden/nallo/pull/153) - Changed cramino module to use prefix, renamed and moved all cramino outputs into `qc_aligned_reads/cramino/`
- [#159](https://github.com/genomic-medicine-sweden/nallo/pull/159) - Clarify the trio-binning genome assembly workflow
- [#159](https://github.com/genomic-medicine-sweden/nallo/pull/159) - `split_fastq` now splits on files instead of lines
- [#159](https://github.com/genomic-medicine-sweden/nallo/pull/159) - Use groupKey to remove bottleneck, where previously all samples had to wait before progressing after alignment
- [#162](https://github.com/genomic-medicine-sweden/nallo/pull/162) - Use `pipelines_testdata_base_path` in config
- [#163](https://github.com/genomic-medicine-sweden/nallo/pull/163) - Updated multiple module versions
- [#163](https://github.com/genomic-medicine-sweden/nallo/pull/163) - Changed modkit from local to nf-core module
- [#173](https://github.com/genomic-medicine-sweden/nallo/pull/173) - Rename methylation outputs to prevent it being overwritten
- [#176](https://github.com/genomic-medicine-sweden/nallo/pull/176) - Renamed whatshap output files and remove output .err file
- [#176](https://github.com/genomic-medicine-sweden/nallo/pull/176) - Made skip_call_paralogs usable
- [#176](https://github.com/genomic-medicine-sweden/nallo/pull/176) - Rename and fix raw read qc parameter
- [#176](https://github.com/genomic-medicine-sweden/nallo/pull/176) - Mosdepth can be run without bed
- [#176](https://github.com/genomic-medicine-sweden/nallo/pull/176) - Require somalier sites when running the mapping workflow
- [#177](https://github.com/genomic-medicine-sweden/nallo/pull/177) - Increased samtools merge resources
- [#183](https://github.com/genomic-medicine-sweden/nallo/pull/183) - Allows paraphase outputs to be bgzipped when calling multiple genes
- [#185](https://github.com/genomic-medicine-sweden/nallo/pull/185) - Harmonized, indexed and fixed naming of more variant files to vcf.gz + tbi
- [#212](https://github.com/genomic-medicine-sweden/nallo/pull/212) - Files that are from the same sample are now merged before FastQC

### `Removed`

- [#162](https://github.com/genomic-medicine-sweden/nallo/pull/162) - Removed `--skip...` default parameters from schema
- [#163](https://github.com/genomic-medicine-sweden/nallo/pull/163) - Removed RAM limitations from small test profile
- [#185](https://github.com/genomic-medicine-sweden/nallo/pull/185) - Removed samtools index from repeat calling workflow, as bai is now used in pipeline
- [#185](https://github.com/genomic-medicine-sweden/nallo/pull/185) - Removed versions.yml output from minimap2 align
- [#185](https://github.com/genomic-medicine-sweden/nallo/pull/185) - Removed echtvar anno output
- [#213](https://github.com/genomic-medicine-sweden/nallo/pull/213) - Removed dipcall parameters from test profile

### `Fixed`

- [#156](https://github.com/genomic-medicine-sweden/nallo/pull/156) - Fixed program versions missing in output and MultiQC report
- [#178](https://github.com/genomic-medicine-sweden/nallo/pull/178) - Fixed the MultiQC report saying the pipeline was part of nf-core
- [#180](https://github.com/genomic-medicine-sweden/nallo/pull/180) - Fixed nondescriptive error when no vep_cache was supplied

### Parameters

| Old parameter   | New parameter          |
| --------------- | ---------------------- |
|                 | `--somalier_sites`     |
| `--split_fastq` | `--split_fastq`        |
|                 | `--skip_call_paralogs` |
| `--skip_qc`     | `--skip_raw_read_qc`   |

`split_fastq` now splits the input files into _n_ files (range 2-999)

> [!NOTE]
> Parameter has been updated if both old and new parameter information is present.
> Parameter has been added if just the new parameter information is present.
> Parameter has been removed if new parameter information isn't present.

### Module updates

| Tool      | Old version | New version |
| --------- | ----------- | ----------- |
| samtools  | multiple    | 1.20        |
| bcftools  | multiple    | 1.20        |
| gfastats  | 1.3.5       | 1.3.6       |
| mosdepth  | 0.3.3       | 0.3.8       |
| bgzip     | 1.11        | 1.19.1      |
| tabix     | 1.11        | 1.19.1      |
| somalier  |             | 0.2.15      |
| minimap2  | 2.26        | 2.28        |
| hifiasm   | 0.19.5      | 0.19.8      |
| modkit    | 0.2.5       | 0.3.0       |
| paraphase |             | 3.1.1       |

> [!NOTE]
> Version has been updated if both old and new version information is present.
> Version has been added if just the new version information is present.
> Version has been removed if new version information isn't present.

## 0.1.0 - [2024-05-08]

Initial release of genomic-medicine-sweden/nallo, created with the [nf-core](https://nf-co.re/) template.

### `Added`

- Raw read QC with FastQC and FQCRS
- Align reads to reference with minimap2
- Aligned read QC with cramino and mosdepth
- Call SNVs with DeepVariant and merge with GLNexus
- Annotate SNVs with echtvar and VEP
- Call SVs with Sniffles, tandem repeats with TRGT and CNVs with HiFiCNV
- Phase variants and haplotag reads with whatshap or HiPhase
- Create methylation pileups with modkit
- Assemble genomes with hifiasm
- Align assemly to reference and call variants with dipcall
