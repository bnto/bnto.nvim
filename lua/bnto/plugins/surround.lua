return {
  "kylechui/nvim-surround",
  event = { "BufReadPre", "BufNewFile" },
  version = "*",
  config = true,

  -- NOTE:
  -- add surrounding: <ys{motion}>{surround pair}
  -- delete surrounding <ds>{surround pair to delete}
  -- change surrounding <cs>{surround pair to modifiy}
  -- add surrounding tag: <ys>{motion}<t>
  -- change surrounding tag: <cst>

  -- NOTE: from the help document:
  --     Old text                    Command         New text  
  -- local str = H*ello          ysiw"           local str = "Hello"
  -- require"nvim-surroun*d"     ysa")           require("nvim-surround")
  -- char c = *x;                ysl'            char c = 'x';
  -- int a[] = *32;              yst;}           int a[] = {32};

}
