local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ':p:h:t')

local workspace_dir = os.getenv("JDTLS_DATA_DIR") .. "/" .. project_name

local jar_dir = os.getenv("JAR_DIR")

-- where do I download all this java stuff?
-- java-debug - https://open-vsx.org/extension/vscjava/vscode-java-debug
-- java-test - https://open-vsx.org/extension/vscjava/vscode-java-test
-- lombok - https://projectlombok.org/download
-- jdt-language-server https://download.eclipse.org/jdtls/milestones/?d

-- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
local config = {
    -- The command that starts the language server
    -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
    cmd = {

        -- 💀
        -- the nvim plugin needs at least java 21
        os.getenv("JAVA_HOME") .. '/bin/java', -- or '/path/to/java17_or_newer/bin/java'
        -- depends on if `java` is in your $PATH env variable and if it points to the right version.

        '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        '-Dosgi.bundles.defaultStartLevel=4',
        '-Declipse.product=org.eclipse.jdt.ls.core.product',
        '-Dlog.protocol=true',
        '-Dlog.level=ALL',
        '-javaagent:' .. jar_dir .. '/lombok/lombok.jar',
        '-Xmx1g',
        '--add-modules=ALL-SYSTEM',
        '--add-opens', 'java.base/java.util=ALL-UNNAMED',
        '--add-opens', 'java.base/java.lang=ALL-UNNAMED',

        -- 💀
        -- I'm using jdtls 1.49.0
        '-jar', jar_dir .. '/jdt-language-server/plugins/org.eclipse.equinox.launcher_1.7.0.v20250519-0528.jar',
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
        -- Must point to the                                                     Change this to
        -- eclipse.jdt.ls installation                                           the actual version


        -- 💀
        '-configuration', jar_dir .. '/jdt-language-server/config_linux',
        -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
        -- Must point to the                      Change to one of `linux`, `win` or `mac`
        -- eclipse.jdt.ls installation            Depending on your system.


        -- 💀
        -- See `data directory configuration` section in the README
        '-data', workspace_dir
    },

    -- 💀
    -- This is the default if not provided, you can remove it. Or adjust as needed.
    -- One dedicated LSP server & client will be started per unique root_dir
    --
    -- vim.fs.root requires Neovim 0.10.
    -- If you're using an earlier version, use: require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'}),
    root_dir = vim.fs.root(0, { ".git", "mvnw", "gradlew" }),

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
        }
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        bundles = {}
    },
}

-- dap config

local bundles = {
    vim.fn.glob(jar_dir .. "/java-debug/com.microsoft.java.debug.plugin-*.jar", true)
}

local java_test_bundles = vim.split(vim.fn.glob(jar_dir .. "/java-test/*.jar", true), "\n")
local excluded = {
    "com.microsoft.java.test.runner-jar-with-dependencies.jar",
    "jacocoagent.jar",
}
for _, java_test_jar in ipairs(java_test_bundles) do
    local fname = vim.fn.fnamemodify(java_test_jar, ":t")
    if not vim.tbl_contains(excluded, fname) then
        table.insert(bundles, java_test_jar)
    end
end

config['init_options'] = {
    bundles = bundles
}

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
require('jdtls').start_or_attach(config)

vim.keymap.set("n", "<leader>vi", function ()
    require 'jdtls'.organize_imports()
end)

vim.keymap.set("n", "<leader>vrc", function ()
    require'jdtls'.test_class()
end)

vim.keymap.set("n", "<leader>vrt", function ()
    require'jdtls'.test_nearest_method()
end)
