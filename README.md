# Whip
Whip: Hypertext Inclusion Preprocessor

### Description

MVC - model view controller. The web runs off of this concept, although imperfectly. Many template engines and preprocessors for html try to apply DRY principles, but blur the bounds with logic, are bloated, require runtime js, and slow down the site.

Servers that strive to do the right thing use tools such as SSI, however, this may not be desirable or possible in all situations and is somewhat limiting.

The solution is to use a proper compile-time preprocessor. As you edit files are automatically compiled and used. It is fast, flexible, portable, and when made properly, right. Whip is just this.

### Help
```
Useage:
      -v --version    displays version number
      -h --help       displays useage information
      -o --output     defines the compiled output paths
      -c --compile    compiles input as whip and outputs as html
      -w --watch      recompiles files on dependency or file modification
```

### Commands
- `<!--$include "path"-->`
Includes the given path where the include is (indent saved).

### How To Use
1. Create a new *.whip file.
2. Insert html code into the file.
3. Use `<!--$COMMAND "ARGUMENT"-->` syntax to use commands.
4. Compile the file to an html file using `whip -c path-to-file`.
5. Tada

### Installation
- Download src and use gem install whip
- Download src and execute bin whip in ruby
- Use gem install whip (if gem exists)

