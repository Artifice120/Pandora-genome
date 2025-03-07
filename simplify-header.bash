#!bin/bash/

awk 'BEGIN{count=1}{if($1 ~ />/) { print ">"count ;  count=count+1 } else { print $0 }  }' /lustre/isaac/scratch/madler5/blue_pandora_seq/gDNA_pacbio_ONT/PacBio_Hifi_20250103/blue_pand_pacbio.fasta > simp-header.fasta
