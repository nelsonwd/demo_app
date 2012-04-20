module DeDataHelper
def cluster_options(base_treatment)
  treatments = ['1','2','3','4']
  labels = ["None", "0uE", "10uE", "100uE", "500uE"]
  treatments.delete(base_treatment)
  options = []
  options << [labels[0],'']
  treatments.each do |x|
    treatments.each do |y|
      next if x==y
      treatments.each do |z|
        next if x==z || y==z
        options << [ "#{labels[x.to_i]},#{labels[y.to_i]},#{labels[z.to_i]}","#{x},#{y},#{z}"]
      end
    end
  end
  options
end
    
def pagination()
    s = ""
    prev_page= ((params[:page].to_i) - 1)
    next_page = params[:page].to_i + 1
    current_page = params[:page].to_i 
    
    
    if prev_page > 0 then 
        params[:page] = prev_page 
        s = link_to("Previous", params) 
    end
    s += " #{current_page} of #{pluralize(@total_pages,"page")} "
    if next_page <= @total_pages then
        params[:page] = next_page
        s += link_to( "Next", params) 
    end
    params[:page] = current_page
    s
end    
end
