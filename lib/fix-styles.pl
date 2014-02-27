#!/usr/bin/perl 

BEGIN {
    use v5.12;
    use warnings;
    use File::Basename;
}

my $path = $ARGV[0];

undef $/;
$_ = <STDIN>;

#Make the selected menu item selected
s#<li>(<a href="(\.\.\/)*$path">)#<li class="selected">\1#;

#Fix tables for bootstrap
s#<table>#<table class="table table-striped table-bordered">#g;

#Fix blockquotes used to fix sections screwed up by tabs and expandables
my $removethis = "<p>REMOVETHIS<\/p>";
s#$removethis\s+<\/blockquote>\s+<\!-- end box -->##g;
s#<\/blockquote>\s+$removethis\s+<\!-- end box -->##g;
s#<\!-- start box -->\s+<blockquote>\s+$removethis##g;

#Commenting is implemented twice: before and after the pandoc execution
s#<comment>.*?</comment>##sg;

#Clear extra lines caused by the inline PHP parsing hack
s#&lt;inline-php-hack&gt;.*?&lt;/inline-php-hack&gt;\n##sg;

#Random hack
s#<\/section>[ \n]*<\/section>#<\/section>\n<\/section>#sg;

# We only do the rootdir substitution after we know better
# that is, after any including is done.
# This is to take into account possible includes in other directories
my $rootdir = dirname($ARGV[0]);
if ($rootdir eq ".") {
  $rootdir = "";
} else {
  $rootdir = $rootdir . "/";
  $rootdir =~ s#[^/]+#..#g;
}

# Make rootdir into rootdir if it does not have a slash in front of it
s#(?<!\\){{rootdir}}#$rootdir#g;
s#\\{{rootdir}}#{{rootdir}}#g;

print;
