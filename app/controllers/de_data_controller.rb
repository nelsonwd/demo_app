require 'rvg/rvg'

include Magick
DEFAULT_FILTER_VALUE = "0.005"
DEFAULT_FILTER = "pval"
DEFAULT_BASE_TREATMENT = "2"
DEFAULT_CLUSTER_NUM = "0"
DEFAULT_ONTOLOGY_ROOT = "Biological Process"
MAP_MAX = 8000


class DeDataController < ApplicationController

  caches_page :go_jason

def go_summary
  @local_url = "http://#{request.host}:#{request.port}"
  @experiment = params[:experiment]
  @analysis_id = params[:analysis_id]
  @base_treatment = (params[:base_treatment])? params[:base_treatment] : DEFAULT_BASE_TREATMENT
  @filter = params[:filter] = (params[:filter])? params[:filter] :  DEFAULT_FILTER
  @filter_value = params[:filter_value] = (params[:filter_value])? params[:filter_value] :  DEFAULT_FILTER_VALUE
  @ontology_root = (params[:ontology_root])?params[:ontology_root] : DEFAULT_ONTOLOGY_ROOT

  respond_to do |format|
    format.html
  end

end




def go_json
  @experiment = params[:experiment]
  fc_table =  get_table @experiment
  analysis_id = params[:analysis_id]
  base_treatment = (params[:base_treatment])? params[:base_treatment] : DEFAULT_BASE_TREATMENT
  filter = params[:filter] = (params[:filter])? params[:filter] :  DEFAULT_FILTER
  filter_value = params[:filter_value] = (params[:filter_value])? params[:filter_value] :  DEFAULT_FILTER_VALUE
  ontology_root = (params[:ontology_root])?params[:ontology_root] : DEFAULT_ONTOLOGY_ROOT
  filter_string = filter_sql filter, filter_value, fc_table.table_name

  filtered_seq_ids = get_filtered_seq_ids(fc_table, analysis_id, base_treatment, filter_string)

  heat_hash = get_filtered_seq_ids_with_go_data( filtered_seq_ids, fc_table, analysis_id, base_treatment, ontology_root)


  respond_to do |format|
    format.json{
      render :json => heat_hash
    }
  end
end

def cluster_annot
    experiment = params[:experiment]
    @title = experiment.camelcase
    fc_table =  get_table experiment
    analysis_id = params[:analysis_id]
    base_treatment = (params[:base_treatment])? params[:base_treatment] : DEFAULT_BASE_TREATMENT
    default_cluster_order =  ["1","2","3","4"];
    default_cluster_order.delete(base_treatment)
    order_array =  (params[:cluster] && params[:cluster].count(base_treatment) == 0) ? params[:cluster].split(',') : default_cluster_order
    filter = params[:filter] = (params[:filter])? params[:filter] :  DEFAULT_FILTER
    filter_value = params[:filter_value] = (params[:filter_value])? params[:filter_value] :  DEFAULT_FILTER_VALUE
    default_cluster_num = (params[:cluster_num]) ? params[:cluster_num] : DEFAULT_CLUSTER_NUM
    filter_string = filter_sql filter, filter_value, fc_table.table_name
    results_hash ={}
    # Get all sequence ids that pass the filter in at least
    seq_ids = get_filtered_seq_ids(fc_table, analysis_id, base_treatment, filter_string)

    #Group the ids into clusters as an array of arrays
    seq_id_clusters = clusterfy(fc_table, order_array, seq_ids,base_treatment, analysis_id, filter_value, filter)

    #create an array of clusters
    cluster_count = seq_id_clusters.size
    fc_base = []
    @seq_clusters = {}

    #Get the data for the desired cluster
    fc_base = fc_table.includes({:sequence => :blast_db}, :de_datum, :treatment).where( :de_analysis_id => analysis_id, :base_treatment_id => base_treatment, :sequence_id => seq_id_clusters[default_cluster_num.to_i])
    fc_base.each do |d|
      ordering = d.treatment.ordering.to_s
      treatment_index = order_array.index(ordering)
      @seq_clusters[ d.sequence ]= Array.new(3) if @seq_clusters[ d.sequence ].nil?
      @seq_clusters[ d.sequence ][treatment_index] = d.log2fc
    end
    @seq_clusters
    respond_to do |format|
      format.js
      format.html # show.html.erb
    end
  end


  # GET /heatmap
  def heatmap
    experiment = params[:experiment]
    @title = experiment.camelcase
    fc_table_name = experiment + "_fold_changes"
    fc_table =  Kernel.const_get(experiment.camelcase + "FoldChange")
    analysis_id = params[:analysis_id]
    base_treatment = (params[:base_treatment])? params[:base_treatment] : DEFAULT_BASE_TREATMENT
    default_cluster_order =  ["1","2","3","4"];
    default_cluster_order.delete(base_treatment)
    order_array =  (params[:cluster] && params[:cluster].count(base_treatment) == 0) ? params[:cluster].split(',') : default_cluster_order
    filter = params[:filter] = (params[:filter])? params[:filter] :  DEFAULT_FILTER
    filter_value = params[:filter_value] = (params[:filter_value])? params[:filter_value] :  DEFAULT_FILTER_VALUE
    filter_string = filter_sql filter, filter_value, fc_table_name
    results_hash ={}
    seq_ids = get_filtered_seq_ids(fc_table, analysis_id, base_treatment, filter_string)

    uniq_seq_ids = clusterfy(fc_table, order_array, seq_ids,base_treatment, analysis_id, filter_value, filter)
