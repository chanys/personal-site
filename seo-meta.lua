-- seo-meta.lua
-- Quarto emits <title>, meta description, and sitemap.xml, but not canonical
-- URLs, og:url/og:type, or JSON-LD structured data. This filter adds those
-- per page: it derives the page's canonical URL from site-url + output path,
-- classifies posts vs pages, and emits schema.org data (Person + WebSite on
-- the home page, BlogPosting on each post).

local SITE_FALLBACK = "https://yeesengchan.com"

local function s(x)
  if x == nil then return nil end
  return pandoc.utils.stringify(x)
end

local function site_url(meta)
  if meta.website and meta.website["site-url"] then return s(meta.website["site-url"]) end
  if meta["site-url"] then return s(meta["site-url"]) end
  return SITE_FALLBACK
end

-- Output path relative to the project root, with a .html extension. Quarto
-- mirrors the input tree, so posts/.../index.qmd -> posts/.../index.html.
local function rel_path()
  local input = quarto.doc.input_file
  if not input then return nil end
  local root = quarto.project and quarto.project.directory or nil
  local rel = input
  if root then
    if root:sub(-1) ~= "/" then root = root .. "/" end
    if input:sub(1, #root) == root then rel = input:sub(#root + 1) end
  end
  rel = rel:gsub("%.qmd$", ".html"):gsub("%.md$", ".html")
  return rel
end

local function jesc(x)
  if x == nil then return "" end
  return (x:gsub("\\", "\\\\"):gsub('"', '\\"'):gsub("[\n\r\t]", " "))
end

-- meta.date is already display-formatted by `date-format` before filters run,
-- so read the raw ISO date straight from the source front matter instead.
-- Returns the value only if it looks like an ISO date (YYYY-MM-DD).
local function iso_date()
  local input = quarto.doc.input_file
  if not input then return nil end
  local f = io.open(input, "r")
  if not f then return nil end
  local fences, date = 0, nil
  for line in f:lines() do
    if line:match("^%-%-%-%s*$") then
      fences = fences + 1
      if fences >= 2 then break end
    elseif fences == 1 then
      local d = line:match("^date:%s*(.+)$")
      if d then date = d:gsub('^["\']', ""):gsub('["\']%s*$', ""):gsub("%s+$", "") end
    end
  end
  f:close()
  if date and date:match("^%d%d%d%d%-%d%d%-%d%d") then return date end
  return nil
end

function Pandoc(doc)
  if not quarto.doc.is_format("html") then return doc end
  local meta = doc.meta

  local site = site_url(meta)
  if site:sub(-1) == "/" then site = site:sub(1, -2) end
  local rel = rel_path()
  if not rel then return doc end
  local url = site .. "/" .. rel

  local is_post = rel:match("^posts/") ~= nil
  local head = {
    string.format('<link rel="canonical" href="%s">', url),
    string.format('<meta property="og:url" content="%s">', url),
    string.format('<meta property="og:type" content="%s">', is_post and "article" or "website"),
  }

  local author = s(meta.author) or "Yee Seng Chan"

  if rel == "index.html" then
    table.insert(head, string.format(
      '<script type="application/ld+json">\n' ..
      '{"@context":"https://schema.org","@type":"Person","name":"%s","url":"%s/",' ..
      '"image":"%s/ys_profile.png","jobTitle":"Applied AI Scientist",' ..
      '"sameAs":["https://github.com/chanys","https://linkedin.com/in/yeesengchan"]}\n' ..
      '</script>', jesc(author), site, site))
    table.insert(head, string.format(
      '<script type="application/ld+json">\n' ..
      '{"@context":"https://schema.org","@type":"WebSite","name":"%s","url":"%s/"}\n' ..
      '</script>', jesc(author), site))
  elseif is_post then
    local date = iso_date()
    if date then
      table.insert(head, string.format(
        '<script type="application/ld+json">\n' ..
        '{"@context":"https://schema.org","@type":"BlogPosting","headline":"%s",' ..
        '"description":"%s","datePublished":"%s","dateModified":"%s",' ..
        '"author":{"@type":"Person","name":"%s","url":"%s/"},' ..
        '"publisher":{"@type":"Person","name":"%s"},' ..
        '"mainEntityOfPage":"%s","url":"%s"}\n' ..
        '</script>',
        jesc(s(meta.title)), jesc(s(meta.description)), jesc(date), jesc(date),
        jesc(author), site, jesc(author), url, url))
    end
  end

  quarto.doc.include_text("in-header", table.concat(head, "\n"))
  return doc
end
