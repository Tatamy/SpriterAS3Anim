package com.acemobe.spriter.data
{
	import com.acemobe.spriter.Spriter;
	
	import starling.utils.deg2rad;

	public class SpatialInfo
	{
		public	var	x:Number = 0; 
		public	var	y:Number = 0; 
		public	var	angle:Number = 0;
		public	var	scaleX:Number = 1; 
		public	var	scaleY:Number = 1; 
		public	var	a:Number = 1;
		
		public function SpatialInfo()
		{
		}
		
		public	function parse (timelineXml:XML):void
		{
			if (timelineXml.attribute("x").length())
				x = timelineXml.@x;
			if (timelineXml.attribute("y").length())
				y = -timelineXml.@y;
			if (timelineXml.attribute("angle").length())
				angle = timelineXml.@angle;
			if (timelineXml.attribute("scale_x").length())
				scaleX = timelineXml.@scale_x;
			if (timelineXml.attribute("scale_y").length())
				scaleY = timelineXml.@scale_y;
			if (timelineXml.attribute("a").length())
				a = timelineXml.@a;
		}
		
		public	function clone (clone:SpatialInfo):void
		{
			clone.x = this.x;
			clone.y = this.y;
			clone.angle = this.angle;
			clone.scaleX = this.scaleX;
			clone.scaleY = this.scaleY;
			clone.a = this.a;
		}

		public	function copy ():SpatialInfo
		{
			var	c:SpatialInfo = new SpatialInfo ();
			
			clone (c);
			
			return c;
		}
		
		public	function	unmapFromParent(parentInfo:SpatialInfo):void
		{
			angle += parentInfo.angle;
			scaleX *= parentInfo.scaleX;
			scaleY *= parentInfo.scaleY;
			a *= parentInfo.a;
			
			if (x != 0 || y != 0)  
			{
				var	new_angle:Number = deg2rad (Spriter.fixRotation (parentInfo.angle));
				var	preMultX:Number = x * parentInfo.scaleX;
				var	preMultY:Number = y * parentInfo.scaleY;
				var	s:Number = Math.sin (new_angle);
				var	c:Number = Math.cos (new_angle);
				x = (preMultX * c) - (preMultY * s);
				y = (preMultX * s) + (preMultY * c);
				x += parentInfo.x;
				y += parentInfo.y;
			}
			else 
			{
				// Mandatory optimization for future features           
				x = parentInfo.x;
				y = parentInfo.y;
			}
		}
	}
}