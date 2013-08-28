#!/usr/bin/perl -p

BEGIN {
    use v5.12;
    use warnings;
    use Encode;
    use JSON;
    use File::Basename;
    undef $/;

    our %tags = ( 
        alert    => 'danger',
        info     => 'info',
        ohje     => 'success',
        next     => 'success small',
        last     => 'info small',
        deadline => "warning small",
        arvosanamaksimi => "info small",
        vaikeustaso => "info small"
    );

    our %titles = (
        alert    => "Pidä mielessä!",
        info     => "Vinkki",
        ohje     => 'Ohje:',
        next     => 'Seuraavaksi:',
        last     => 'Valmista!',
        deadline => "Deadline: ",
        arvosanamaksimi => "Arvosanamaksimi: ",
        vaikeustaso => "Vaikeustaso: ",
    );

    my %counts;

    our $basedir = dirname($ARGV[0]);
    my $curdir = $basedir =~ s#^src/?##r;
    if (length($curdir) > 0) {
      $curdir = $curdir . "/";
    }
    my $rootdir = $curdir =~ s#[^/]+#..#rg;

    our %dirs = (
      curdir => $curdir,
      rootdir => $rootdir,
      imgdir => $rootdir."images/",
      myimgdir => $rootdir."images/".$curdir
    );
    
    my $input_file = "course_instances.json";
    my $json_text = do {
      open(my $json_fh, "<", $input_file)
        or die("Can't open \$filename\": $!\n");
      local $/;
      <$json_fh>
    };
    $json_text = decode_json(encode('UTF-8', $json_text)) || die "Cannot decode couse instance data!";
    our %coursekeywords = %{${$json_text}{'default'}};

    our $startbox = "\n<!-- start box -->\nREMOVETHIS\n\n";
    our $endbox   = "\n<!-- end box -->";
    
    my $tabBoxCount = 0;
    sub parseTabs {
      $tabBoxCount++;
      my $data = shift;
      my $boxes = shift;
      my $tab = 0;
      my @tabs = ();
      my @contents = ();
      my $tabclass = " class='active'";
      my $contentclass = " active";

      while ($data =~ /<tab\s+title=['"](\w*)['"]\s*>(.*?)<\/tab>\s*/sg) {
        my $id = "tab_$tabBoxCount"."_$tab";
        my $content = "$startbox$2$endbox";

        push @tabs, "<li$tabclass><a href='#$id' data-toggle='tab'>$1</a></li>";
        push @contents, "<section class='tab-pane$contentclass' id='$id' >$content</section>";
        $tabclass = "";
        $contentclass = "";

        $tab++;
      }
      
      my $tabHTML = join("\n",@tabs); 
      my $contentHTML = join("\n",@contents);
      $contentHTML = "<div class='tab-content'>\n$contentHTML\n</div>";
      if ($boxes == 1) {
        $contentHTML = "<box>$contentHTML</box>";
      }

      return "<ul class='nav nav-tabs nav-justified'>$tabHTML</ul>$contentHTML";
    }

}

for my $tag (keys %tags) {
    my $class = $tags{$tag};
    my $title = $titles{$tag};
    my $replacement = qq[<section class="alert alert-$class"><h3>$title</h3>];
    s#<$tag>#$replacement#g;
    s#</$tag>#\n</section>#g;
}

for my $dir (keys %dirs) {
    my $dirval = $dirs{$dir};

    s#{{$dir}}#$dirval#g;
}

for my $coursekeyword (keys %coursekeywords) {
    my $coursekeywordval = $coursekeywords{$coursekeyword};

    s#{{$coursekeyword}}#<span class="coursekeyword $coursekeyword">$coursekeywordval</span>#g;
}

s#<comment>.*?</comment>##sg;

#Parses include files while leaving title metadata lines beginning with % out
s{<include +src="([^"]*)" */>} {"\n" . `$0 $basedir/$1` =~ s/^(%[^\n]*)*//rg . "\n";}eg;

#Parse tabs and other dynamic expandable content
s{<tabs nobox=['"]true['"]>\s(.*?)<\/tabs>} {parseTabs($1, 0)."<hr/>" }esg;
s{<tabs>\s(.*?)<\/tabs>} {parseTabs $1, 1}esg;

my $collapsibleCount = 0;
s{<collapsible title=['"]([^'"]*)['"]>} {
  $collapsibleCount++;
  "<button type='button' class='btn-link expandable' data-toggle='collapse' data-target='#collapsible_$collapsibleCount'>$1</button>
  <div id='collapsible_$collapsibleCount' class='collapse in'><section>$startbox";
  }esg;
my $expandableCount = 0;
s{<expandable title=['"]([^'"]*)['"]>} {
  $expandableCount++;
  "<button type='button' class='btn-link expandable collapsed' data-toggle='collapse' data-target='#expandable_$expandableCount'>$1</button>
  <div id='expandable_$expandableCount' class='collapse'><section>$startbox";
  }esg;
s{<box type=['"]([^'"]*)['"]>}{<div class='panel panel-\1'><div class='panel-body'>}g;
s#<\/(collapsible|expandable)>#$endbox</section></div>#g;

# Now we put the contents of all boxes into blockquotes.
# If we don't do this, Pandoc will screw up it's section tags.
my $boxlevel = 0;
s{(.*?\n)}{
  $line = $1;
  $line2 = $1;
  if ($1 =~ /^\<\!-- end box -->/) {
    $boxlevel--;
    my $indent = "> "x$boxlevel;
    $line = "\n$indent\nREMOVETHIS\n$indent\n$indent$line";
  }
  $line = ("> "x$boxlevel). $line; 
  if ($1 =~ /^\<\!-- start box -->/) {
    $boxlevel++;
  }
  $line;
}eg;

s{<box>}{<div class='panel panel-default'><div class='panel-body'>}g;
s{</box>}{</div></div>}g;
s{<sidebyside>}{<div class="row">}g;

s{<column>}{<div class="col-md-6">}g;
s{<column size=["'](\d+)["']>}{<div class="col-md-\1">}g;
s{</(sidebyside|column)>}{</div>}g;

s#<(glyphicon-[a-z-]*)\s*\/>#<span class="glyphicon \1"></span>#g;
s#<(glyphicon-[a-z-]*)\s+color=['"](\w+)['"]\/\s*>#<span style="color: \2" class="glyphicon \1"></span>#g;
s#<(green|blue|yellow|red|orange)>#<span class="\1">#g;
s#<\/(green|blue|yellow|red|orange)>#<\/span>#g;

#Removes comment tags
s#<!-- addHeaderNavigation -->#<script>addSectionLinks = true; </script>#sg;
