require 'open-uri'
remove_data = open('https://en.wikipedia.org/wiki/Ada_Lovelace').read

my_local_file = open('localWiki.html', 'w')

my_local_file.write(remove_data)
my_local_file.close