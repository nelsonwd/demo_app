#!/usr/bin/env ruby

output_format = 0
db_list = ARGV.pop
output_format = ARGV.pop
expectvalue = ARGV.pop
timestamp = ARGV.pop

blastCmd = "blastn -query tmp/#{timestamp}_query.fa -db \"#{db_list}\" -task blastn -evalue #{expectvalue} -num_alignments 2 -num_descriptions 2 -html -outfmt #{output_format} -out tmp/#{timestamp}_working.txt"
puts blastCmd

system(blastCmd)
system("mv tmp/#{timestamp}_working.txt tmp/#{timestamp}_result.txt")

