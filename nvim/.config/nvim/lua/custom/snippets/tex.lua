local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

return {
  -- Snippet 1: Basic LaTeX article
  s("article", fmt([[
\documentclass[11pt]{{article}}
\usepackage{{amsmath}}  % Math
\usepackage{{amssymb}}  % Symbols
\usepackage{{graphicx}} % Images
\usepackage[utf8]{{inputenc}}
\usepackage[T1]{{fontenc}}
\usepackage[margin=1in]{{geometry}}

\title{{{}}}
\author{{{}}}
\date{{\today}}

\begin{{document}}

\maketitle

{}

\end{{document}}
  ]], {
    i(1, "Your Title"),
    i(2, "Your Name"),
    i(0, "Start writing here..."),
  })),
}

