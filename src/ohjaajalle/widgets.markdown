% Widget testground
<!-- hidden! -->

This page serves to somewhat document all the technical abilities of
the engine behind these pages.

<sidebyside>
<column>

**alert**
<alert>alert</alert>
**info**
<info>info</info>
**summary**
<summary>summary</summary>
**vinkki**
<vinkki>vinkki</vinkki>

</column>
<column>

**ohje**
<ohje>ohje</ohje>
**next**
<next>next</next>
**last**
<last>last</last>
**deadline**
<deadline>deadline</deadline>
**arvosanamaksimi**
<arvosanamaksimi>arvosanamaksimi</arvosanamaksimi>
**vaikeustaso**
<vaikeustaso>vaikeustaso</vaikeustaso>

</column>
</sidebyside>

<wip/>

<comment>
This text will dissapear.
</comment>

asdadad `asdadsad` asdadad

## Tabs

<tabs nobox="true">
<tab title="Directories">
curdir is "{{curdir}}"\
rootdir is "{{rootdir}}"\
imgdir is "{{imgdir}}"\
myimgdir is "{{myimgdir}}"\

</tab>
<tab title="Stuff">
# Random stuff
<box>
Huh?
</box>

## Headers work too, but sections are lost
</tab>
</tabs>

<tabs>
<tab title="PHP">
~~~~ {.php .numberLines}
<?php
  echo "test";
?>
~~~~
</tab>
<tab title="Java">
~~~~ {.java .numberLines}
class M {
  public static void main(String[] args) {
    System.out.println("test");
  }
}
~~~~
</tab>
</tabs>

## Expanding stuff

<expandable title="Open me">
~~~~ {.java .numberLines}
class M {
  public static void main(String[] args) {
    System.out.println("test");
  }
}
~~~~

~~~~ {execute="ls /proc/self" type="code"}
~~~~

~~~~ {execute="ls /proc/self" type="plain"}
~~~~

</expandable>

<collapsible title="Close me">
<box>
<alert>Alert</alert>
<info>Alert</info>
<arvosanamaksimi>5</arvosanamaksimi>
<vaikeustaso>Huima</vaikeustaso>
</box>
</collapsible>

<expandable title="Contents of index.markdown">

<box>
<include src="../index.markdown" />
</box>

</expandable>

## Demo of course instance replacements

"\{{deadline1}}" turns to "{{deadline1}}".

| Tilaisuus     | Deadline |
|---------------|--------------------------------|
| Viikko I      | {{deadline1}} klo 23:00        |
| Viikko II     | {{deadline2}} klo 23:00        |
| Viikko III    | {{deadline3}} klo 23:00        |
| Viikko IV     | {{deadline4}} klo 23:00        |
| Viikko V      | {{deadline5}} klo 23:00        |
| Demotilaisuus | {{demodeadline}}               |
| Palautus      | {{palautusdeadline}}           |
