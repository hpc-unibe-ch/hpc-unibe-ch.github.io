# Markdown Cheatsheet

This page outlines all stuff available by installing the base [Python-Markdown]
(comes with MkDocs) and the additional bundle [PyMdown Extensions].

[Python-Markdown]: https://python-markdown.github.io/
[PyMdown Extensions]: https://github.com/facelessuser/pymdown-extensions

[TOC]

## Headings

```no-highlight
### The 3rd level

#### The 4th level

##### The 5th level

###### The 6th level

## Headings <small>with secondary text</small>

### The 3rd level <small>with secondary text</small>

#### The 4th level <small>with secondary text</small>

##### The 5th level <small>with secondary text</small>

###### The 6th level <small>with secondary text</small>
```

### The 3rd level

#### The 4th level

##### The 5th level

###### The 6th level

## Headings <small>with secondary text</small>

### The 3rd level <small>with secondary text</small>

#### The 4th level <small>with secondary text</small>

##### The 5th level <small>with secondary text</small>

###### The 6th level <small>with secondary text</small>

## Emphasis

```no-highlight
Emphasis, aka italics, with *asterisks* or _underscores_.

Strong emphasis, aka bold, with **asterisks** or __underscores__.

Combined emphasis with **asterisks and _underscores_**.

Strikethrough uses two tildes. ~~Scratch this.~~
```

Emphasis, aka italics, with *asterisks* or _underscores_.

Strong emphasis, aka bold, with **asterisks** or __underscores__.

Combined emphasis with **asterisks and _underscores_**.

Strikethrough uses two tildes. ~~Scratch this.~~

## Lists

(In this example, leading and trailing spaces are shown with with dots: ⋅)

```no-highlight
1. First ordered list item
2. Another item
⋅⋅⋅⋅* Unordered sub-list. 
⋅⋅⋅⋅* Item 2
⋅⋅⋅⋅* Item 3
1. Actual numbers don't matter, just that it's a number
⋅⋅⋅⋅1. Ordered sub-list
⋅⋅⋅⋅⋅⋅⋅⋅1. Ordered subsub-list
⋅⋅⋅⋅⋅⋅⋅⋅1. Item 2
⋅⋅⋅⋅⋅⋅⋅⋅1. Item 3
⋅⋅⋅⋅1. Item 2
⋅⋅⋅⋅1. Item 3
4. And another item.

⋅⋅⋅⋅You can have properly indented paragraphs within list items. Notice the blank line above, and the leading spaces (at least one, but we'll use three here to also align the raw Markdown).

⋅⋅⋅⋅To have a line break without a paragraph, you will need to use two trailing spaces.⋅⋅
⋅⋅⋅⋅Note that this line is separate, but within the same paragraph.⋅⋅
⋅⋅⋅⋅(This is contrary to the typical GFM line break behaviour, where trailing spaces are not required.)

* Unordered list can use asterisks
- Or minuses
+ Or pluses
```

1. First ordered list item
2. Another item
    * Unordered sub-list. 
    * Item 2
    * Item 3
1. Actual numbers don't matter, just that it's a number
    1. Ordered sub-list
        1. Ordered subsub-list
        1. Item 2
        1. Item 3
    1. Item 2
    1. Item 3
