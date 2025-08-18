local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

local function in_mathzone()
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
	local text_before_cursor = table.concat(vim.list_slice(lines, 1, row), "\n"):sub(1, col + #lines[row])
	local _, before = text_before_cursor:gsub("%$%$", "")
	return before % 2 == 1
end


local function make_frac(args, snip)
	-- captures[1] grabs your number from the regex
	local num = snip.captures[1]
	return sn(nil, {
		t("\\frac{"), t(num), t("}{"), i(1), t("}")
	})
end

ls.add_snippets("markdown", {
	s({
		trig = "(%d+)/",
		regTrig = true,
		wordTrig = false,
		condition=in_mathzone,
		show_condition=in_mathzone,
		snippetType = "autosnippet",
	}, {
		d(1, make_frac, {})
	}),

	s({
		trig = '//',
		condition=in_mathzone,
		show_condition=in_mathzone,
		snippetType='autosnippet',
	}, {
		t('\\frac{'), i(1), t('}{'), i(2), t{'}'}
	}),

	s({
		trig = 'lt',
		snippetType = 'autosnippet',
	}, {
		t({'$$', ''}), i(1), t({'', '$$'})
	}),

	s({
		trig='@t',
		regTrig=true,
		wordTrig=false,
		condition=in_mathzone,
		show_condition=in_mathzone,
		snippetType='autosnippet',
	}, {
		t('\\theta')
	}),

	s({
		trig='_',
		regTrig=true,
		wordTrig=false,
		condition=in_mathzone,
		show_condition=in_mathzone,
		snippetType='autosnippet',
	}, {
		t('_{'), i(1), t('}')
	}),

	s({
		trig='int',
		regTrig=true,
		wordTrig=false,
		condition=in_mathzone,
		show_condition=in_mathzone,
		snippetType='autosnippet',
	}, {
		t('\\int_{'), i(1), t('}^{'), i(2), t('}')
	}),

	s({
		trig='sum',
		regTrig=true,
		wordTrig=false,
		condition=in_mathzone,
		show_condition=in_mathzone,
		snippetType='autosnippet',
	}, {
		t('\\sum_{'), i(1), t('}^{}'), i(2), t('}')
	}),

	s({
		trig='sqrt',
		regTrig=true,
		wordTrig=false,
		condition=in_mathzone,
		show_condition=in_mathzone,
		snippetType='autosnippet',
	}, {
		t('\\sqrt{'), i(1), t('}')
	}),

	s({
		trig='*',
		regTrig=true,
		wordTrig=false,
		condition=in_mathzone,
		show_condition=in_mathzone,
		snippetType='autosnippet',
	}, {
		t('\\cdot')
	})

	--[[
  s({
		trig="beg",
		snippetType='autosnippet'},
		fmt([[
\begin{{{}}}
  {}
\end{{{}}}
]]--[[, {
			i(1),
			i(0),
			rep(1),
		})
	)]]
})
