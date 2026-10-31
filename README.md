# Armor Penetration Simulator – website

A static site: no server, no database, no API keys. Everything runs in the visitor's browser.

## Folder
- `index.html` – landing page (text content for Google) · `play/index.html` – the simulator · `privacy/`, `404.html`
- `assets/sim.js`, `assets/sim.css` – the simulator · `assets/site.css` – landing styles
- `robots.txt`, `sitemap.xml`, `favicon.svg`, `og.png` – search engines and link previews
- `_headers` (Cloudflare Pages / Netlify) and `vercel.json` (Vercel) – security headers
- `.well-known/security.txt` – where people report security problems

## 1. Put your domain in (once)
All files use the placeholder `YOUR-DOMAIN.example`. From this folder run:

    sh set-domain.sh https://your-real-domain.com

Then edit `.well-known/security.txt` and set a real contact e-mail.

## 2. Deploy (free options)
- **Cloudflare Pages** or **Netlify**: create a project, upload this folder (or connect a Git repo). No build command, publish directory `/`. The `_headers` file is picked up automatically.
- **Vercel**: import the folder, framework "Other". `vercel.json` sets the headers.
- **GitHub Pages**: works, but it cannot send custom headers. The pages still carry a CSP `<meta>` tag as a fallback, but `X-Frame-Options`/`frame-ancestors` and HSTS need a host that supports headers.

The site must be served from the **root** of a domain (`https://example.com/`), because the files use absolute paths such as `/assets/sim.js`.

## 3. Get it on Google
1. Make sure the site works over **https** on your final domain.
2. Open **Google Search Console**, add your domain, and verify it (DNS TXT record is the easiest).
3. Submit `https://your-real-domain.com/sitemap.xml` under *Sitemaps*.
4. Use *URL inspection* on the home page and `/play/` and press *Request indexing*.
5. Indexing can take days to weeks. Check that the home page shows "URL is on Google" and that no page says "noindex" (only `404.html` is noindex on purpose).

## Tablets and phones
- One finger moves objects or pans, two fingers pinch-zoom, and the + / − / ⌖ buttons zoom without gestures.
- Touch devices start with Coarse node spacing so they stay smooth. Fine and Ultra are meant for a fast laptop.
- iPad: Share → *Add to Home Screen* opens it full screen. Android: browser menu → *Install app* / *Add to Home screen*.

## Security notes
- **There are no API keys in this project.** The simulator makes no network requests. If you ever add a backend (leaderboards, accounts, AI features), keep secrets only on the server or in your host's *environment variables*, never in `sim.js`. `.gitignore` already excludes `.env` files.
- **Content-Security-Policy:** scripts may only come from your own domain (`script-src 'self'`), nothing external is allowed, framing is blocked, and `connect-src 'self'` stops the page from talking to other sites. If you add a third-party script (analytics, ads), you must add it to the policy in `_headers`, `vercel.json` and the `<meta>` tags on purpose.
- **HSTS** (`Strict-Transport-Security`) is set for one year. Only keep it if your whole domain will stay on https.
- Scenes loaded from the browser's local storage are validated and clamped (`cleanScene` in `sim.js`) before use.
- Keep the host account safe: turn on two-factor login on your hosting, domain and Git accounts. That is the most common way sites get compromised.
- Test your live site at securityheaders.com and search.google.com/test/rich-results.
