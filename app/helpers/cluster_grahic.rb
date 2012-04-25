require 'rvg/rvg'

include Magick

class ClusterGraphic

  attr_accessor :blast_hit, :query_len

  def initialize(result_hash)
    @result_hash = result_hash
  end

  def draw_map(order)
    y_pos = 0
    row_width = 5
    g_hgt = @result_hash.size * 5
    g_hgt_in = g_hgt/100
    RVG::dpi = 72    
    rvg = RVG.new(3.0.in, g_hgt_in.in).viewbox(0,0, 300, g_hgt) do |canvas|
      canvas.background_fill = 'white'
    end
    reslult_hash.each_pair do |seq, treatment_hash|
      col1 = treatment_hash[order[0].to_i]
      col2 = treatment_hash[order[1].to_i]
      col3 = treatment_hash[order[2].to_i]
      
      canvas.g.translate(0, y_pos) do |query|
          query.rect(100, 5).styles(:stroke=> col1[2], :fill=> col1[2])
      end
      canvas.g.translate(101, y_pos) do |query|
          query.rect(100, 5).styles(:stroke=> col2[2], :fill=> col2[2])
      end
      canvas.g.translate(201, y_pos) do |query|
          query.rect(100, 5).styles(:stroke=> col3[2], :fill=> col3[2])
      end
      y_pos +=  row_width
    end
      
    rvg.draw.write("public/images/tmp/#{@title}-#{result_hash.object_id}.gif")
               "<img src=\"images/tmp/#{@title}-#{result_hash.object_id}.gif\" >"
  end

  private

  def score_color(score)
    if score.to_i < 40
      'black'
    elsif score.to_i < 50
      'violet'
    elsif score.to_i < 80
      'green'
    elsif score.to_i < 200
      'orange' 
    else
      'red'
    end
  end
end

