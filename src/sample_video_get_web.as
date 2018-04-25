package
{
	import flash.display.Sprite;
	import flash.events.NetStatusEvent;
	import flash.media.Video;
	import flash.net.NetConnection;
	import flash.net.NetStream;
	
	/**
	 * 拉流Demo
	 */
	public class sample_video_get_web extends Sprite
	{
		private var video : Video
		private var nc : NetConnection;
		private var ns : NetStream;
		private var client : FMSClient;
		
		private var url1 : String = "rtmp://jqrfms.tangdi.net:1935/FMSServer";  
		
		public function sample_video_get_web()
		{
			nc = new NetConnection();
			nc.client = new FMSClient();  //FMSClient类必须有
			nc.connect(url1);
			nc.addEventListener(NetStatusEvent.NET_STATUS,netStatusHandler);
		}
		
		
		protected function netStatusHandler(event:NetStatusEvent):void
		{
			trace("connected is: " + nc.connected);
			trace("event.info.level: " + event.info.level);
			trace("event.info.code: " + event.info.code);
			
			switch(event.info.code)
			{
				case "NetConnection.Connect.Success":
				{
					trace("连接成功"+nc);
					
					did(nc);
					break;
				}
					
				default:
				{
					break;
				}
			}
		}
		
		private function did(nc:NetConnection):void
		{
			
			ns = new NetStream(nc);
			ns.client = new FMSClient();
			
			video = new Video(640,480);
			video.attachNetStream(ns);
			ns.play("123123123");  //流名 streamName  
			addChild(video); 
		}
	}
	
}