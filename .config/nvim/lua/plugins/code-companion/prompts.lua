local system_context = function(context)
	return "You are a senior "
		.. context.filetype
		.. " developer, working on a professional code base."
		.. " You are working in a team of senior developers from multiple nationalities."
		.. " You should focus on readability, maintainability and reliability."
		.. " You are running in neovim and you should use idiomatic code."
end

return {
	["Create Code Comment"] = {
		strategy = "inline",
		description = "auto create comment for functions",
		opts = {
			short_name = "comment",
			auto_submit = true,
		},
		prompts = {
			{ role = "system", content = system_context },
			{
				role = "user",
				opts = {
					contains_code = true,
				},
				content = function(context)
					local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
					return "For the folllowing code:"
						.. "\n\n```"
						.. context.filetype
						.. "\n"
						.. text
						.. "\n```\n\n"
						.. "Can you create a comment that summerises what it is doing and add it to the most appropriate place?"
						.. " Try to split the comment at 80 characters but focus on readability."
						.. " Use simple English and try to be as concise as possible."
				end,
			},
		},
	},

	["Fix Code"] = {
		strategy = "chat",
		description = "fixes the selection",
		opts = {
			short_name = "fix",
			auto_submit = true,
			placement = "replace",
			user_prompt = false,
			stop_context_insertion = true,
		},
		prompts = {
			{ role = "system", content = system_context },
			{
				role = "user",
				content = function(ctx)
					local text = require("codecompanion.helpers.actions").get_code(ctx.start_line, ctx.end_line)
					return "For the folllowing code:"
						.. "\n\n```"
						.. ctx.filetype
						.. "\n"
						.. text
						.. "\n```\n\n"
						.. "There are some issues with the code above. Can you fix them?"
				end,
				opts = {
					contains_code = true,
				},
			},
		},
	},

	["Generate Tests"] = {
		strategy = "chat",
		description = "generate tests",
		opts = {
			short_name = "gen_test",
			auto_submit = true,
			is_slash_cmd = true,
		},
		prompts = {
			-- Initial prompt
			{ role = "system", content = system_context },
			{
				role = "user",
				opts = {
					contains_code = true,
					auto_submit = true,
				},
				content = function(context)
					local text = require("codecompanion.helpers.actions").get_code(context.start_line, context.end_line)
					return "For the folllowing code:"
						.. "\n\n```"
						.. context.filetype
						.. "\n"
						.. text
						.. "\n```\n\n"
						.. "I want you to create reasonable test cases using the table test format."
						.. " You should utilise the require package and create any mocks that are needed."
				end,
			},
		},
	},
}
