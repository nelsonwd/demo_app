class Feature < ActiveRecord::Base
belongs_to :sequence
belongs_to :annotation

  #parses out the sequence accession number and frame
  def acc_frame acc
    acc.chomp!
    
    parts = acc.split('-')
    name = parts[0]
    frame = (parts[1].nil?)? 0 : parts[1] 
    #fix name 
    #n_p = name.split("_")
    #fixed_name = "#{n_p[0]}_#{n_p[1]}_#{n_p[2]}_#{n_p[3]}/#{n_p[4]}_#{n_p[5]}_#{n_p[6]}_#{n_p[7]}_#{n_p[8]}"
    [name, frame]
  end

  def go_terms terms
    terms.chomp!
    returnOtologies = []
    terms = terms[0..(terms.size - 2)]
    go_list = terms.split("),")
    go_list.each do |g| 
      #puts "GO ENTRY: " + g
      parts1 = g.split("(")
      #puts "GO ACC: " + parts1[1]
      parts2 = parts1[0].split(":")
      #puts "GO TERM: " + parts2[0]
      #puts "GO DESC: " + parts2[1]
      returnOtologies << GeneOntology.find_or_create_by_accession(parts1[1], :ontology_root =>  parts2[0], :keyword => parts2[1])
    end
    returnOtologies
  end


  def init_annot_src
    AnnotationSource.find_or_create_by_name("HMMSmart", :url => "http://smart.embl-heidelberg.de/smart/do_annotation.pl?BLAST=DUMMY&DOMAIN=@@")
    AnnotationSource.find_or_create_by_name("HMMPIR", :url => "http://pir.georgetown.edu/cgi-bin/ipcSF?id=@@")
    AnnotationSource.find_or_create_by_name("superfamily", :url => "http://supfam.org/SUPERFAMILY/cgi-bin/scop.cgi?ipid=@@")
    AnnotationSource.find_or_create_by_name("ProfileScan", :url => "http://prosite.expasy.org/@@")
    AnnotationSource.find_or_create_by_name("PatternScan", :url => "http://prosite.expasy.org/@@")
    AnnotationSource.find_or_create_by_name("Gene3D", :url => "http://www.cathdb.info/gene3d/@@")
    AnnotationSource.find_or_create_by_name("Seg", :url => "http://www0.hku.hk/bruhk/gcgdoc/seg.html")
    AnnotationSource.find_or_create_by_name("Coil", :url => "http://www.ch.embnet.org/software/COILS_form.html")
    AnnotationSource.find_or_create_by_name("HMMPfam", :url => "http://pfam.sanger.ac.uk/family/@@")
    AnnotationSource.find_or_create_by_name("FPrintScan", :url => "http://bioinf.man.ac.uk/cgi-bin/dbbrowser/sprint/searchprintss.cgi?display_opts=Prints&category=None&queryform=false&prints_accn=@@")
    AnnotationSource.find_or_create_by_name("HMMPanther", :url => "http://www.pantherdb.org/panther/family.do?clsAccession=@@")
    AnnotationSource.find_or_create_by_name("HAMAP", :url => "http://hamap.expasy.org/unirule/@@")
    AnnotationSource.find_or_create_by_name("HMMTigr", :url => "http://cmr.jcvi.org/tigr-scripts/CMR/HmmReport.cgi?hmm_acc=@@")
    AnnotationSource.find_or_create_by_name("BlastProDom", :url => "http://prodom.prabi.fr/prodom/current/cgi-bin/request.pl?SSID=1289309949_1085&db_ent1=@@")
    AnnotationSource.find_or_create_by_name("NCBInt", :url => "http://www.ncbi.nlm.nih.gov/nuccore/@@")
    AnnotationSource.find_or_create_by_name("NCBInr", :url => "http://www.ncbi.nlm.nih.gov/protein/@@")
    AnnotationSource.find_or_create_by_name("UniProt", :url => "http://www.uniprot.org/uniprot/@@")
  end

# 0 =  accession-frameNum
# 3 =  annotation source application
# 4 =  application accession 
# 5 =  application description
# 6 =  start_pos
# 7 =  end_pos
# 8 =  score
# 11 = IPR accession
# 12 = IPR description
# 13 = GO keyword and accessions

  def load_interpro file_name
    file = File.open("#{Rails.root}/#{file_name}", 'rb')
    init_annot_src
    while(line = file.gets)
      parts = line.split("\t")
      seq_name, frame = acc_frame parts[0]
      #frame = a_f[1]
      #seq_name, desc = Sequence.parse_accession(a_f[0], "symb2master")
      seq = Sequence.where( :accession => seq_name ).first
      gene_onts = []
      ipr = nil
      gene_onts = go_terms parts[13] unless parts[13].blank?
      annot_src = AnnotationSource.where(:name => parts[3]).first
      unless (parts[11] == "NULL")
        ipr = Interpro.find_or_create_by_accession(parts[11], :description => parts[12])
        gene_onts.each do |g_o|
          ipr.gene_ontologies<<g_o unless ipr.gene_ontologies.include?(g_o)
        end
      end
      annot = Annotation.find_or_create_by_accession(parts[4], :description => parts[5],:annotation_source => annot_src, :interpro => ipr )
      feat =  Feature.create( :sequence_id => seq.id, :annotation_id => annot.id, :start_pos => parts[6], :end_pos => parts[7], :frame => frame, :score => parts[8], :match_status => parts[9]) rescue []
    end
  end

  def load_blast file_name, db
    file = File.open("#{Rails.root}/#{file_name}", 'rb')
    init_annot_src
    annot_src = AnnotationSource.where(:name => db).first
    while(line = file.gets)
      parts = line.split("\t")
      seq = Sequence.where( :accession => parts[0] ).first
      annot = Annotation.find_or_create_by_accession(parts[7], :description => parts[8].strip,:annotation_source => annot_src, :interpro => nil )

      Feature.create( :sequence_id => seq.id, :annotation_id => annot.id, :start_pos => parts[4], :end_pos => parts[5], :frame => parts[6], :score => parts[1], :match_status => nil) rescue []
    end
  end

  def load_blast_nt file_name
    load_blast file_name, 'NCBInt'
  end

  def load_blast_nr file_name
    load_blast file_name, 'NCBInr'
  end

  def load_blast_uniprot file_name
    load_blast file_name, 'UniProt'
  end

  def annotation_string
    if annotation.annotation_source.name == 'NCBInt'
      frame_char = frame == 1 ? ?+ : ?-
    else
      frame_char = frame
    end
    url = annotation.annotation_source.url.sub(/@@/, annotation.accession)
    "<a href=\'#{url}\'>#{annotation.accession}</a> #{annotation.description}<br> eVal: #{score} location: #{start_pos}-#{end_pos}(#{frame_char})"
  end
end
