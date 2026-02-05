# graph-paper

This repository generates printable graph paper using LaTeX and TikZ. Graph paper templates are defined using the `\graph` command from `macros.tex`, which creates a document with a customizable grid pattern.

## Building Examples

To build a graph paper PDF, use `make` with the path to the desired `.tex` file (with `pdf` as the extension). For example:

```bash
make rectangular/cm.pdf
```

This will compile `rectangular/cm.tex` into `rectangular/cm.pdf`.

Other examples in the `rectangular` directory include:
- `make rectangular/cm-mm.pdf` - centimeter grid with millimeter subdivisions
- `make rectangular/inch-quarter.pdf` - inch grid with quarter-inch subdivisions
- `make rectangular/in-quarter.pdf` - similar inch-based grid

## The `\graph` Command

The `\graph` command is the core of this repository. Each graph paper file is essentially a stub that calls `\graph` with TikZ drawing commands. The command signature is:

```latex
\graph[optional description]{TikZ drawing commands}
```

- **Optional first argument**: A description string (e.g., `\SI{1}{\centi\meter}`) that appears in a sidebar on the left margin of the page
- **Required second argument**: TikZ commands that draw the grid pattern.  Square grids, for example, can use `\draw[step=...] (0,0) grid (width,height);`

The `\graph` command automatically:
- Wraps the TikZ drawing in a `graphpaper` environment (centered on the page)
- Creates a complete LaTeX document with empty page style
- Displays the optional description in the left margin if provided

Example usage:

```latex
\graph[\SI{1}{\centi\meter}]{
	\draw[step=1cm] (0,0) grid (17,24);
}
```

This creates a centimeter grid on a 17×24 cm area. See the examples in `rectangular/` for more patterns.
