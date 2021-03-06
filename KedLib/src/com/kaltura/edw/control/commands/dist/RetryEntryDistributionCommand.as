package com.kaltura.edw.control.commands.dist
{
	import com.kaltura.commands.entryDistribution.EntryDistributionRetrySubmit;
	import com.kaltura.edw.control.commands.KedCommand;
	import com.kaltura.edw.control.events.EntryDistributionEvent;
	import com.kaltura.edw.model.datapacks.DistributionDataPack;
	import com.kaltura.events.KalturaEvent;
	import com.kaltura.kmvc.control.KMvCEvent;
	import com.kaltura.vo.KalturaEntryDistribution;

	public class RetryEntryDistributionCommand extends KedCommand
	{
		private var _entryDis:KalturaEntryDistribution;
		
		override public function execute(event:KMvCEvent):void {
			_model.increaseLoadCounter();
			_entryDis = (event as EntryDistributionEvent).entryDistribution;
			var retry:EntryDistributionRetrySubmit = new EntryDistributionRetrySubmit(_entryDis.id);
			retry.addEventListener(KalturaEvent.COMPLETE, result);
			retry.addEventListener(KalturaEvent.FAILED, fault);
			
			_client.post(retry);
		}
		
		override public function result(data:Object):void {
			_model.decreaseLoadCounter();
			super.result(data);
			var updateResult:KalturaEntryDistribution = data.data as KalturaEntryDistribution;
			_entryDis.status = updateResult.status;

			//for data binding
			
			var ddp:DistributionDataPack = _model.getDataPack(DistributionDataPack) as DistributionDataPack;
			ddp.distributionInfo.entryDistributions = ddp.distributionInfo.entryDistributions.concat();
		}
	}
}