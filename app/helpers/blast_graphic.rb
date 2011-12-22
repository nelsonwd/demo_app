require 'rvg/rvg'
#require '/usr/local/rvm/gems/ruby-1.9.2-p290@rails3tutorial/gems/rmagick-2.13.1/lib/rvg/rvg.rb'
include Magick

class BlastGraphic

  attr_accessor :blast_hit, :query_len

  def initialize(blast_hit, query_len)
    @blast_hit = blast_hit
    @query_len = query_len
  end

  def draw_hit
    hspCount = @blast_hit.hit_hsps.size
    g_hgt = hspCount*20 + 20
    g_hgt_in = hspCount*0.2 + 0.2
    RVG::dpi = 72    
    rvg = RVG.new(8.0.in, g_hgt_in.in).viewbox(0,0, 800, g_hgt) do |canvas|
      canvas.background_fill = 'white'

      canvas.g.translate(50, 0) do |query|
          query.rect(700, 5).styles(:stroke=>'gray', :fill=>'gray')
          query.text(-50, 10).tspan('1').styles(:fill=>'black', :font_size=>11,:font_family=>'verdana')
          query.text(705, 10).tspan("#{@query_len}").styles(:fill=>'black', :font_size=>11,:font_family=>'verdana')
      end

      query_units = (700.0 / @query_len.to_f)
      hsp_map_pos = 0

      @blast_hit.hit_hsps.each do |hsp|
        
        line_start = ((hsp.hsp_query_from.to_f - 1) * query_units).round
        line_len = (((hsp.hsp_query_to - hsp.hsp_query_from).abs + 1 ) * query_units).round 
        hsp_map_pos += 20
        canvas.g.translate(line_start + 50, hsp_map_pos) do |query|
          query.rect(line_len, 5 ).styles(:stroke=>score_color(hsp.hsp_score), :fill=>score_color(hsp.hsp_score))
          query.text(-50, 5).tspan("#{hsp.hsp_hit_from}").styles(:fill=>'black', :font_size=>11,:font_family=>'verdana')
          query.text(line_len + 5, 5).tspan("#{hsp.hsp_hit_to}").styles(:fill=>'black', :font_size=>11,:font_family=>'verdana')
        end
      end
    end
    rvg.draw.write("public/images/tmp/#{@blast_hit.hit_num}-#{@blast_hit.hit_name.object_id}.gif")
    "<img src=\"images/tmp/#{@blast_hit.hit_num}-#{@blast_hit.hit_name.object_id}.gif\" >"
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
