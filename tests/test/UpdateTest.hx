package;


import massive.munit.util.Timer;
import massive.munit.Assert;
import massive.munit.async.AsyncFactory;
import motion.actuators.SimpleActuator;
import motion.easing.Linear;
import motion.Actuate;


class UpdateTest {
	
	
	public function new () {
		
		
		
	}
	
	
	@Test public function testDynamic ():Void {
		
		var x = 0.0;
		
		var callback = function (value:Float) {
			
			x = value;
			
		}
		
		update (0);
		
		Actuate.update (callback, 2, [ 100 ], [ 300 ]).ease (Linear.easeNone);
		
		update (0);
		
		Assert.areEqual (100, x);
				
		update (0.5);
		
		Assert.areEqual (150, x);
		
		update (1);
		
		Assert.areEqual (200, x);
		
		Actuate.stop (callback);
		
		update (2);
		
		Assert.areEqual (200, x);
		
	}
	
	
	@Test public function testClass ():Void {
		
		var objectClass = new ObjectClass (0);
		
		update (0);
		
		Actuate.update (objectClass.update, 2, [ 100 ], [ 300 ]).ease (Linear.easeNone);
		
		update (0);
		
		Assert.areEqual (100, objectClass.x);
		
		update (0.5);
		
		Assert.areEqual (150, objectClass.x);
		
		update (1);
		
		Assert.areEqual (200, objectClass.x);
		
		Actuate.stop (objectClass);
		
		update (2);
		
		Assert.areEqual (200, objectClass.x);
		
	}
	
	
	private function update (time:Float):Void {
		
		SimpleActuator.getTime = function () return time;
		#if flash
		SimpleActuator.stage_onEnterFrame (null);
		#else
		SimpleActuator.stage_onEnterFrame ();
		#end
		
	}
	
	
}


private class ObjectClass {
	
	
	public var x:Float;
	
	
	public function new (x:Float) {
		
		this.x = x;
		
	}
	
	
	public function update (value:Float):Void {
		
		x = value;
		
	}
	
	
}