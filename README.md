# Lego514.github.io

Personal site for Yi-Lei Li (Lego), a backend and full-stack software engineer —
https://legoli.dev

The page has three content sections after the hero: **Projects** (LeetCode Coach, DSA
Whiteboard, Banking Transactions API, Job-Listing Aggregation Pipeline), **More work** (QuantLab, Credit Card
Default Risk, Shallow Sea, RoomFlow, with QuantLab's strategy verdicts in a closed `<details>`)
and **Background** (timeline and skills), followed by Contact.

One static page, hosted by GitHub Pages from the repo root. No build step, no framework, no npm:
`index.html` holds the HTML, the CSS and a small vanilla script. The only external request is
Google Fonts (Fraunces, Inter, JetBrains Mono). Edit the file and push; there is nothing to compile.

The page is hosted by **Lego**, a plush corgi named after the owner, who does what he does: codes in
the hero, plays basketball over Projects, surfs over More work, dives over Background and takes
the photo in Contact. The look is warm and light: cream paper, Lego orange and a thin wood line
that every Lego stands on.

## Layout of the repo

- `index.html` — the whole page. Colour, type and spacing tokens are CSS custom properties on
  `:root` at the top of the `<style>` block.
- `favicon.svg` — the corgi mark.
- `img/` — project screenshots (each with an `-800` copy for phones, used through `srcset`), the
  Shallow Sea and DSA Whiteboard loops with their stills, and the RoomFlow latency chart.
- `img/lego/` — Lego art, transparent WebP. The page uses `lego-coding-side` (hero, preloaded),
  `lego-basketball-front`, `lego-dive-front`, `lego-surf-side` and `lego-photo-front`
  (`lego-coding-side-400` is the hero's phone size).
- `resume/` — the software résumé.
- `foldcraft/` — a separately published app; not part of this page.
- `og.png` — the social preview card (1200×630). `apple-touch-icon.png`, `robots.txt` and
  `sitemap.xml` sit next to it.
- `tools/lego_clip.sh` — turns a generated Lego clip into the WebM + MP4 the page plays.

## Lego, and how to animate him later

Every Lego is a `figure.lego[data-lego]` with a still image. Until real clips exist, each one has a
small CSS motion of its own (the hero breathes, basketball dribbles, surf rocks, dive sways, the
camera Lego takes one snap when he comes into view); all of it is off under reduced motion.

To add a clip: run `tools/lego_clip.sh <id> <raw.mp4>`, then put
`<video muted loop playsinline preload="none" aria-hidden="true" data-src="img/lego/<id>.webm"
data-src-mp4="img/lego/<id>.mp4"></video>` after that figure's `<img>` (add `data-once` and drop
`loop` for the camera). The script starts clips only after the page has loaded, plays only the
Lego most in view, uses the MP4 where VP9 WebM is not supported, cross-fades over the still and
pauses off screen. Shot list, prompts and acceptance checks are in `LEGO_ANIMATION.md` (kept out
of git).

Standing Lego (the section headers and Contact) share one block, `.lego-stand`. Each figure's
inline custom properties crop the art to its visible width (`--cl`, `--cr`), pull the feet onto
the wood line (`--clear`) and place the contact shadow under the feet (`--sl`, `--sw`). New art
needs those five numbers measured from its alpha channel.

## Motion and accessibility

Sections fade up 12 px once (0.25 s) as they enter the view and are always visible in print, each Lego has a small motion, buttons lift 1 px
on hover, and the Shallow Sea loop plays only while on screen. All of it is off under
`prefers-reduced-motion`. The page works without JavaScript: everything is visible, the mobile
links show as a list instead of a menu, and nothing waits on a script to appear.

## Updating the content

- Facts and numbers come from each project's README and the software résumé (for example
  116 sources and 350 tests for the pipeline, 48 for the banking API, 428 + 125 for LeetCode
  Coach). When one of them changes, change all three places.
- The QuantLab chart is a real walk-forward out-of-sample equity curve from
  [QuantLab](https://github.com/Lego514/quantlab), drawn as an inline SVG path; its axis labels
  are HTML positioned over it so they stay readable on phones. To refresh it, re-run the
  walk-forward and regenerate the path — the figures in the text move with it.
