require 'rvg/rvg'

include Magick
DEFAULT_FILTER_VALUE = "0.005"
DEFAULT_FILTER = "pval"
DEFAULT_BASE_TREATMENT = "2"

class DeDataController < ApplicationController


  # GET /heatmap
  def heatmap
    experiment = params[:experiment]
    @title = experiment.camelcase
    fc_table_name = experiment + "_fold_changes"
    fc_table =  Kernel.const_get(experiment.camelcase + "FoldChange") 
    @analysis_id = params[:analysis_id]
    @base_treatment = (params[:base_treatment])? params[:base_treatment] : DEFAULT_BASE_TREATMENT
    default_cluster_order =  ["1","2","3","4"]; 
    default_cluster_order.delete(@base_treatment)
    order_array =  (params[:cluster] && params[:cluster].count(@base_treatment) == 0) ? params[:cluster].split(',') : default_cluster_order
    @filter = params[:filter] = (params[:filter])? params[:filter] :  DEFAULT_FILTER
    @filter_value = params[:filter_value] = (params[:filter_value])? params[:filter_value] :  DEFAULT_FILTER_VALUE
    filter_string = filter_sql @filter, @filter_value, fc_table_name
    results_hash ={}
    seq_ids =  fc_table.find_by_sql("select distinct(#{fc_table_name}.sequence_id) " +
                                    "from  #{fc_table_name}, de_data " +
                                    "where #{fc_table_name}.de_analysis_id = #{@analysis_id} and " +
                                    "      #{fc_table_name}.base_treatment_id = #{@base_treatment} and" +
                                    "      #{fc_table_name}.de_datum_id = de_data.id and" +
                                    "      #{filter_string} " +
                                    "      de_data.abundance > 0").map{|x| x.sequence_id} 
    uniq_seq_ids = clusterfy(fc_table, order_array, seq_ids)
#create an array of clusters
    @cluster_count = uniq_seq_ids.size
    fc_base = []
    @seq_clusters = []
#Get the data for each cluster
    uniq_seq_ids.each do |clust|
      fc_clust = fc_table.includes({:sequence => :blast_db}, :de_datum).where( :de_analysis_id => @analysis_id, :base_treatment_id => @base_treatment, :sequence_id => clust)
      fc_base += fc_clust
      seq_clust = []
      fc_clust.each do |d|
        seq_clust << d.sequence
      end
      @seq_clusters << seq_clust.uniq
    end
