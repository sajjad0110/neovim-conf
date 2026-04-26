-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Compile and Run C in a separate Linux Terminal
vim.keymap.set("n", "<F5>", function()
    -- 1. Save the file
    vim.cmd("w")

    -- 2. SET YOUR TERMINAL HERE
    -- Common options: "alacritty", "konsole", "kitty", "gnome-terminal", "wezterm"
    -- CachyOS usually defaults to "alacritty"
    local term = "alacritty"

    -- 3. Get file info
    -- local file = vim.fn.expand("%:t")
    local file = vim.fn.expand("%:p")
    local exe = vim.fn.expand("%:p:r")

    -- 4. Create the bash command
    --    gcc compiles it
    --    && ./exe runs it (Linux requires ./ to run local files)
    --    ; read ... pauses the window so it doesn't close immediately
    local bash_cmd = string.format(
        "gcc -lm -Wall -Wextra -std=c23 '%s' -o '%s' && '%s'; echo ''; echo 'Press Enter to close...'; read",
        file,
        exe,
        exe
    )

    -- 5. Execute based on the terminal
    --    Most terminals (Alacritty, Konsole, XTerm) use -e to execute a command
    local final_cmd = string.format('%s -e bash -c "%s"', term, bash_cmd)

    -- Special case for Kitty (if you use it)
    if term == "kitty" then
        final_cmd = string.format('kitty bash -c "%s"', bash_cmd)
    end

    -- 6. Run the command detached (so Neovim doesn't freeze)
    vim.fn.jobstart(final_cmd, { detach = true })
end, { desc = "Compile and Run C (Linux)" })
------------------------------------

------------------------
------- Python3 --------
------------------------

-- Run Python in a separate Linux Terminal
vim.keymap.set("n", "<F6>", function()
    -- 1. Save the file
    vim.cmd("w")

    -- 2. SET YOUR TERMINAL HERE
    -- Common options: "alacritty", "konsole", "kitty", "gnome-terminal", "wezterm"
    -- CachyOS usually defaults to "alacritty"
    local term = "alacritty"

    -- 3. Get file info
    local file = vim.fn.expand("%:p")

    -- 4. Create the bash command
    --    python runs the script
    --    ; read ... pauses the window so it doesn't close immediately
    local bash_cmd = string.format("python3 '%s'; echo ''; echo 'Press Enter to close...'; read", file)

    -- 5. Execute based on the terminal
    --    Most terminals (Alacritty, Konsole, XTerm) use -e to execute a command
    local final_cmd = string.format('%s -e bash -c "%s"', term, bash_cmd)

    -- Special case for Kitty (if you use it)
    if term == "kitty" then
        final_cmd = string.format('kitty bash -c "%s"', bash_cmd)
    end

    -- 6. Run the command detached (so Neovim doesn't freeze)
    vim.fn.jobstart(final_cmd, { detach = true })
end, { desc = "Run Python (Linux)" })
------------------------------------------------------------------------

------------------------
--------- Go -----------
------------------------

-- Run Go in a separate Linux Terminal
vim.keymap.set("n", "<F7>", function()
    -- 1. Save the file
    vim.cmd("w")

    -- 2. SET YOUR TERMINAL HERE
    -- CachyOS usually defaults to "alacritty"
    local term = "alacritty"

    -- 3. Get file info
    local file = vim.fn.expand("%:p")

    -- 4. Create the bash command
    --    go run executes the file immediately
    --    ; read ... pauses the window so it doesn't close
    local bash_cmd = string.format("go run '%s'; echo ''; echo 'Press Enter to close...'; read", file)

    -- 5. Execute based on the terminal
    local final_cmd = string.format('%s -e bash -c "%s"', term, bash_cmd)

    -- Special case for Kitty
    if term == "kitty" then
        final_cmd = string.format('kitty bash -c "%s"', bash_cmd)
    end

    -- 6. Run the command detached
    vim.fn.jobstart(final_cmd, { detach = true })
end, { desc = "Run Go (Linux)" })

-----------------------------------------------------------------------------

-- Toggleterm open in the working directory
vim.keymap.set("n", "<C-\\>", ":ToggleTerm dir=%:p:h<CR>", { noremap = true, silent = true })
vim.keymap.set("t", "<C-\\>", [[<C-\><C-n><Cmd>ToggleTerm<CR>]], { noremap = true, silent = true })

vim.keymap.set("n", "<C-n>", function()
    -- 1. Get the directory of the current file
    local current_dir = vim.fn.expand("%:p:h")

    -- 2. Prompt the user for a filename
    vim.ui.input({ prompt = "New file name: ", default = current_dir .. "/" }, function(input)
        if input == nil or input == "" then
            return
        end

        -- 3. Open the new file in a new tab
        vim.cmd("tabnew " .. input)
    end)
end, { desc = "Open new file in tab from current directory" })
