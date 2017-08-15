local function run(msg, matches)

	if matches[1]:lower() == 'معلوماتي' then

		function get_id(arg, data)

			local username

			if data.first_name_ then

				if data.username_ then

					username = '@'..data.username_

				else

					username = '<i>No Username!</i>'

				end

				local telNum

				if data.phone_number_ then

					telNum = '+'..data.phone_number_

				else

					telNum = '----'

				end

				local lastName

				if data.last_name_ then

					lastName = data.last_name_

				else

					lastName = '----'

				end

				local rank

				if is_sudo(msg) then

					rank = '*¦~ my dev 💡'

				elseif is_owner(msg) then

					rank = '*¦~ manger 💡'

				elseif is_admin(msg) then

					rank = '*¦~ admin 💡'

				elseif is_mod(msg) then

					rank = '*¦~ superadmin 💡'

				else

					rank = ' <b>fucker member </b> 😂'

				end

				local text = '<b>معلوماتك العامه ¦💡</b>\n..\n<b>اسمك الأول ¦🚩</b> <i>'..data.first_name_..'</i>\n..\n<b>اسمك الاخير ¦🚩</b> <i>'..lastName..'</i>\n..\n<b>معرفك️ ¦🚩 </b> '..username..'\n..\n<b>ايديك ¦✔️</b> [ <code>'..data.id_..'</code> ]\n..\n<b>رتبتك بلكروب ¦✔️</b> <i>'..rank..'</i>\n..\n<i>Aboskrop 💡</i>'

				tdcli.sendMessage(arg.chat_id, msg.id_, 1, text, 1, 'html')

			end

		end

		tdcli_function({ ID = 'GetUser', user_id_ = msg.sender_user_id_, }, get_id, {chat_id=msg.chat_id_, user_id=msg.sendr_user_id_})

	end

end



return { patterns = 

	{ "^(معلوماتي)$" }, 

	run = run

	}