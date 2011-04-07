package com.kaltura.kmc.modules.content.commands
{
	import com.adobe.cairngorm.control.CairngormEvent;
	import com.kaltura.commands.media.MediaAdd;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmc.modules.content.events.MediaEvent;
	import com.kaltura.kmc.modules.content.events.WindowEvent;
	import com.kaltura.kmc.modules.content.model.states.WindowsStates;
	import com.kaltura.vo.KalturaMediaEntry;

	public class AddMediaCommand extends KalturaCommand {
		
		private var _openDrilldown:Boolean;
		
		override public function execute(event:CairngormEvent):void 
		{
			var mediaEvent:MediaEvent = event as MediaEvent;
			_openDrilldown = mediaEvent.openDrilldown;
			var addMedia:MediaAdd = new MediaAdd(mediaEvent.entry);
			addMedia.addEventListener(KalturaEvent.COMPLETE, result);
			addMedia.addEventListener(KalturaEvent.FAILED, fault);
			
			_model.context.kc.post(addMedia);
		}
		
		override public function result(data:Object):void {
			_model.entryDetailsModel.selectedEntry = data.data as KalturaMediaEntry;
			if (_openDrilldown) {	
				var cgEvent:WindowEvent = new WindowEvent(WindowEvent.OPEN, WindowsStates.ENTRY_DETAILS_WINDOW_NEW_ENTRY);
				cgEvent.dispatch();
			}
		}
		
	}
}