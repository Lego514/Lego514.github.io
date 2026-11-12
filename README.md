# Lego514.github.io

Personal site for Yi-Lei (Ray) Li — https://lego514.github.io

Static HTML, CSS and JavaScript, no build step. One external request: Google Fonts
(Schibsted Grotesk, JetBrains Mono).

The layout, tokens and motion come from [tasteskill](https://github.com/Leonxlnx/taste-skill)
(MIT; the files the page uses are in `assets/`, with the licence in `assets/LICENSE.txt`).
The page's own CSS and scripts are inline in `index.html`.

- `img/` holds real screenshots of each project, each with an `-800` copy for phones
  (`srcset`), the Shallow Sea loop (`shallow-sea-loop.mp4`, cut from the project's intro
  video) and its still.
- The QuantLab chart is a real walk-forward out-of-sample equity curve, extracted from
  [QuantLab](https://github.com/Lego514/quantlab) and drawn as an inline SVG path. To refresh it
  after new market data, re-run the walk-forward and regenerate the path — the figures in the
  text move, and they should.
- `resume/` holds the downloadable résumés (no phone number).
