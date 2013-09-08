#!/usr/bin/perl 

my $path = $ARGV[0];

undef $/;
$_ = <STDIN>;

#Make the selected menu item selected
s#<li>(<a href="(\.\.\/)*$path">)#<li class="selected">\1#;

#Fix tables for bootstrap
s#<table>#<table class="table table-striped table-bordered">#g;

#Fix blockquotes used to fix sessions screwed up by tabs and expandables
my $removethis = "<p>REMOVETHIS<\/p>";
s#$removethis\s+<\/blockquote>\s+<\!-- end box -->##g;
s#<\/blockquote>\s+$removethis\s+<\!-- end box -->##g;
s#<\!-- start box -->\s+<blockquote>\s+$removethis##g;

#Fix img and br tag differences made by different versions of pandoc
s#<img ((\s*\w+=["'][^"']*["'])*\s*)>#<img \1 \/>#g;
s#<br>#<br \/>#g;

print;