4. And another item.

    You can have properly indented paragraphs within list items. Notice the blank line above, and the leading spaces (at least one, but we'll use three here to also align the raw Markdown).

    To have a line break without a paragraph, you will need to use two trailing spaces.  
    Note that this line is separate, but within the same paragraph.  
    (This is contrary to the typical GFM line break behaviour, where trailing spaces are not required.)

* Unordered list can use asterisks
- Or minuses
+ Or pluses

## Links

There are two ways to create links.

```no-highlight
[I'm an inline-style link](https://www.google.com)

[I'm an inline-style link with title](https://www.google.com "Google's Homepage")

[I'm a reference-style link][Arbitrary case-insensitive reference text]

[I'm a relative reference to a repository file](../blob/master/LICENSE)

[You can use numbers for reference-style link definitions][1]

Or leave it empty and use the [link text itself].

URLs and URLs in angle brackets will automatically get turned into links. 
http://www.example.com or <http://www.example.com> and sometimes 
example.com (but not on Github, for example).

Some text to show that the reference links can follow later.

[arbitrary case-insensitive reference text]: https://www.mozilla.org
[1]: http://slashdot.org
[link text itself]: http://www.reddit.com
```

[I'm an inline-style link](https://www.google.com)

[I'm an inline-style link with title](https://www.google.com "Google's Homepage")

[I'm a reference-style link][Arbitrary case-insensitive reference text]

[I'm a relative reference to a repository file](../blob/master/LICENSE)

[You can use numbers for reference-style link definitions][1]

Or leave it empty and use the [link text itself].

URLs and URLs in angle brackets will automatically get turned into links. 
http://www.example.com or <http://www.example.com> and sometimes 
example.com (but not on Github, for example).

Some text to show that the reference links can follow later.

[arbitrary case-insensitive reference text]: https://www.mozilla.org
[1]: http://slashdot.org
[link text itself]: http://www.reddit.com

## Images

```no-highlight
Here's our logo (hover to see the title text):

Inline-style: 
![alt text](https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "Logo Title Text 1")

Reference-style: 
![alt text][logo]

[logo]: https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "Logo Title Text 2"
```

Here's our logo (hover to see the title text):

Inline-style: 
![alt text](https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "Logo Title Text 1")

Reference-style: 
![alt text][logo]

[logo]: https://github.com/adam-p/markdown-here/raw/master/src/common/images/icon48.png "Logo Title Text 2"

## Code and Syntax Highlighting

Code blocks are part of the Markdown spec, but syntax highlighting isn't. However, many renderers -- like Github's and *Markdown Here* -- support syntax highlighting. Which languages are supported and how those language names should be written will vary from renderer to renderer. *Markdown Here* supports highlighting for dozens of languages (and not-really-languages, like diffs and HTTP headers); to see the complete list, and how to write the language names, see the [highlight.js demo page](http://softwaremaniacs.org/media/soft/highlight/test.html).

```no-highlight
Inline `code` has `back-ticks around` it.
```

Inline `code` has `back-ticks around` it.

Blocks of code are either fenced by lines with three back-ticks <code>```</code>, or are indented with four spaces. I recommend only using the fenced code blocks -- they're easier and only they support syntax highlighting.


```javascript
var s = "JavaScript syntax highlighting";
alert(s);
```

```python hl_lines="1"
s = "Python syntax highlighting"
print s
```

```
No language indicated, so no syntax highlighting in Markdown Here (varies on Github). 
But let's throw in a <b>tag</b>.
```

Even tabbed code example for different language are possible:

```Bash tab=
#!/bin/bash
STR="Hello World!"
echo $STR
```

```C tab=
#include

int main(void) {
  printf("hello, world\n");
}
```

```C++ tab=
#include <iostream>

int main() {
  std::cout << "Hello, world!\n";
  return 0;
}
```

```C# tab=
using System;

class Program {
  static void Main(string[] args) {
    Console.WriteLine("Hello, world!");
  }
}
```

## Tables

Tables aren't part of the core Markdown spec, but they are part of GFM and *Markdown Here* supports them. They are an easy way of adding tables to your email -- a task that would otherwise require copy-pasting from another application.

```no-highlight
Colons can be used to align columns.

| Tables        | Are           | Cool  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |

There must be at least 3 dashes separating each header cell.
The outer pipes (|) are optional, and you don't need to make the 
raw Markdown line up prettily. You can also use inline Markdown.

Markdown | Less | Pretty
--- | --- | ---
*Still* | `renders` | **nicely**
1 | 2 | 3
```

Colons can be used to align columns.

| Tables        | Are           | Cool |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |

There must be at least 3 dashes separating each header cell. The outer pipes (|) are optional, and you don't need to make the raw Markdown line up prettily. You can also use inline Markdown.

Markdown | Less | Pretty
--- | --- | ---
*Still* | `renders` | **nicely**
1 | 2 | 3

## Blockquotes

```no-highlight
> Blockquotes are very handy in email to emulate reply text.
> This line is part of the same quote.

Quote break.

> This is a very long line that will still be quoted properly when it wraps. Oh boy let's keep writing to make sure this is long enough to actually wrap for everyone. Oh, you can *put* **Markdown** into a blockquote. 
```

> Blockquotes are very handy in email to emulate reply text.
> This line is part of the same quote.

Quote break.

> This is a very long line that will still be quoted properly when it wraps. Oh boy let's keep writing to make sure this is long enough to actually wrap for everyone. Oh, you can *put* **Markdown** into a blockquote. 

Blockquote nesting is possible:

```
> **Sed aliquet**, neque at rutrum mollis, neque nisi tincidunt nibh, vitae
  faucibus lacus nunc at lacus. Nunc scelerisque, quam id cursus sodales, lorem
  [libero fermentum](#) urna, ut efficitur elit ligula et nunc.

> > Mauris dictum mi lacus, sit amet pellentesque urna vehicula fringilla.
    Ut sit amet placerat ante. Proin sed **elementum** __nulla__. Nunc vitae sem odio.
    Suspendisse ac eros arcu. Vivamus orci erat, volutpat a tempor et, rutrum.
    eu odio.

> > > `Suspendisse rutrum facilisis risus`, eu posuere neque commodo a.
      Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed nec leo
      bibendum, sodales mauris ut, tincidunt massa.
```

> **Sed aliquet**, neque at rutrum mollis, neque nisi tincidunt nibh, vitae
  faucibus lacus nunc at lacus. Nunc scelerisque, quam id cursus sodales, lorem
  [libero fermentum](#) urna, ut efficitur elit ligula et nunc.

> > Mauris dictum mi lacus, sit amet pellentesque urna vehicula fringilla.
    Ut sit amet placerat ante. Proin sed elementum nulla. Nunc vitae sem odio.
    Suspendisse ac eros arcu. Vivamus orci erat, volutpat a tempor et, rutrum.
    eu odio.

> > > `Suspendisse rutrum facilisis risus`, eu posuere neque commodo a.
      Interdum et malesuada fames ac ante ipsum primis in faucibus. Sed nec leo
      bibendum, sodales mauris ut, tincidunt massa.

Other content blocks within a blockquote

> Vestibulum vitae orci quis ante viverra ultricies ut eget turpis. Sed eu
  lectus dapibus, eleifend nulla varius, lobortis turpis. In ac hendrerit nisl,
  sit amet laoreet nibh.
  ``` js hl_lines="8"
  var _extends = function(target) {
    for (var i = 1; i < arguments.length; i++) {
      var source = arguments[i];
      for (var key in source) {
        target[key] = source[key];
      }
    }
    return target;
  };
  ```

  > > Praesent at `:::js return target`, sodales nibh vel, tempor felis. Fusce
      vel lacinia lacus. Suspendisse rhoncus nunc non nisi iaculis ultrices.
      Donec consectetur mauris non neque imperdiet, eget volutpat libero.

## Inline HTML

You can also use raw HTML in your Markdown, and it'll mostly work pretty well. 

## Horizontal Rule

```
Three or more...

---

Hyphens

***

Asterisks

___

Underscores
```

Three or more...

---

Hyphens

***

Asterisks

___

Underscores

## Line Breaks

My basic recommendation for learning how line breaks work is to experiment and discover -- hit &lt;Enter&gt; once (i.e., insert one newline), then hit it twice (i.e., insert two newlines), see what happens. You'll soon learn to get what you want. "Markdown Toggle" is your friend. 

Here are some things to try out:

```
Here's a line for us to start with.

This line is separated from the one above by two newlines, so it will be a *separate paragraph*.

This line is also a separate paragraph, but...
This line is only separated by a single newline, so it's a separate line in the *same paragraph*.
```

Here's a line for us to start with.

This line is separated from the one above by two newlines, so it will be a *separate paragraph*.

This line is also begins a separate paragraph, but...  
This line is only separated by a single newline, so it's a separate line in the *same paragraph*.

## YouTube Videos

They can't be added directly but you can add an image with a link to the video like this:

```no-highlight
<a href="http://www.youtube.com/watch?feature=player_embedded&v=YOUTUBE_VIDEO_ID_HERE
" target="_blank"><img src="http://img.youtube.com/vi/YOUTUBE_VIDEO_ID_HERE/0.jpg" 
alt="IMAGE ALT TEXT HERE" width="240" height="180" border="10" /></a>
```

Or, in pure Markdown, but losing the image sizing and border:

```no-highlight
[![IMAGE ALT TEXT HERE](http://img.youtube.com/vi/YOUTUBE_VIDEO_ID_HERE/0.jpg)](http://www.youtube.com/watch?v=YOUTUBE_VIDEO_ID_HERE)
```

Referencing a bug by #bugID in your git commit links it to the slip. For example #1. 

## Admonition

```no-highlight
!!! type "optional explicit title within double quotes"
    Any number of other indented markdown elements.

    This is the second paragraph.
```

!!! note "Some title"
    Any number of other indented markdown elements.

    This is the second paragraph.

And this is outside the admonition again.

If you don’t want a title, use a blank string "".

!!! danger ""
    Don't do this at home!

rST suggests the following “types”: attention, caution, danger, error, hint, important, note, tip, and warning:  

!!! note "Some title"
    This is type note

!!! hint "Some title"
    This is type hint
    
!!! tip "Some title"
    This is type tip

!!! important "Some title"
    This is type important

!!! attention "Some title"
    This is type attention
    
!!! caution "Some title"
    This is type caution

!!! warning "Some title"
    This is type warning

!!! danger "Some title"
    This is type danger

!!! error "Some title"
    This is type error

## Abbreviations

```
The HTML specification
is maintained by the W3C.

*[HTML]: Hyper Text Markup Language
*[W3C]:  World Wide Web Consortium
```

The HTML specification
is maintained by the W3C.

*[HTML]: Hyper Text Markup Language  
*[W3C]:  World Wide Web Consortium

## Definition Lists

```
Apple
:   Pomaceous fruit of plants of the genus Malus in
    the family Rosaceae.

Orange
:   The fruit of an evergreen tree of the genus Citrus.
```

Apple
:   Pomaceous fruit of plants of the genus Malus in
    the family Rosaceae.

Orange
:   The fruit of an evergreen tree of the genus Citrus.


<a href="#footnotes" />

## Footnotes

Footnotes[^1] have a label[^@#$%] and the footnote's content. Another Footnote[^anything]

[^1]: This is a footnote content.
[^@#$%]: A footnote on the label: "@#$%".
[^anything]: Another content

---

License: [CC-BY](https://creativecommons.org/licenses/by/3.0/)
