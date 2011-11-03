module ApplicationHelper
 def logo
    image_tag("Symbi.png", :alt => "Logo", :class => "round", :size => '40x40')
  end
  
  def title
    base_title = "Symbiodinium"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
end
