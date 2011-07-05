package com.kaltura.vo
{
	import com.kaltura.vo.KalturaCuePoint;

	[Bindable]
	public dynamic class KalturaAdCuePoint extends KalturaCuePoint
	{
		/** 
		* 		* */ 
		public var providerType : String;

		/** 
		* 		* */ 
		public var sourceUrl : String;

		/** 
		* 		* */ 
		public var adType : String;

		/** 
		* 		* */ 
		public var title : String;

		/** 
		* 		* */ 
		public var endTime : int = int.MIN_VALUE;

		override public function getUpdateableParamKeys():Array
		{
			var arr : Array;
			arr = super.getUpdateableParamKeys();
			arr.push('sourceUrl');
			arr.push('adType');
			arr.push('title');
			arr.push('endTime');
			return arr;
		}

		override public function getInsertableParamKeys():Array
		{
			var arr : Array;
			arr = super.getInsertableParamKeys();
			arr.push('providerType');
			return arr;
		}

	}
}
