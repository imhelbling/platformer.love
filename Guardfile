require 'guard/compat/plugin'



module ::Guard 
	class LuaLove < Plugin

		def initialize options = {}
			opts = options.dup
			super opts
		end



		def run_all
			build_the_moon
		end



		def run_on_modifications paths
			build_the_moon
		end



		def build_the_moon
			`moonc .`
		end

	end

end

guard 'lua_love'