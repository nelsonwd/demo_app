require "rexml/document"
require_relative "blast_report"
require_relative "blast_result"
require_relative "blast_hit"
require_relative "blast_hsp"

include REXML

class BlastReportParser

  def initialize(result_file)
    @result_file = result_file
  end

  def html_report
    xml = File.read(@result_file)
    @lineStart = 0
    @lineLen = 60
    doc = Document.new(xml)
    program = doc.text('BlastOutput/BlastOutput_program')
    version = doc.text('BlastOutput/BlastOutput_version')
    dbs = doc.text('BlastOutput/BlastOutput_db').split
    dbs.map!{|x|x.split('/').last}
    
    blast_report = BlastReport.new(program, version, dbs)
    
    #startIndex = dbs[0] =~  /\/(\w+$)/
    #dbs.each do |db|
    #  puts db
    #end
    
    doc.elements.each('BlastOutput/BlastOutput_iterations/Iteration') do |p|
      query_num =  Integer(p.elements['Iteration_iter-num'].text)
      query_def =  p.elements['Iteration_query-def'].text
      query_len =  Integer(p.elements['Iteration_query-len'].text)
      blast_result = BlastResult.new(query_num, query_def, query_len)
      blast_report.blast_results.push(blast_result)
      p.elements.each('Iteration_hits/Hit') do |h|
        hit_num = Integer(h.elements['Hit_num'].text)
        hit_def = h.elements['Hit_def'].text
        hit_name = hit_def.split.first
        hit_annot = hit_def[hit_name.size + 1, hit_def.size]
        hit_len = Integer(h.elements['Hit_len'].text)
        blast_hit = BlastHit.new(hit_num, hit_def, hit_name, hit_annot, hit_len)
        blast_result.blast_hits.push(blast_hit)
        h.elements.each('Hit_hsps/Hsp') do |s|
          hsp_num = Integer(s.elements['Hsp_num'].text)
          hsp_bit_score = Float(s.elements['Hsp_bit-score'].text)
          hsp_score = s.elements['Hsp_score'].text
          hsp_evalue = s.elements['Hsp_evalue'].text
          hsp_query_from = Integer(s.elements['Hsp_query-from'].text)
          hsp_query_to = Integer(s.elements['Hsp_query-to'].text)
          hsp_hit_from = Integer(s.elements['Hsp_hit-from'].text)
          hsp_hit_to = Integer(s.elements['Hsp_hit-to'].text)
          hsp_query_frame = Integer(s.elements['Hsp_query-frame'].text)
          hsp_hit_frame = Integer(s.elements['Hsp_hit-frame'].text)
          hsp_identity = Integer(s.elements['Hsp_identity'].text)
          hsp_positive = Integer(s.elements['Hsp_positive'].text)
          hsp_gaps = Integer(s.elements['Hsp_gaps'].text)
          hsp_align_len = Integer(s.elements['Hsp_align-len'].text)
          hsp_qseq = s.elements['Hsp_qseq'].text
          hsp_midline = s.elements['Hsp_midline'].text
          hsp_hseq = s.elements['Hsp_hseq'].text
          blast_hsp = BlastHsp.new( hsp_num, hsp_bit_score, hsp_score, hsp_evalue, hsp_query_from, 
                      hsp_query_to, hsp_hit_from, hsp_hit_to, hsp_query_frame, hsp_hit_frame,
                      hsp_identity, hsp_positive, hsp_gaps, hsp_align_len, hsp_qseq, hsp_midline, 
                      hsp_hseq) 
          blast_hit.hit_hsps.push(blast_hsp)
        end
      end
    end
    blast_report.html_report
  end
end
