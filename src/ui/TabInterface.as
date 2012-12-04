package ui 
{
	import com.bit101.components.TabPanel;
	import flash.display.Sprite;
	import ui.tabs.BaseTab;
	import ui.tabs.DecorationTab;
	import ui.tabs.HouseTab;
	import ui.tabs.PaintTab;
	
	/**
	 * ...
	 * @author ...
	 */
	public class TabInterface extends Sprite 
	{
		
		public function TabInterface()
		{
			var _tabPanel:TabPanel = new TabPanel(this);
				_tabPanel.width = 760;
				_tabPanel.y = 500;
				_tabPanel.setTabNameAt("Grondsoort", 0);
				_tabPanel.setTabNameAt("Decoratie", 1);
				_tabPanel.addTab("Huizen");
				_tabPanel.addTab("Vrienden");
				_tabPanel.height = 100;
			addChild(_tabPanel);
			
			_tabPanel.getTabAt(0).addChild(new PaintTab());
			_tabPanel.getTabAt(1).addChild(new DecorationTab());
			_tabPanel.getTabAt(2).addChild(new HouseTab());
		}
	}
}