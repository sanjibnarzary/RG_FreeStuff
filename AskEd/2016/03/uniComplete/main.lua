io.output():setvbuf("no")
display.setStatusBar(display.HiddenStatusBar)

require "ssk2.loadSSK"
_G.ssk.init()
_G.ssk.init( { launchArgs 				= ..., 
	            enableAutoListeners 	= true,
	            exportCore 				= true,
	            exportColors 			= true,
	            exportSystem 			= true,
	            exportSystem 			= true,
	            debugLevel 				= 0 } )


-- This function users a closure and scoping trick to make a self-disposing
-- onComplete that is guaranteed to run only once.

local function trick( work )
	local obj = {}
	obj.executed = false
	function obj.onComplete( self, target  )		
		if( self.executed ) then return end
		self.executed = true
		if(work) then work( target ) end
	end
	return obj   
end


local function onComplete( object )
	print(object.name .. " executed onComplete @ " .. system.getTimer())
end

-- Create a wrapper object to do the work:
local proxy = trick( onComplete )

local red = display.newCircle( 10, 10, 10 )
red.name = "red"
red:setFillColor( 1, 0, 0 )

local green = display.newCircle( 10, 30, 10 )
green.name = "green"
green:setFillColor( 0, 1, 0 )

local blue = display.newCircle( 10, 50, 10 )
blue.name = "blue"
blue:setFillColor( 0, 1, 1 )

transition.to( red,   { x = 200, time = math.random( 1000, 1500 ), onComplete = proxy } )
transition.to( green, { x = 200, time = math.random( 1000, 1500 ), onComplete = proxy } )
transition.to( blue,  { x = 200, time = math.random( 1000, 1500 ), onComplete = proxy } )

