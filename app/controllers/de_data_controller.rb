class DeDataController < ApplicationController
  # GET /de_data
  # GET /de_data.xml
  def index
    per_page=25
    @experiment     = params[:experiment]
    @title = @experiment.camelcase
    @analysis_id    = params[:analysis_id]
    @base_treatment = (params[:base_treatment])? params[:base_treatment] : 2
    default_treatment  = ([1,2,3,4] - [@base_treatment.to_i]).first
    @treatment      = (params[:treatment])? params[:treatment] : default_treatment
    @order_by       = (params[:order_by])? params[:order_by] : "pval"
    @filter         = (params[:filter])? params[:filter] : "pval" 
    @filter_value   = (params[:filter_value])? params[:filter_value] : "0.005" 
    @page           = (params[:page])? params[:page] : "1"
    offset         = (@page.to_i - 1) * per_page
    fc_table_name = @experiment + "_fold_changes"
    filter_string = filter_sql @filter, @filter_value, fc_table_name
    order_string = order_sql @order_by, fc_table_name
    fc_table =  Kernel.const_get(@experiment.camelcase + "FoldChange") 
#    count = fc_table.where("#{fc_table_name}.treatment_id = #{@treatment} and #{fc_table_name}.de_analysis_id = #{@analysis_id} and #{fc_table_name}.base_treatment_id = #{@base_treatment} #{@filter}").size
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
    #uniq_seq_ids = fc_table.joins(:de_datum).where( "#{fc_table_name}.de_analysis_id = #{@analysis_id} and #{fc_table_name}.base_treatment_id = #{@base_treatment} " +
    #                                            " and de_data.abundance > 0").order(@order_by).limit(per_page).offset(offset).map {|s|s.sequence_id}
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
        @results_hash[d.sequence][d.base_treatment_id]= [bt_abundance, "N/A","white"]
      end
      @results_hash[d.sequence][d.treatment_id] = [d.de_datum.abundance, d.log2fc, de_color(@filter, @filter_value, d)]
    end

      
    #respond_to do |format|
      #format.html # index.html.erb
      #format.xml  { render :xml => @fc_base }
    #end
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

def de_color(filter, filter_value, d)
  return "" if d.log2fc == 0
  if filter == 'fdr'
    return ''  if d.fdr > filter_value.to_f
  else
    return '' if d.pval > filter_value.to_f
  end

  if d.log2fc > 0
    'color: orange;' 
  elsif d.log2fc < 0
    'color: blue;' 
  end
end
