# Lego514.github.io

Personal site for Yi-Lei (Ray) Li — https://lego514.github.io

One static page, hosted by GitHub Pages from the repo root. No build step, no framework, no npm:
`index.html` holds the HTML, the CSS and a small vanilla script. The only external request is
Google Fonts (Fraunces, Inter, JetBrains Mono). Edit the file and push; there is nothing to compile.

The page is hosted by **Lego**, a plush corgi who does what Ray does: codes in
the hero, plays basketball over Projects, dives over Research, surfs over Side projects and takes
the photo in Contact. The look is warm and light: cream paper, Lego orange and a thin wood line
that every Lego stands on.

## Layout of the repo

- `index.html` — the whole page. Colour, type and spacing tokens are CSS custom properties on
  `:root` at the top of the `<style>` block.
- `favicon.svg` — the corgi mark.
- `img/` — project screenshots (each with an `-800` copy for phones, used through `srcset`), the
  Shallow Sea loop (`shallow-sea-loop.mp4`) and its still, the RoomFlow latency chart and the
  résumé preview.
- `img/lego/` — Lego art, transparent WebP. The page uses `lego-coding-side` (hero, preloaded),
  `lego-basketball-front`, `lego-dive-front`, `lego-surf-side` and `lego-photo-front`.
- `resume/` — the downloadable résumés (software and data).
- `foldcraft/` — a separately published app; not part of this page.
- `og.png` — the social preview card. It still shows the old design and needs re-rendering.

## Lego, and how to animate him later

Every Lego is a `figure.lego[data-lego]` with a still image. To swap in a short animated clip,
put the file in `img/lego/` and uncomment the `<video … data-src="img/lego/<name>.webm">` line
already inside that figure. The script loads the clip only when Lego is on screen, cross-fades it
over the still, pauses it off screen, and never plays it when the visitor prefers reduced motion.
Clips should be 3–5 s seamless loops, muted, with a transparent or cream (`#FBF6EE`) background
and the same framing as the still, so nothing moves in the layout.

Standing Lego (the section headers and Contact) share one block, `.lego-stand`. Each figure's
inline custom properties crop the art to its visible width (`--cl`, `--cr`), pull the feet onto
the wood line (`--clear`) and place the contact shadow under the feet (`--sl`, `--sw`). New art
needs those five numbers measured from its alpha channel.

## Motion and accessibility

Sections fade up 12 px once as they enter the view, the hero Lego "breathes", buttons lift 1 px
on hover, and the Shallow Sea loop plays only while on screen. All of it is off under
`prefers-reduced-motion`. The page works without JavaScript: everything is visible, the mobile
links show as a list instead of a menu, and nothing waits on a script to appear.

## Updating the content

- Facts and numbers are deliberately safe floors (for example "22,000+ postings a run",
  "300+ tests"). Keep them in step with the résumés.
- The QuantLab chart is a real walk-forward out-of-sample equity curve from
  [QuantLab](https://github.com/Lego514/quantlab), drawn as an inline SVG path; its axis labels
  are HTML positioned over it so they stay readable on phones. To refresh it, re-run the
  walk-forward and regenerate the path — the figures in the text move with it.
