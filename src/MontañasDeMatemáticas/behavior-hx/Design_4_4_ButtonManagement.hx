package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.Script.*;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;
import com.stencyl.models.Joystick;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.Key;
import com.stencyl.utils.Utils;

import openfl.ui.Mouse;
import openfl.display.Graphics;
import openfl.display.BlendMode;
import openfl.display.BitmapData;
import openfl.display.Bitmap;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.events.TouchEvent;
import openfl.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_4_4_ButtonManagement extends ActorScript
{
	public var _ButtonFont:Font;
	public var _ButtonState:Float;
	public var _Label:String;
	public var _NormalAnimation:String;
	public var _PositiveAnimation:String;
	public var _NegativeAnimation:String;
	public var _HighlightedAnimation:String;
	
	
	public function new(dummy:Int, actor:Actor, dummy2:Engine)
	{
		super(actor);
		nameMap.set("Actor", "actor");
		nameMap.set("Button Font", "_ButtonFont");
		nameMap.set("Button State", "_ButtonState");
		_ButtonState = 0.0;
		nameMap.set("Label", "_Label");
		_Label = "";
		nameMap.set("Normal Animation", "_NormalAnimation");
		nameMap.set("Positive Animation", "_PositiveAnimation");
		nameMap.set("Negative Animation", "_NegativeAnimation");
		nameMap.set("Highlighted Animation", "_HighlightedAnimation");
		
	}
	
	override public function init()
	{
		
		/* ========================= When Drawing ========================= */
		addWhenDrawingListener(null, function(g:G, x:Float, y:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				g.setFont(_ButtonFont);
				g.drawString("" + _Label, ((actor.getWidth()/2) - (g.font.font.getTextWidth(_Label)/Engine.SCALE / 2)), ((actor.getHeight()/2) - (g.font.getHeight()/Engine.SCALE / 2)));
			}
		});
		
		/* ======================== When Updating ========================= */
		addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled)
			{
				if((_ButtonState == 0))
				{
					actor.setAnimation("" + _NormalAnimation);
				}
				else if((_ButtonState == 1))
				{
					actor.setAnimation("" + _PositiveAnimation);
				}
				else if((_ButtonState == 2))
				{
					actor.setAnimation("" + _NegativeAnimation);
				}
				else
				{
					actor.setAnimation("" + _HighlightedAnimation);
				}
			}
		});
		
		/* =========================== On Actor =========================== */
		addMouseOverActorListener(actor, function(mouseState:Int, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && 1 == mouseState)
			{
				if((_ButtonState == 0))
				{
					_ButtonState = asNumber(3);
					propertyChanged("_ButtonState", _ButtonState);
				}
			}
		});
		
		/* =========================== On Actor =========================== */
		addMouseOverActorListener(actor, function(mouseState:Int, list:Array<Dynamic>):Void
		{
			if(wrapper.enabled && -1 == mouseState)
			{
				if((_ButtonState == 3))
				{
					_ButtonState = asNumber(0);
					propertyChanged("_ButtonState", _ButtonState);
				}
			}
		});
		
	}
	
	override public function forwardMessage(msg:String)
	{
		
	}
}