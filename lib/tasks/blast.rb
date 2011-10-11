#!/usr/bin/env ruby

timestamp = ARGV.pop
blast_cmd = ARGV.pop
puts blast_cmd

system(blast_cmd)
system("mv #{timestamp}_working.txt #{timestamp}_result.txt")