#create an array of clusters
    @cluster_count = uniq_seq_ids.size
    fc_base = []
    @seq_clusters = {}
#Get the data for each cluster
    first_clust = true
    uniq_seq_ids.each do |clust|
      fc_clust = fc_table.includes({:sequence => :blast_db}, :de_datum, :treatment).where( :de_analysis_id => analysis_id, :base_treatment_id => base_treatment, :sequence_id => clust)
      fc_base += fc_clust
      if first_clust
        seq_clust = {}
        fc_clust.each do |d|
          ordering = d.treatment.ordering.to_s
          treatment_index = order_array.index(ordering)
          @seq_clusters[ d.sequence ]= Array.new(3) if @seq_clusters[ d.sequence ].nil?
          @seq_clusters[ d.sequence ][treatment_index] = d.log2fc
        end
        first_clust = false
      end
    end
#create a result hash :sequenc.accession => [[1],[3],[4]]
    fc_base.each do |d|
      if (results_hash[d.sequence].nil?)
        results_hash[d.sequence] = [[],[],[],[]]
        bt_abundance = DeDatum.where(:sequence_id => d.sequence_id, :treatment_id => d.base_treatment_id, :de_analysis_id => d.de_analysis_id).first.abundance
        results_hash[d.sequence][d.base_treatment_id]= [bt_abundance, "N/A","black"]
      end
      results_hash[d.sequence][d.treatment_id] = [d.de_datum.abundance, d.log2fc, de_color(filter, filter_value, d)]
    end
    @seq_count = results_hash.size
    @map_image = draw_map(order_array,results_hash)
    respond_to do |format|
      format.html # show.html.erb
    end
  end
  # GET /de_data
  # GET /de_data.xml
  def index
    per_page=25
    @tab = params[:tab] ? params[:tab] : "0"
    @experiment     = params[:experiment]
    @title = @experiment.camelcase
    @analysis_id    = params[:analysis_id]
    @base_treatment = (params[:base_treatment])? params[:base_treatment] : DEFAULT_BASE_TREATMENT
    @order_by       = params[:order_by] = (params[:order_by])? params[:order_by] : "pval"
    @filter         = params[:filter] = (params[:filter])? params[:filter] : "pval"
    @filter_value   = params[:filter_value] = (params[:filter_value])? params[:filter_value] : "0.005"
    @page           = (params[:page])? params[:page] : "1"
    @query          = (params[:search_value]) ?  params[:search_value] : ''
    download = (params[:commit] == 'Download') ? true : false
    offset         = (@page.to_i - 1) * per_page
    fc_table_name = @experiment + "_fold_changes"
    treatment_string = treatment_sql @tab, @base_treatment, fc_table_name
    filter_string = filter_sql @filter, @filter_value, fc_table_name
    order_string = order_sql @order_by, fc_table_name
    flash.delete :notice
    search_string = search_sql @query
    flash[:notice] = "No matches found for the query \'#{@query}" if search_string =~ /\(0\)/
    fc_table =  Kernel.const_get(@experiment.camelcase + "FoldChange")
    file_name = "#{@experiment}#{@analysis_id}#{@base_treatment}#{@filter_value}#{@query.hash}.csv"
    report_url =  "/tmp/" + file_name
    if(download && File.exists?("public" + report_url))
      redirect_to report_url
      return
    end



    count =  fc_table.find_by_sql("select distinct(#{fc_table_name}.sequence_id) " +
                                         "from  #{fc_table_name}, de_data " +
                                         "where #{fc_table_name}.de_analysis_id = #{@analysis_id} and " +
                                         "      #{fc_table_name}.base_treatment_id = #{@base_treatment} and" +
                                         "      #{fc_table_name}.de_datum_id = de_data.id and" +
                                         "      #{filter_string} " +
                                         "      #{search_string} " +
                                         "      #{treatment_string} " +
                                         "      de_data.abundance > 0").size
    @total_pages = count / per_page
    @total_pages += 1 if ((count % per_page) != 0)
    if download
      per_page = count
      offset = 0
    end
    @results_hash ={}
      uniq_seq_ids =  fc_table.find_by_sql("select distinct(#{fc_table_name}.sequence_id) " +
                                         "from  #{fc_table_name}, de_data " +
                                         "where #{fc_table_name}.de_analysis_id = #{@analysis_id} and " +
                                         "      #{fc_table_name}.base_treatment_id = #{@base_treatment} and" +
                                         "      #{fc_table_name}.de_datum_id = de_data.id and" +
                                         "      #{filter_string} " +
                                         "      #{search_string} " +
                                         "      #{treatment_string} " +
                                         "      de_data.abundance > 0 " +
                                         "      order by #{order_string} " +
                                         "limit #{per_page} " +
                                         "offset #{offset} ").map{|x| x.sequence_id}
      fc_base = fc_table.includes({:sequence => :blast_db}, :de_datum).where( :de_analysis_id => @analysis_id, :base_treatment_id => @base_treatment, :sequence_id => uniq_seq_ids).order(order_string)



    fc_base.each do |d|
      if (@results_hash[d.sequence].nil?)
        @results_hash[d.sequence] = [[],[],[],[]]
        bt_abundance = DeDatum.where(:sequence_id => d.sequence_id, :treatment_id => d.base_treatment_id, :de_analysis_id => d.de_analysis_id).first.abundance
        @results_hash[d.sequence][d.base_treatment_id]= [bt_abundance,"N/A", "N/A","black"]
      end
      @results_hash[d.sequence][d.treatment_id] = [d.de_datum.abundance, d.log2fc, d.pval, de_color(@filter, @filter_value, d)]
    end

    @annotation_hash = create_annotation_results @results_hash

    if download
      redirect_to create_report_file(@results_hash, @annotation_hash, report_url)
      return
    end

    respond_to do |format|
      format.html # index.html.erb
    end
  end


  # GET /de_data/1
  # GET /de_data/1.xml
  def show
    @de_datum = DeDatum.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @de_datum }
    end
  end

  # GET /de_data/new
  # GET /de_data/new.xml
  def new
    @de_datum = DeDatum.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @de_datum }
    end
  end

  # GET /de_data/1/edit
  def edit
    @de_datum = DeDatum.find(params[:id])
  end

  # POST /de_data
  # POST /de_data.xml
  def create
    @de_datum = DeDatum.new(params[:de_datum])

    respond_to do |format|
      if @de_datum.save
        format.html { redirect_to(@de_datum, :notice => 'De datum was successfully created.') }
        format.xml  { render :xml => @de_datum, :status => :created, :location => @de_datum }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @de_datum.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /de_data/1
  # PUT /de_data/1.xml
  def update
    @de_datum = DeDatum.find(params[:id])

    respond_to do |format|
      if @de_datum.update_attributes(params[:de_datum])
        format.html { redirect_to(@de_datum, :notice => 'De datum was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @de_datum.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /de_data/1
  # DELETE /de_data/1.xml
  def destroy
    @de_datum = DeDatum.find(params[:id])
    @de_datum.destroy

    respond_to do |format|
      format.html { redirect_to(de_data_url) }
      format.xml  { head :ok }
    end
  end
end

def treatment_sql(tab, base_treatment, fc_table_name)
  if tab.empty? || tab == "0"
    ""
  else
    treatment_tabs  = [0,1,2,3,4] - [base_treatment.to_i]
    "#{fc_table_name}.treatment_id = #{treatment_tabs[tab.to_i]} and "
  end
end

def filter_sql(filter, filter_value, fc_table_name)
  if filter_value.empty?
   ""
  elsif is_a_number?(filter_value)
    "#{fc_table_name}.#{filter} < #{filter_value} and "
  else
    flash[:error] = "\"#{filter_value}\" is not a valid filter entry"
    redirect_to( :back)
    ""
  end
end

def order_sql(order_by, fc_table_name)
  if order_by == "pval" || order_by == "fdr"
    order_by
  elsif order_by == "-log2fc"
    "log2fc"
  elsif order_by == "+log2fc"
    "log2fc desc"
  elsif order_by == "+rpkm"
    "de_data.abundance desc"
  elsif order_by == "-rpkm"
    "de_data.abundance"
  end
end

def is_a_number?(s)
  s.to_s.match(/\A[+-.]?\d+?(\.\d+)?\Z/) == nil ? false : true
end


def clusterfy(fc_table, order_array, uniq_seq_ids, base_treatment, analysis_id, filter_value, filter)
     top_clusters = up_middle_down_split(fc_table, order_array[0], uniq_seq_ids, base_treatment, analysis_id, filter_value, filter )
     middle_clusters = []
     top_clusters.each do |seq_ids|
       tmp_clusters =  up_middle_down_split(fc_table, order_array[1],seq_ids, base_treatment, analysis_id, filter_value, filter)
       middle_clusters +=  tmp_clusters
     end
     bottom_clusters = []
     middle_clusters.each do |seq_ids|
       bottom_clusters +=  up_middle_down_split(fc_table, order_array[2], seq_ids, base_treatment, analysis_id, filter_value, filter)
     end
     bottom_clusters

end

def up_middle_down_split(fc_table, treatment, uniq_seq_ids,base_treatment, analysis_id, filter_value, filter)
    clusters = []
    fc_table_name = fc_table.table_name
    cluster_filter = (filter_value.empty?) ? 2 : filter_value
    filter_strings = ["#{fc_table_name}.log2fc < 0 and #{fc_table_name}.#{filter} < #{cluster_filter} and ",
                      "#{fc_table_name}.#{filter} >= #{cluster_filter} and ",
                      "#{fc_table_name}.log2fc > 0 and #{fc_table_name}.#{filter} < #{cluster_filter} and "]
      (0..2).each do |count|
         seq_ids = fc_table.find_by_sql("select distinct(#{fc_table_name}.sequence_id) " +
                                         "from  #{fc_table_name}, de_data " +
                                         "where #{fc_table_name}.de_analysis_id = #{analysis_id} and " +
                                         "      #{fc_table_name}.treatment_id = #{treatment} and " +
                                         "      #{fc_table_name}.base_treatment_id = #{base_treatment} and " +
                                         "      #{fc_table_name}.de_datum_id = de_data.id and " +
                                                filter_strings[count] +
                                         "      #{fc_table_name}.sequence_id in (#{uniq_seq_ids.join(',')})").map{|x| x.sequence_id}
         clusters[count] = seq_ids if seq_ids.size > 0
         seq_ids = []
      end
    clusters.compact
end

def draw_map(order, results_hash)
   cluster_count = 0
   y_pos = 0
   row_hgt = 2
   g_wdt = 300
   g_hgt = results_hash.size * row_hgt
   g_hgt_in = g_hgt/100.0
   RVG::dpi = 72
   area_tags = []
   rvg = RVG.new(3.0.in, g_hgt_in.in).viewbox(0,0, g_wdt, g_hgt) do |canvas|
     canvas.background_fill = 'white'
     start_coords = "0,0"
     prev_cluster_tag = ""
     area_tags = []
     results_hash.each_pair do |seq, treatment_hash|
       col1 = treatment_hash[order[0].to_i]
       col2 = treatment_hash[order[1].to_i]
       col3 = treatment_hash[order[2].to_i]
       cluster_tag = col1[2] + col2[2] + col3[2]
       if cluster_tag != prev_cluster_tag then
         unless cluster_count == 0
           area_tags << "<area shape=\"rect\" coords=\"#{start_coords},#{g_wdt},#{y_pos}\" title=\"cluster #{cluster_count}\" onclick=\"document.getElementById('cluster_num').selectedIndex = #{cluster_count - 1};document.getElementById('cluster_num').onchange();\" />"
           start_coords = "0,#{y_pos}"
         end
         cluster_count += 1
       end
       canvas.g.translate(0, y_pos) do |query|
         query.rect(100, row_hgt).styles(:stroke=> col1[2], :fill=> col1[2])
       end
       canvas.g.translate(101, y_pos) do |query|
         query.rect(100, row_hgt).styles(:stroke=> col2[2], :fill=> col2[2])
       end
       canvas.g.translate(201, y_pos) do |query|
         query.rect(100, row_hgt).styles(:stroke=> col3[2], :fill=> col3[2])
       end
       y_pos +=  row_hgt
       prev_cluster_tag = cluster_tag
     end
     area_tags << "<area shape=\"rect\" coords=\"#{start_coords},#{g_wdt},#{y_pos}\" title=\"cluster #{cluster_count}\" onclick=\"document.getElementById('cluster_num').selectedIndex = #{cluster_count - 1};document.getElementById('cluster_num').onchange();\" />"
   end
   rvg.draw.write("public/tmp/#{@title}-#{rvg.object_id}.gif")
               "<img src=\"/tmp/#{@title}-#{rvg.object_id}.gif\" width=\"300\" height=\"#{g_hgt}\"  alt=\"heatmap\" usemap=\"#heatmap\" >\n" +
               "<map name=\"heatmap\" >\n" +
               area_tags.join("\n") +
               "</map>"
end

def de_color(filter, filter_value, d)
  return "black" if d.log2fc == 0
  if filter == 'fdr'
    return 'black'  if d.fdr > filter_value.to_f
  else
    return 'black' if d.pval > filter_value.to_f
  end

  if d.log2fc > 0
    'orange'
  elsif d.log2fc < 0
    'blue'
  else
    'black'
  end
end

# Get all sequence ids that pass the filter in at least
def get_filtered_seq_ids(fc_table, analysis_id, base_treatment, filter_string)
    fc_table_name = fc_table.table_name
    fc_table.find_by_sql("select distinct(#{fc_table_name}.sequence_id) " +
                                    "from  #{fc_table_name}, de_data " +
                                    "where #{fc_table_name}.de_analysis_id = #{analysis_id} and " +
                                    "      #{fc_table_name}.base_treatment_id = #{base_treatment} and" +
                                    "      #{fc_table_name}.de_datum_id = de_data.id and" +
                                    "      #{filter_string} " +
                                    "      de_data.abundance > 0").map{|x| x.sequence_id}
end

def get_filtered_seq_ids_with_go_data( filtered_seq_ids, fc_table, analysis_id, base_treatment, ontology_root)

  go_hash = {}
  result_hash = {}

  go = GeneOntology.includes(:go_slim_sequences => :sequence).
      where(:ontology_root => ontology_root, 'sequences.id' => filtered_seq_ids)
  go.map do |g|
    unless go_hash.has_key?  g.label
      go_hash[g.label] = g.go_slim_sequences.map{|s|s.sequence}
    end
    go_hash[g.label] + g.go_slim_sequences.map{|s|s.sequence}
  end

  go_hash.each_pair do |go, sequences|
    result_hash[go] = GoHeatMap.new
    sequences.each_with_index do |sq, i|
      fcs = fc_table.includes(:treatment).where(:sequence_id => sq.id,:de_analysis_id => analysis_id, :base_treatment_id => base_treatment).
        order(:treatment_id)
      result_hash[go].treatments = fcs.map{|t| t.treatment.name}
      result_hash[go].accessions << sq.accession
      anArray = []
      fcs.each_with_index{|t,y| anArray <<[t.log2fc,i,y]}
      result_hash[go].log2fc << anArray
    end
  end

  result_hash
end


def get_table(experiment_name)
   Kernel.const_get(experiment_name.camelcase + "FoldChange")
end

def create_report_file results_hash, annotation_results, report_url
  out_file = File.open("public#{report_url}", 'w')
  out_file.write( "Sequence\t0-RPKM\t0-Log2FC\t0-pval\t10-RPKM\t10-Log2FC\t10-pval\t100-RPKM\t100-Log2FC\t100-pval\t500-RPKM\t500-Log2FC\t500-pval\tUniProt\tNCBInt\tNCBInr\tMapMan\tInterPro\n")
  results_hash.each_pair do |seq,d_array|
    annotation_hash = annotation_results[seq]
    out_file.write "#{seq.accession}\t#{d_array[1][0]}\t#{d_array[1][1]}\t#{d_array[1][2]}\t#{d_array[2][0]}\t#{d_array[2][1]}\t#{d_array[2][2]}\t#{d_array[3][0]}\t#{d_array[3][1]}\t#{d_array[3][2]}\t#{d_array[4][0]}\t#{d_array[4][1]}\t#{d_array[4][2]}\t#{annotation_hash[:UniProt]}\t#{annotation_hash[:NCBInt]}\t#{annotation_hash[:NCBInr]}\t#{annotation_hash[:MapMan]}\t#{annotation_hash[:InterPro]}\n"
  end
  out_file.close
  report_url
end

def create_annotation_results results_hash
  annotation_hash = {}
  results_hash.each_pair do |seq,d_array|
    annotation_hash[seq] = create_annotation seq
  end
  annotation_hash
end

def create_annotation seq
  annotation_hash = {UniProt: 'n/a', NCBInt: 'n/a', NCBInr: 'n/a', MapMan: 'n/a', InterPro: 'n/a' }

  feats = seq.features.select {|f| (f.annotation.interpro.nil? && f.annotation.annotation_source.name =~ /UniProt|NCBInt|NCBInr/) }
  feats.map do |f|
    if f.annotation.annotation_source.name =~ /UniProt/
      annotation_hash[:UniProt] = f.annotation.description
    elsif f.annotation.annotation_source.name =~ /NCBInt/
      nt_debug = f.annotation.description
      annotation_hash[:NCBInt] = f.annotation.description
      nt_double_debug =  annotation_hash[:NCBInt]
    elsif f.annotation.annotation_source.name =~ /NCBInr/
      annotation_hash[:NCBInr] = f.annotation.description
    end

  end
  feats = seq.features.select {|f| (f.annotation.interpro.nil? && f.annotation.annotation_source.name =~ /MapMan/) }
  feats.map do |f|
    annotation_hash[:MapMan] = f.annotation.accession
  end
  interpro = seq.features.map {|f| f.annotation.interpro.description unless f.annotation.interpro.nil?}.compact.uniq.join('; ')
  annotation_hash[:InterPro] = interpro  unless  interpro.blank?
  annotation_hash

end

def search_sql query
  return '' if query.blank?
  goes = GeneOntology.where("keyword LIKE  '%#{query}%'")
  iprs = goes.uniq.map do |g|
    g.interpros
  end
  iprs << Interpro.where("description LIKE '%#{query}%'")
  iprs.flatten!
  annots = iprs.uniq.map do |i|
    i.annotations
  end
  annots << Annotation.where("description LIKE '%#{query}%'")
  annots.flatten!
  feats = annots.uniq.map do |a|
    a.features
  end
  feats.flatten!
  result = feats.uniq.map do |f|
    f.sequence_id
  end
  if result.size > 0
    "de_data.sequence_id IN (#{result.join(',')}) and"
  else
    "de_data.sequence_id IN (0) and"
  end
end


