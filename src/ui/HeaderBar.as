package ui 
{
	import assets.LoadManager;
	import assets.UserManager;
	import com.bit101.components.HBox;
	import com.bit101.components.Label;
	import com.bit101.components.Panel;
	import com.bit101.components.ProgressBar;
	import com.bit101.components.Text;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Automaticoo
	 */
	public class HeaderBar extends Sprite 
	{
		[Embed(source = '../../lib/icons/population.png')]
		private var PopulationIcon:Class;
		
		private var _panel:Panel = new Panel();
		private var _hBox:HBox = new HBox();
		private var _userNameLabel:Text;
		private var _totalMoney:Text;
		private var _progressBar:ProgressBar;
		private var _progressText:Label;
		private var _population:Text;
		private var _populationIcon:DisplayObject;
		
		public function HeaderBar() 
		{
			_panel.width = 760;
			_panel.height = 20;
			addChild(_panel);
			
			_userNameLabel = new Text(null, 0, 0, "Word geladen.");
			_userNameLabel.width = 100;
			_userNameLabel.height = 20;
			_panel.addChild(_userNameLabel);
			
			_totalMoney = new Text(null, 100, 0, "Word geladen.");
			_totalMoney.width = 100;
			_totalMoney.height = 20;
			_panel.addChild(_totalMoney);
			
			_progressBar = new ProgressBar(null, 200, 0);
			_progressBar.width = 100;
			_progressBar.height = 20;
			_panel.addChild(_progressBar);
			
			_progressText = new Label(null, 225, 0, "Word geladen.");
			_progressText.width = 100;
			_progressText.height = 20;
			_panel.addChild(_progressText);
			
			
			_population = new Text(null, 300, 0, "Word geladen.");
			_population.width = 100;
			_population.height = 20;
			_panel.addChild(_population);
			
			_populationIcon = new PopulationIcon();
			_populationIcon.x = 303;
			_populationIcon.y = 4;
			_populationIcon.width = 15;
			_populationIcon.height = 15;
			_panel.addChild(_populationIcon);
			
			LoadManager.instance.getSignedInUser(onUserLoaded);
		}		
		
		private function onUserLoaded(myUser:UserManager):void 
		{
			myUser.statistics.addEventListener(Event.CHANGE, onChange);
			_userNameLabel.text = myUser.name;
			_totalMoney.text = "€ " + String(myUser.statistics.cash);
			_progressBar.value = 0.1;
			_progressText.text = String(myUser.statistics.xp) + "/10000 xp";
			_population.text = "     " + String(myUser.statistics.population);
		}
		
		private function onChange(e:Event):void 
		{
			LoadManager.instance.getSignedInUser(function(myUser:UserManager):void {
				_totalMoney.text = "€ " + String(myUser.statistics.cash);
			});			
		}
	}
}