local plugin = ...
plugin.name = 'Ban Messages'
plugin.author = 'jdb'
plugin.description = 'Adds more useful ban messages.'

plugin.defaultConfig = {
	formatString = 'You are still banned for %im!',
	permaFormatString = 'You are permanently banned!'
}

function plugin.hooks.PostAccountTicket (acc)
	if not acc then return end

	local banTime = acc.banTime
	if banTime > 0 then
		hook.once(
			'SendConnectResponse',
			---@param address string
			---@param port integer
			---@param data table
			function (address, port, data)
				-- 100 years
				if banTime > 52596000 then
					data.message = plugin.config.permaFormatString
				else
					data.message = string.format(plugin.config.formatString, banTime)
				end
			end
		)
	end
end
