class BlastHit
require_relative 'blast_graphic'

  attr_accessor :hit_num, :hit_def, :hit_name, :hit_annot, :hit_len, :hit_hsps

  def initialize(hit_num, hit_def, hit_name, hit_annot, hit_len)
    @hit_num = hit_num
    @hit_def = hit_def
    @hit_name = hit_name
    @hit_annot = hit_annot
    @hit_len = hit_len
    @hit_hsps = []
  end

  def html_report(query_len)
    graphic = BlastGraphic.new(self, query_len)
    report = ""
    if @hit_def.size < 63 
      @hit_def[@hit_def.size] = ' '*(66 - @hit_def.size)
      report += "  #{annotation_href(@hit_def, false)}"
    else
      report += "  #{annotation_href(@hit_def[0,63], false)}..."
    end
    pad = 6 - String(@hit_hsps.first.hsp_bit_score.round).size
    report += ' '*pad
    report += "<a href=\"\##{@hit_def.object_id}\">#{@hit_hsps.first.hsp_bit_score.round.to_s}</a> #{' '*4}"
    report += "%1.0E" % @hit_hsps.first.hsp_evalue
    report += "\n"
    report += graphic.draw_hit
    report += "\n"
    report
  end

  def html_report_detail
    report = ">#{annotation_href(@hit_name,true)}\n"
    if @hit_annot
      report += " #{@hit_annot[0,80]}\n" 
      if @hit_annot.size > 80
        report += " #{@hit_annot[80,80]}\n"
      end
      if @hit_annot.size > 160
        report += " #{@hit_annot[160,80]}\n"
      end
    end
    report += "<div>Length=#{@hit_len}\n"
    @hit_hsps.each do |hh|
      report += hh.html_report
    end

    report
  end

  private

  def annotation_href link_name, with_anchor
    anchor = ''
    if(with_anchor)
      anchor = "name=\"#{@hit_def.object_id}\""
    end
    if @hit_name.start_with?("gi")
      gi = @hit_name.split("|")[1]
      href = "http://www.ncbi.nlm.nih.gov/nuccore/#{gi}"
    elsif @hit_name.start_with?("Locus")
      href = "/blast_dbs/fastasearch?utf8=%E2%9C%93&file=symb1.2.fa&query=#{@hit_name}&commit=Search"
    elsif @hit_name.start_with?("symb3master")
      href = "/blast_dbs/fastasearch?file=symb3master.fa&query=#{@hit_name}&commit=Search"
    elsif @hit_name.start_with?("symb2master")
      href = "/blast_dbs/fastasearch?file=symb2.1.fa&query=#{@hit_name}&commit=Search"
    elsif @hit_name.start_with?("kb")
      href = "/blast_dbs/fastasearch?utf8=%E2%9C%93&file=kb8_assembly2.fasta&query=#{@hit_name}&commit=Search"
    elsif @hit_name.start_with?("mf")
      href = "/blast_dbs/fastasearch?utf8=%E2%9C%93&file=mf105_assembly.fasta&query=#{@hit_name}&commit=Search"
    end
    "<a #{anchor}></a><a target=\"_blank\" href=\"#{href}\">#{link_name}</a>" 
  end
end
