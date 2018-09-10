--------------
#MOLD : Agnostic Templates

**Mold** allows to create projects from "mold" templates. Templates are called **Molds** (plural) 

Molds are hosted by default at:

```
http://github.com/eonfluxor/molds
```

Feel free to clone and change the templates repo:

`/lib/constants.rb`

```
TEMPLATES_REPO = "git@github.com:eonfluxor/molds.git"

```

## Available Molds

--------------
#### FrameworkSwift

A Swift Multiplatform Framework mold (iOS | macOS | tvOS)

```
mold FrameworkSwift YourProject
```
--------------
#### SingleViewPlainSwift-iOS

A Swift iOS template without storyboards

```
mold SingleViewPlainSwift-iOS YourProject
```
--------------

## Installation

Just clone this repository and run the install script.

```
git clone git@github.com:eonfluxor/mold.git
install-mold
```

## Molding

To create a new template use:

```
mold TEMPLATE_NAME YourProjectName
```

In example:

```
mold frameworkswift MyAwesomePod
```
*Note: The template name is case insensitive*

## List Templates

To view the available templates use:

```
mold list
```

output is a TEMPLATE_NAME -> path dictionary

```
//sample output
using `molds` at: /Users/hassanvfx/molds
{"frameworkswift"=>"/Users/hassanvfx/molds/FrameworkSwift"}
```

Use the key as the TEMPLATE_NAME to mold your own projects!


## Contributing Public Templates

Start by forking the default templates repo at (note the S at the end)

```
http://github.com/eonfluxor/molds
```

Use the reserved string **MOLD_BOILERPLATE** in all the instances where you want **mold** to replace string.

This applies for 

* filenames
* directories
* text in files

```
MOLD_BOILERPLATE
```


When ready create a PR and we'll review it ASAP

## About

Created by [Hassan Uriostegui](http://linkedin.com/in/hassanvfx)
