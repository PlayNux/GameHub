/*
This file is part of GameManager.
Copyright (C) 2018-2019 Anatoliy Kashkin

GameManager is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

GameManager is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with GameManager.  If not, see <https://www.gnu.org/licenses/>.
*/

using Gtk;

using GameManager.UI.Windows;

namespace GameManager.UI.Views
{
	public abstract class BaseView: Grid
	{
		protected MainWindow window;
		protected HeaderBar titlebar;

		construct
		{
			titlebar = new HeaderBar();
			titlebar.title = "GameManager";
			titlebar.show_close_button = true;
		}

		public virtual void attach_to_window(MainWindow wnd)
		{
			window = wnd;
			show();
		}

		public virtual void on_show()
		{
			titlebar.show_all();
			window.set_titlebar(titlebar);
		}

		public virtual void on_window_focus()
		{

		}
	}
}
