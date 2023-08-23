version 1.0

workflow fastqgz_subsample {
  input {
    File fastqgz_file
  }
  call sample_file {
    input: 
      fastqgz_file = fastqgz_file
  }
  output {
    File read1_subset = sample_file.read1_subset
  }
}

task sample_file {
  input {
    File fastqgz_file
  }
  command <<<
    echo "input file: ~{fastqgz_file}"
    
    seqtk
    seqtk sample -s11 ~{fastqgz_file} 1000 > 1_sub.fq
  >>>
  output {
    File read1_subset="1_sub.fq"
  }
  runtime {
    docker: "quay.io/biocontainers/seqtk:1.3--hed695b0_2"
    memory:"8 GB"
    cpu: 2
    disks: "local-disk 100 SSD"
    preemptible:  1
  }
}