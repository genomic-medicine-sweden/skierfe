# genomic-medicine-sweden/nallo pipeline parameters

Long-read variant calling pipeline

## Workflow skip options

Allows skipping certain parts of the pipeline

| Parameter | Description | Type | Default | Required | Hidden |
|-----------|-----------|-----------|-----------|-----------|-----------|
| `skip_qc` | Skip QC of reads | `boolean` | False |  |  |
| `skip_snv_calling` | Skip short variant calling | `boolean` | False |  |  |
| `skip_genome_assembly` | Skip genome assembly and assembly variant calling | `boolean` | False |  |  |
| `skip_alignment` | Skip read mapping (alignment) | `boolean` | False |  |  |
| `skip_methylation_pileups` | Skip generation of methylation pileups | `boolean` | False |  |  |
| `skip_repeat_calling` | Skip tandem repeat calling | `boolean` | False |  |  |
| `skip_repeat_annotation` | Skip tandem repeat annotation | `boolean` | False |  |  |
| `skip_phasing` | Skip phasing of variants and haplotagging of reads | `boolean` | False |  |  |
| `skip_snv_annotation` | Skip short variant annotation | `boolean` | False |  |  |
| `skip_sv_annotation` | Skip structural variant annotation | `boolean` | False |  |  |
| `skip_cnv_calling` | Skip CNV calling | `boolean` | False |  |  |
| `skip_call_paralogs` | Skip the calling of specific paralogous genes | `boolean` | False |  |  |
| `skip_rank_variants` | Skip ranking of short variants | `boolean` | False |  |  |

## Input/output options

Define where the pipeline should find input data and save output data.

| Parameter | Description | Type | Default | Required | Hidden |
|-----------|-----------|-----------|-----------|-----------|-----------|
| `input` | Path to comma-separated file containing information about the samples in the experiment. <details><summary>Help</summary><small>You will need to create a design file with information about the samples in your experiment before running the pipeline. Use this parameter to specify its location. It has to be a comma-separated file with 3 columns, and a header row.</small></details>| `string` |  | True |  |
| `outdir` | The output directory where the results will be saved. You have to use absolute paths to storage on Cloud infrastructure. | `string` |  | True |  |
| `email` | Email address for completion summary. <details><summary>Help</summary><small>Set this parameter to your e-mail address to get a summary e-mail with details of the run sent to you when the workflow exits. If set in your user config file (`~/.nextflow/config`) then you don't need to specify this on the command line for every run.</small></details>| `string` |  |  |  |
| `multiqc_title` | MultiQC report title. Printed as page header, used for filename if not otherwise specified. | `string` |  |  |  |
| `cadd_prescored_indels` | Path to a directory containing prescored indels for CADD. <details><summary>Help</summary><small>This folder contains the compressed files and indexes that would otherwise be in data/prescored folder as described in https://github.com/kircherlab/CADD-scripts/#manual-installation.</small></details>| `string` |  |  |  |
| `cadd_resources` | Path to a directory containing CADD annotations. <details><summary>Help</summary><small>This folder contains the uncompressed files that would otherwise be in data/annotation folder as described in https://github.com/kircherlab/CADD-scripts/#manual-installation.</small></details>| `string` |  |  |  |
| `par_regions` | Provide a bed file of chrX and chrY PAR regions for dipcall and DeepVariant | `string` |  |  |  |
| `tandem_repeats` | A tandem repeat BED file for sniffles | `string` |  |  |  |
| `trgt_repeats` | A BED file with repeats to be genotyped with TRGT | `string` |  |  |  |
| `echtvar_snv_databases` | A csv file with echtvar databases to annotate SNVs with | `string` |  |  |  |
| `svdb_sv_databases` | Databases used for structural variant annotation in vcf format. <details><summary>Help</summary><small>Path to comma-separated file containing information about the databases used for structural variant annotation.</small></details>| `string` |  |  |  |
| `stranger_repeat_catalog` | A variant catalog json-file for stranger | `string` |  |  |  |
| `variant_consequences_snvs` | File containing list of SO terms listed in the order of severity from most severe to lease severe for annotating genomic SNVs. For more information check https://ensembl.org/info/genome/variation/prediction/predicted_data.html | `string` |  |  |  |
| `variant_consequences_svs` | File containing list of SO terms listed in the order of severity from most severe to lease severe for annotating genomic SVs. For more information check https://ensembl.org/info/genome/variation/prediction/predicted_data.html | `string` |  |  |  |
| `vep_cache` | A path to the VEP cache location | `string` |  |  |  |
| `target_regions` | A BED file with regions of interest, used to limit variant calling. | `string` |  |  |  |
| `hificnv_expected_xy_cn` | A BED file containing expected copy number regions for XY samples. | `string` |  |  |  |
| `hificnv_expected_xx_cn` | A BED file containing expected copy number regions for XX samples. | `string` |  |  |  |
| `hificnv_excluded_regions` | A BED file specifying regions to exclude with HiFiCNV, such as centromeres. | `string` |  |  |  |
| `genmod_reduced_penetrance` | A file with gene ids that have reduced penetrance. For use with genmod. | `string` |  |  |  |
| `genmod_score_config_snvs` | A SNV rank model config file for genmod. | `string` |  |  |  |
| `genmod_score_config_svs` | A SV rank model config file for genmod. | `string` |  |  |  |
| `somalier_sites` | A VCF of known polymorphic sites for somalier | `string` |  |  |  |
| `pipelines_testdata_base_path` | Base URL or local path to location of pipeline test dataset files | `string` | https://raw.githubusercontent.com/genomic-medicine-sweden/test-datasets/630ff7c9bd62f3446070ebd685df380a53926366/ |  | True |
| `trace_report_suffix` | Suffix to add to the trace report filename. Default is the date and time in the format yyyy-MM-dd_HH-mm-ss. | `string` |  |  | True |

