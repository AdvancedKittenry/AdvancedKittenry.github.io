#!/usr/bin/perl -p

BEGIN {
    use v5.12;
    use warnings;
    use Encode;
    use lib 'lib/perllib/';
    use JSON;
    use File::Basename;
    undef $/;

    our %tags = ( 
        alert    => 'danger',
        info     => 'info',
        summary  => 'info',
        vinkki   => 'warning',
        huomio   => 'warning',
        ohje     => 'success',
        next     => 'success small',
        last     => 'info small',
        deadline => "warning small",
        arvosanamaksimi => "info small",
        vaikeustaso => "info small"
    );

    our %titles = (
        alert    => "Pidä mielessä!",
        info     => "Lisätietoa",
        summary  => "Tiivistelmä:",
        vinkki   => "Vinkki",
        huomio   => "Huomaa!",
        ohje     => 'Ohje:',
        next     => 'Seuraavaksi:',
        last     => 'Valmista!',
        deadline => "Deadline: ",
        arvosanamaksimi => "Arvosanamaksimi: ",
        vaikeustaso => "Vaikeustaso: ",
    );

    our $basedir = dirname($ARGV[0]);
    my $curdir = $basedir =~ s#^src/?##r;
    if (length($curdir) > 0) {
      $curdir = $curdir . "/";
    }
    our $rootdir = $curdir =~ s#[^/]+#..#rg;

    our %dirs = (
      curdir => $curdir,
      imgdir => "{{rootdir}}images/",
      myimgdir => "{{rootdir}}images/".$curdir
    );
    
    my $input_file = "course_instances.json";
    my $json_text = do {
      open(my $json_fh, "<", $input_file)
        or die("Can't open \$filename\": $!\n");
      local $/;
      <$json_fh>
    };
    $json_text =~ s#\\\n#\\n#gs;
    $json_text = decode_json(encode('UTF-8', $json_text)) || die "Cannot decode couse instance data!";
    our %coursekeywords = %{${$json_text}{'default'}};

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

      while ($data =~ /<tab\s+title=['"]([^'"]*)['"]\s*>(.*?)<\/tab>\s*/sg) {
        my $id = "tab_$tabBoxCount"."_$tab";
        my $content = "$2";

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

#Commenting is implemented twice: before and after the pandoc execution
s#<comment>.*?</comment>##sg;
s#<wip *\/>#<include src="${rootdir}templates/wip.html" />#sg;

for my $tag (keys %tags) {
    my $class = $tags{$tag};
    my $title = $titles{$tag};
    my $replacement = qq[<section class="alert alert-$class"><h3>$title</h3>];
    s#<$tag>#$replacement#g;
    s#</$tag>#\n</section>#g;
    s#<$tag\s+title=["']([^'"]*)["']\s*>#<section class="alert alert-$class"><h3>\1</h3>#g;
}

for my $dir (keys %dirs) {
    my $dirval = $dirs{$dir};
    
    # Make dir variables work unless escaped with \
    s#(?<!\\){{$dir}}#$dirval#g;
}

# Rootdir is handled later on. 
# If it is for some reason escaped with a slash,
# we need to double the escaping because the slash
# goes through pandoc which clears escapes on its own.
s#(\\{{rootdir}})#\\$1#g;

for my $coursekeyword (keys %coursekeywords) {
    my $coursekeywordval = $coursekeywords{$coursekeyword};

    s#(?<!\\){{{$coursekeyword}}}#$coursekeywordval#g;
    s#(?<!\\){{$coursekeyword}}#<span class="coursekeyword $coursekeyword">$coursekeywordval</span>#g;
}

#Parses include files while leaving title metadata lines beginning with % out
s{<include +src="([^"]*)" */>} {"\n" . `$0 $basedir/$1` =~ s/^(%[^\n]*)*//rg . "\n";}eg;

#Parse tabs and other dynamic expandable content
s{<tabs>\s(.*?)<\/tabs>} {parseTabs $1, 1}esg;

#Implement <collapsible> and <expandable> tags
my $collapsibleCount = 0;
s{<collapsible title=['"]([^'"]*)['"]>} {
  $collapsibleCount++;
  "<button type='button' class='btn-link expandable' data-toggle='collapse' data-target='#collapsible_$collapsibleCount'>$1</button>
  <div id='collapsible_$collapsibleCount' class='collapse in'><section>";
  }esg;
my $expandableCount = 0;
s{<expandable title=['"]([^'"]*)['"]>} {
  $expandableCount++;
  "<button type='button' class='btn-link expandable collapsed' data-toggle='collapse' data-target='#expandable_$expandableCount'>$1</button>
  <div id='expandable_$expandableCount' class='collapse'><section>";
  }esg;
s{<box>}{<div class='panel panel-default'><div class='panel-body'>\n}g;
s{</box>}{\n</div></div>}g;
s{<box type=['"]([^'"]*)['"]>}{<div class='panel panel-\1'><div class='panel-body'>\n}g;
s#<\/(collapsible|expandable)>#</section></div>#g;

s{<sidebyside>}{<div class="row">}g;

s{<column>}{<div class="col-md-6">}g;
s{<column size=["'](\d+)["']>}{<div class="col-md-\1">}g;
s{</(sidebyside|column)>}{</div>}g;

#A hack to enable syntax hilighting of inline php code
s#(~~~+)inlinephp\n#\1php\n<inline-php-hack><?php </inline-php-hack>\n#g;
