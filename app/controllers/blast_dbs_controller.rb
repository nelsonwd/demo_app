class BlastDbsController < ApplicationController
before_filter :authenticate
before_filter :admin_user, :only => [ :new, :edit, :create, :update, :destroy ]
  # GET /blast_dbs
  # GET /blast_dbs.xml
  def index
    @title = "Sequence Databases"
    @blast_dbs = BlastDb.where(:taxonomy_id => 2949).order("created_at DESC")
    @blast_dbs += BlastDb.where("taxonomy_id != 2949").order("display_name")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @blast_dbs }
    end
  end

  # GET /blast_dbs/1
  # GET /blast_dbs/1.xml
  def show
    @title = "Database Detail"
    @blast_db = BlastDb.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @blast_db }
    end
  end

  # GET /blast_dbs/new
  # GET /blast_dbs/new.xml
  def new
    @title = "Add New Database"
    @blast_db = BlastDb.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @blast_db }
    end
  end

  # GET /blast_dbs/1/edit
  def edit
    @title = "Edit Database"
    @blast_db = BlastDb.find(params[:id])
  end

  # GET /blast_dbs/fastasearch
  def fastasearch
    @title = "FASTA search results"
    @file = "#{Rails.root}/public/fasta/" + params[:file]
    blast_db = BlastDb.where(:file_name => params[:file]).first
    #if(index_name == "symb2master" || index_name == "symb3master")  then
    if(Sequence.where("blast_db_id = #{blast_db.id}").exists?) then
      @title = "Gene Annotation"
      @query = params[:query].chomp      
      s = Sequence.where(:accession => @query).first
      unless s.nil? then
        @result = {} 
        @result[:sequence] = s
        feats = []
        feats = s.features
        @result[:interpro] = {}
        @result[:no_interpro] = []
        @result[:experiments] = {}
        feats.each do |f|
          if f.annotation.interpro.nil?
            @result.fetch(:no_interpro).push(f)
          else
            if @result[:interpro].has_key?(f.annotation.interpro) then
              @result.fetch(:interpro)[f.annotation.interpro].push(f)
            else
               @result.fetch(:interpro)[f.annotation.interpro] = [f]
            end
          end
        end
        
        #analyses = s.de_data.map { |d| d.de_analysis }
        s.de_data.each do |a|
            @result.fetch(:experiments)[a.de_analysis] = [] if @result.fetch(:experiments)[a.de_analysis].nil?
            fc = nil
            fc_table =  a.de_analysis.experiment.name.camelcase + "FoldChange" 
            denominator_treatment = (params[:denominator])? params[:denominator] : a.de_analysis.default_treatment_id
#puts   (a.de_analysis.default_treatment_id).first
            fc = Kernel.const_get(fc_table).where(:sequence_id => s.id, :de_analysis_id => a.de_analysis_id, :treatment_id => a.treatment_id, :base_treatment_id => denominator_treatment).first
            if fc.nil?
             @result.fetch(:experiments)[a.de_analysis] << [a.abundance , a.treatment.name, "N/A", "N/A", "N/A", a.treatment_id]
            else
             if (a.abundance == 0)
               fdr = "1.0"
               pval = "1.0"
             else 
               fdr = fc.fdr
               pval = fc.pval
             end
             @result.fetch(:experiments)[a.de_analysis] << [a.abundance , a.treatment.name, fc.log2fc, pval, fdr, a.treatment_id]
            end
        end

      else
        goes = GeneOntology.where("keyword LIKE  '%#{@query}%'")
        iprs = goes.uniq.map do |g|
          g.interpros
        end
        iprs << Interpro.where("description LIKE '%#{@query}%'")
        iprs.flatten!
        annots = iprs.uniq.map do |i|
          i.annotations
        end
        annots << Annotation.where("description LIKE '%#{@query}%'")
        annots.flatten!
        feats = annots.uniq.map do |a|
          a.features
        end
        feats.flatten!
        @result = feats.uniq.map do |f|
          if(f.sequence.blast_db == blast_db)
            f.sequence
          end
        end
        @result.compact!
        @result.uniq!
        puts "RESULT:" + @result.to_s + @result.size.to_s
      end
    else  
      @query = params[:query].chomp.split(%r{\s*,\s*})
      @query = @query.map {|q| Regexp.escape(q)}
      @result = ""
      file = File.new(@file, "r")
      hit = nil
      count = 0
      while (line = file.gets)
         if hit &&  !line.start_with?(">")
           @result += line
         elsif  hit && line.start_with?(">")
           hit = nil
         end
         @query.each do |q|
           if line.start_with?(">") &&  line =~ /#{q}/i
             break if count >= 100
             @result += line
             hit = 1
             count += 1
             break
           end
         end
         break if count >= 100
      end
      file.close
    end
     if @result.blank?
       @result = "No matches found for #{@query} in #{params[:file]}"
    #else
     # @result = "Total number of matches = #{count} \n\n" + @result
    end
  end

  # POST /blast_dbs
  # POST /blast_dbs.xml
  def create
    @blast_db = BlastDb.new(params[:blast_db])

    respond_to do |format|
      if @blast_db.save
        format.html { redirect_to(@blast_db, :notice => 'Blast db was successfully created.') }
        format.xml  { render :xml => @blast_db, :status => :created, :location => @blast_db }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @blast_db.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /blast_dbs/1
  # PUT /blast_dbs/1.xml
  def update
    @blast_db = BlastDb.find(params[:id])

    respond_to do |format|
      if @blast_db.update_attributes(params[:blast_db])
        format.html { redirect_to(@blast_db, :notice => 'Blast db was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @blast_db.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /blast_dbs/1
  # DELETE /blast_dbs/1.xml
  def destroy
    @blast_db = BlastDb.find(params[:id])
    @blast_db.destroy

    respond_to do |format|
      format.html { redirect_to(blast_dbs_url) }
      format.xml  { head :ok }
    end
  end
private

  def authenticate
    deny_access unless signed_in?
  end

  def admin_user
    deny_access unless current_user.admin?
  end
end
