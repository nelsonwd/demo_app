class BlastHsp

attr_accessor :hsp_num, :hsp_bit_score, :hsp_score, :hsp_evalue, :hsp_query_from, 
:hsp_query_to, :hsp_hit_from, :hsp_hit_to, :hsp_query_frame, :hsp_hit_frame,
:hsp_identity, :hsp_positive, :hsp_gaps, :hsp_align_len, :hsp_qseq, :hsp_midline, 
:hsp_hseq

def initialize( hsp_num, hsp_bit_score, hsp_score, hsp_evalue, hsp_query_from, 
  hsp_query_to, hsp_hit_from, hsp_hit_to, hsp_query_frame, hsp_hit_frame,
  hsp_identity, hsp_positive, hsp_gaps, hsp_align_len, hsp_qseq, hsp_midline, 
  hsp_hseq)

    @hsp_num = hsp_num
    @hsp_bit_score = hsp_bit_score
    @hsp_score = hsp_score
    @hsp_evalue = hsp_evalue
    @hsp_query_from = hsp_query_from
    @hsp_query_to = hsp_query_to
    @hsp_hit_from = hsp_hit_from
    @hsp_hit_to = hsp_hit_to
    @hsp_query_frame = hsp_query_frame
    @hsp_hit_frame = hsp_hit_frame
    @hsp_identity = hsp_identity
    @hsp_positive = hsp_positive
    @hsp_gaps = hsp_gaps
    @hsp_align_len = hsp_align_len
    @hsp_qseq = hsp_qseq
    @hsp_midline = hsp_midline
    @hsp_hseq = hsp_hseq
  end

  def html_report
    puts @hsp_num
    puts @hsp_bit_score
    puts @hsp_score
    puts @hsp_evalue
    puts @hsp_query_from
    puts @hsp_query_to
    puts @hsp_hit_from
    puts @hsp_hit_to
    puts @hsp_query_frame
    puts @hsp_hit_frame
    puts @hsp_identity
    puts @hsp_positive
    puts @hsp_gaps
    report = "\nScore = #{@hsp_bit_score.round} bits (#{@hsp_score}),  Expect = #{"%1.0E" % @hsp_evalue}\n"
    report += "Identities = #{@hsp_identity}/#{@hsp_align_len} (#{(@hsp_identity.to_f/@hsp_align_len.to_f*100.0).round}%),"
    report += " Gaps = #{@hsp_gaps}/#{@hsp_align_len} (#{(@hsp_gaps.to_f/@hsp_align_len.to_f*100.0).round}%)\n"
    report += "Strand = +/#{strand}\n\n"
    report += seq_out
    report
  end

  def strand
    if @hsp_hit_from > @hsp_hit_to
      '-'
    else
      '+'
    end
  end
  
  private 

    def pad(number)
      numberString =  String(number)
      ends = Array[@hsp_query_to,@hsp_hit_to,@hsp_hit_from, @hsp_query_from].sort!
      max_size = String(ends.last).length
      pad_size = max_size - numberString.size
      numberString +  (" " * pad_size)
    end

    def seq_out
      line_start = 0
      q_line_len = 60
      h_line_len = (strand == '-')?-60:60
      q_start = @hsp_query_from
      h_start = @hsp_hit_from
      q_end = (q_start +  q_line_len - 1) > @hsp_query_to ?  @hsp_query_to : q_start + q_line_len - 1
      if strand == '+'
        h_end = (h_start +  h_line_len - 1) > @hsp_hit_to ?  @hsp_hit_to : h_start + h_line_len - 1
      else
        h_end = (h_start +  h_line_len - 1) < @hsp_hit_to ?  @hsp_hit_to : h_start + h_line_len - 1
      end
      report = '' 
      while @hsp_qseq[line_start,q_line_len] && @hsp_qseq[line_start,q_line_len].size > 0  do 
        report += "Query  #{pad q_start}  #{@hsp_qseq[line_start, q_line_len]}  #{q_end}\n"
        report += "       #{pad " "}  #{@hsp_midline[line_start, q_line_len]}\n"
        report += "Sbjct  #{pad h_start}  #{@hsp_hseq[line_start, q_line_len]}  #{h_end}\n"
        report += "\n"
        
        line_start += q_line_len
        q_start += q_line_len
        h_start += h_line_len
        q_end = (q_end +  q_line_len) > @hsp_query_to ?  @hsp_query_to : q_end + q_line_len
        if strand == '+' 
          h_end = (h_end +  h_line_len) > @hsp_hit_to ?  @hsp_hit_to : h_end + h_line_len
        else
          h_end = (h_end +  h_line_len) < @hsp_hit_to ?  @hsp_hit_to : h_end + h_line_len
        end
      end  
      report
    end
end