#create a result hash :sequenc.accession => [[1],[3],[4]]
    fc_base.each do |d| 
      if (results_hash[d.sequence].nil?)
        results_hash[d.sequence] = [[],[],[],[]] 
        bt_abundance = DeDatum.where(:sequence_id => d.sequence_id, :treatment_id => d.base_treatment_id, :de_analysis_id => d.de_analysis_id).first.abundance      
        results_hash[d.sequence][d.base_treatment_id]= [bt_abundance, "N/A","black"]
      end
      results_hash[d.sequence][d.treatment_id] = [d.de_datum.abundance, d.log2fc, de_color(@filter, @filter_value, d)]
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
    @experiment     = params[:experiment]
    @title = @experiment.camelcase
    @analysis_id    = params[:analysis_id]
    @base_treatment = (params[:base_treatment])? params[:base_treatment] : DEFAULT_BASE_TREATMENT
    default_treatment  = ([1,2,3,4] - [@base_treatment.to_i]).first
    @treatment      = (params[:treatment])? params[:treatment] : default_treatment
    @order_by = params[:order_by] = (params[:order_by])? params[:order_by] : "pval"
    @filter = params[:filter] = (params[:filter])? params[:filter] : "pval" 
    @filter_value = params[:filter_value] = (params[:filter_value])? params[:filter_value] : "0.005" 
    @page           = (params[:page])? params[:page] : "1"
    offset         = (@page.to_i - 1) * per_page
    fc_table_name = @experiment + "_fold_changes"
    filter_string = filter_sql @filter, @filter_value, fc_table_name
    order_string = order_sql @order_by, fc_table_name
    fc_table =  Kernel.const_get(@experiment.camelcase + "FoldChange") 
    
    count =  fc_table.find_by_sql("select distinct(#{fc_table_name}.sequence_id) " +
                                         "from  #{fc_table_name}, de_data " +
                                         "where #{fc_table_name}.de_analysis_id = #{@analysis_id} and " +
                                         "      #{fc_table_name}.base_treatment_id = #{@base_treatment} and" +
                                         "      #{fc_table_name}.de_datum_id = de_data.id and" +
                                         "      #{filter_string} " +
                                         "      de_data.abundance > 0").size 
    @total_pages = count / per_page
    @total_pages += 1 if ((count % per_page) != 0)
    @results_hash ={}
      uniq_seq_ids =  fc_table.find_by_sql("select distinct(#{fc_table_name}.sequence_id) " +
                                         "from  #{fc_table_name}, de_data " +
                                         "where #{fc_table_name}.de_analysis_id = #{@analysis_id} and " +
                                         "      #{fc_table_name}.base_treatment_id = #{@base_treatment} and" +
                                         "      #{fc_table_name}.de_datum_id = de_data.id and" +
                                         "      #{filter_string} " +
                                         "      de_data.abundance > 0 " +
                                         "      order by #{order_string} " +
                                         "limit #{per_page} " +
                                         "offset #{offset} ").map{|x| x.sequence_id} 
      fc_base = fc_table.includes({:sequence => :blast_db}, :de_datum).where( :de_analysis_id => @analysis_id, :base_treatment_id => @base_treatment, :sequence_id => uniq_seq_ids).order(order_string)


    fc_base.each do |d| 
      if (@results_hash[d.sequence].nil?)
        @results_hash[d.sequence] = [[],[],[],[]] 
        bt_abundance = DeDatum.where(:sequence_id => d.sequence_id, :treatment_id => d.base_treatment_id, :de_analysis_id => d.de_analysis_id).first.abundance      
        @results_hash[d.sequence][d.base_treatment_id]= [bt_abundance, "N/A","black"]
      end
      @results_hash[d.sequence][d.treatment_id] = [d.de_datum.abundance, d.log2fc, de_color(@filter, @filter_value, d)]
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


def clusterfy(fc_table, order_array, uniq_seq_ids)
     top_clusters = up_middle_down_split(fc_table, order_array[0], uniq_seq_ids )
     middle_clusters = []
     top_clusters.each do |seq_ids|
       tmp_clusters =  up_middle_down_split(fc_table, order_array[1],seq_ids)
       middle_clusters +=  tmp_clusters
     end
     bottom_clusters = []
     middle_clusters.each do |seq_ids|
       bottom_clusters +=  up_middle_down_split(fc_table, order_array[2], seq_ids)
     end
     bottom_clusters
     
end

def up_middle_down_split(fc_table, treatment, uniq_seq_ids)
    clusters = []
    fc_table_name = fc_table.table_name
    cluster_filter = (@filter_value.empty?) ? 2 : @filter_value
    filter_strings = ["#{fc_table_name}.log2fc < 0 and #{fc_table_name}.#{@filter} < #{cluster_filter} and ",
                      "#{fc_table_name}.#{@filter} >= #{cluster_filter} and ",
                      "#{fc_table_name}.log2fc > 0 and #{fc_table_name}.#{@filter} < #{cluster_filter} and "]
     (0..2).each do |count|
         seq_ids = fc_table.find_by_sql("select distinct(#{fc_table_name}.sequence_id) " +
                                         "from  #{fc_table_name}, de_data " +
                                         "where #{fc_table_name}.de_analysis_id = #{@analysis_id} and " +
                                         "      #{fc_table_name}.treatment_id = #{treatment} and " +
                                         "      #{fc_table_name}.base_treatment_id = #{@base_treatment} and " +
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
   g_hgt_in = g_hgt/100
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
     
   rvg.draw.write("public/images/tmp/#{@title}-#{rvg.object_id}.gif")
               "<img src=\"/images/tmp/#{@title}-#{rvg.object_id}.gif\" width=\"300\" height=\"#{g_hgt}\"  alt=\"heatmap\" usemap=\"#heatmap\" >\n" + 
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
