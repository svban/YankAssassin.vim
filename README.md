# What is YankAssassin.vim?
It is really annoying when you want to yank text and paste it close to your cursor and your cursor moves to the start of the yanked text. Especially when you are using text-objects. This plugin helps you fix it. Basically, while Yanking your cursor will not move to the start of the Yanked Text.

## Demo
![1](https://user-images.githubusercontent.com/69670983/147871602-d5f1a6cb-97d4-4950-bb0f-ef7579b27852.gif)
![2](https://user-images.githubusercontent.com/69670983/147871603-813e3248-a093-4915-b209-cad5da276aca.gif)
![3](https://user-images.githubusercontent.com/69670983/147871606-bb17d8a6-53b2-4177-ac48-1c677f2f46c3.gif)


## Features
1. Both Mapping-less(better) & Mapping-plus Solution.
2. While Yanking, text-objects, count, registers also work.
3. Provides extra mappings, which have default behaviour.
4. Works in both Normal & Visual Mode.

## Installation
- Vim plug -
    `Plug 'svban/YankAssassin.vim'`
- or install it, just like you would any vim-plugin.

## Options
- `g:yankassassin_use_mappings` = 0 - Mapping-less solution(default), 1 - Mapping-plus solution

## Usage
- You need to set these bindings, these are examples.
- Default Key Bindings - which moves the cursor to start of yanked text
    ```
    nmap <leader>y <Plug>YADefault
    xmap <leader>y <Plug>YADefault
    ```
- Mapping-plus Solution
    ```
    nmap y <Plug>YAMotion
    xmap y <Plug>YAVisual
    nmap yy <Plug>YALine
    ```
## Others
- If you are using Neovim, for Yank highlighting you can use
```
    augroup highlight_yank
        autocmd!
        au TextYankPost * silent! lua vim.highlight.on_yank{ higroup="IncSearch", timeout=500 }
    augroup END
```
- If you are using Vim, for Yank highlighting you can use
[machakann/vim-highlightedyank](https://github.com/machakann/vim-highlightedyank)