## Reference genome options

Reference genome related files and options required for the workflow.

| Parameter | Description | Type | Default | Required | Hidden |
|-----------|-----------|-----------|-----------|-----------|-----------|
| `fasta` | Reference genome | `string` |  |  |  |

## Institutional config options

Parameters used to describe centralised config profiles. These should not be edited.

| Parameter | Description | Type | Default | Required | Hidden |
|-----------|-----------|-----------|-----------|-----------|-----------|
| `custom_config_version` | Git commit id for Institutional configs. | `string` | master |  | True |
| `custom_config_base` | Base directory for Institutional configs. <details><summary>Help</summary><small>If you're running offline, Nextflow will not be able to fetch the institutional config files from the internet. If you don't need them, then this is not a problem. If you do need them, you should download the files from the repo and tell Nextflow where to find them with this parameter.</small></details>| `string` | https://raw.githubusercontent.com/nf-core/configs/master |  | True |
| `config_profile_name` | Institutional config name. | `string` |  |  | True |
| `config_profile_description` | Institutional config description. | `string` |  |  | True |
| `config_profile_contact` | Institutional config contact information. | `string` |  |  | True |
| `config_profile_url` | Institutional config URL link. | `string` |  |  | True |
| `publish_unannotated_svs_and_cnvs_per_family_and_caller` | Publish unannotated SVs and CNVs per family and caller (these files are only output by default if `--skip_sv_annotation` or `--skip_cnv_calling are active). | `boolean` |  |  | True |

## Generic options

Less common options for the pipeline, typically set in a config file.

| Parameter | Description | Type | Default | Required | Hidden |
|-----------|-----------|-----------|-----------|-----------|-----------|
| `version` | Display version and exit. | `boolean` |  |  | True |
| `publish_dir_mode` | Method used to save pipeline results to output directory. <details><summary>Help</summary><small>The Nextflow `publishDir` option specifies which intermediate files should be saved to the output directory. This option tells the pipeline what method should be used to move these files. See [Nextflow docs](https://www.nextflow.io/docs/latest/process.html#publishdir) for details.</small></details>| `string` | copy |  | True |
| `email_on_fail` | Email address for completion summary, only when pipeline fails. <details><summary>Help</summary><small>An email address to send a summary email to when the pipeline is completed - ONLY sent if the pipeline does not exit successfully.</small></details>| `string` |  |  | True |
| `plaintext_email` | Send plain-text email instead of HTML. | `boolean` |  |  | True |
| `max_multiqc_email_size` | File size limit when attaching MultiQC reports to summary emails. | `string` | 25.MB |  | True |
| `monochrome_logs` | Do not use coloured log outputs. | `boolean` |  |  | True |
| `hook_url` | Incoming hook URL for messaging service <details><summary>Help</summary><small>Incoming hook URL for messaging service. Currently, MS Teams and Slack are supported.</small></details>| `string` |  |  | True |
| `multiqc_config` | Custom config file to supply to MultiQC. | `string` |  |  | True |
| `multiqc_logo` | Custom logo file to supply to MultiQC. File name must also be set in the MultiQC config file | `string` |  |  | True |
| `multiqc_methods_description` | Custom MultiQC yaml file containing HTML including a methods description. | `string` |  |  |  |
| `validate_params` | Boolean whether to validate parameters against the schema at runtime | `boolean` | True |  | True |

## Workflow options

Workflow options specific to genomic-medicine-sweden/nallo

| Parameter | Description | Type | Default | Required | Hidden |
|-----------|-----------|-----------|-----------|-----------|-----------|
| `preset` | Enable or disable certain parts of the pipeline by default, depending on data type (`revio`, `pacbio`, `ONT_R10`) | `string` | revio | True |  |
| `snv_caller` | Which short variant software to use (`deepvariant`) | `string` | deepvariant |  |  |
| `sv_caller` | From which SV caller to merge (with CNVs), annotate, rank and filter variants from (`severus` or `sniffles`). | `string` | severus |  |  |
| `phaser` | Which phasing software to use (`longphase`, `whatshap`, `hiphase`) | `string` | longphase |  |  |
| `hifiasm_mode` | Run hifiasm in hifi-only or hifi-trio mode (`hifi-only`, `trio-binning`) | `string` | hifi-only |  |  |
| `hifiasm_preset` | Hifiasm preset, is set to `--ont` when `--profile ONT_R10` is active. | `string` |  |  |  |
| `alignment_processes` | If alignment_processes is bigger than 1, input files will be split and aligned in parallel to reduce processing time. | `integer` | 8 |  |  |
| `snv_calling_processes` | If snv_calling_processes is bigger than 1, short variant calling will be done in parallel to reduce processing time. | `integer` | 13 |  |  |
| `vep_cache_version` | VEP cache version | `integer` | 110 |  |  |
| `vep_plugin_files` | A csv file with vep_files as header, and then paths to vep plugin files. Paths to pLI_values.txt and LoFtool_scores.txt are required. | `string` |  |  |  |
| `filter_variants_hgnc_ids` | A tsv/csv file with a `hgnc_ids` column header, and then one numerical HGNC ID per row. E.g. `4281` or `HGNC:4281`. | `string` |  |  |  |
| `filter_snvs_expression` | An expression that is passed to bcftools view to filter SNVs, e.g. --filter_snvs_expression "-e 'INFO/AQ>60'" | `string` |  |  |  |
| `filter_svs_expression` | An expression that is passed to bcftools view to filter SVs, e.g. --filter_svs_expression "-e 'INFO/AQ>60'" | `string` |  |  |  |
| `deepvariant_model_type` | Sets the model type used for DeepVariant. This is set automatically using `--preset` by default. | `string` | PACBIO |  | True |
| `minimap2_read_mapping_preset` | Sets the minimap2-preset (-x) for read alignment. This is set automatically using the pipeline `--preset` by default. | `string` | map-hifi |  | True |
| `extra_modkit_options` | Extra options to modkit, used for test profile. | `string` |  |  | True |
| `extra_vep_options` | Extra options to VEP, used for test profile. | `string` |  |  | True |
| `extra_paraphase_options` | Extra options to Paraphase, used for test profile. | `string` |  |  | True |
| `extra_hifiasm_options` | Extra options to hifiasm, used for test profile. | `string` |  |  | True |
