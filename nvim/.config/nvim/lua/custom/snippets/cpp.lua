local ls = require("luasnip")
local s = ls.s
local i = ls.i
local t = ls.t

return {
  s(
    "Patata",
    {
      t({
        "#include <bits/stdc++.h>",
        "using namespace std;",
        "#define ll long long",
        "#define str string",
        "#define vec vector",
        "",
        "int main() {",
        "    int t;",
        "    cin >> t;",
        "    while (t--) {",
        "        ",
      }),
      i(0), -- cursor inside while loop
      t({
        "",
        "    }",
        "    return 0;",
        "}",
      }),
    },
    {
      description = "CP Template (t test cases)",
    }
  ),
}

