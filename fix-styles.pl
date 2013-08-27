#!/usr/bin/perl 

my $path = $ARGV[0];

undef $/;
$_ = <STDIN>;

#Make the selected menu item selected
s#<li>(<a href="(\.\.\/)*$path">)#<li class="selected">\1#;

#Fix tables for bootstrap
s#<table>#<table class="table table-striped table-bordered">#g;

print;
