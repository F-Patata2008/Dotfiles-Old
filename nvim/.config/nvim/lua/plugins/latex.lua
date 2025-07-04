return { 
    {
    "lervag/vimtex",
    -- Carga el plugin solo cuando abres un archivo .tex, .latex o .bib. Es más eficiente.
    ft = { "tex", "latex", "bib" },
    init = function()
      -- Opciones globales que DEBEN establecerse ANTES de que el plugin se cargue.
      
      -- ¡¡ESTA ES LA LÍNEA CLAVE QUE RESUELVE TU PROBLEMA DE BIBLIOGRAFÍA!!
      -- Le dice a vimtex que use latexmk, que a su vez ejecuta Biber por ti.
      vim.g.vimtex_compiler_method = "latexmk"

            
      -- ¡¡ESTA ES LA CONFIGURACIÓN CLAVE PARA HYPRLAND/WAYLAND!!
      -- En lugar de solo el nombre, le damos una tabla de configuración.
      vim.g.vimtex_view_zathura = {
        -- Activa el modo Wayland, que usa DBus en lugar de X11 Window IDs.
        wayland = 1,
        -- Ayuda a nvr a encontrar la instancia correcta de Neovim
        nvim_instance = vim.v.servername,
      }

      -- Elige tu visor de PDF. Asegúrate de tener zathura instalado.
      vim.g.vimtex_view_method = "zathura"

      -- Habilita el corrector ortográfico para comentarios en LaTeX
      vim.g.vimtex_spell_enabled = 1
    end,
    config = function()
      -- Aquí van tus atajos de teclado para vimtex.
      local map = vim.keymap.set
      local opts = { silent = true, noremap = true }
    end,
    }
}
