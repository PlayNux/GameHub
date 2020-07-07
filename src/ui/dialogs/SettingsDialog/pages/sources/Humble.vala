/*
This file is part of GameHub.
Copyright (C) 2018-2019 Anatoliy Kashkin

GameHub is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

GameHub is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with GameHub.  If not, see <https://www.gnu.org/licenses/>.
*/

using Gtk;
using GameHub.UI.Widgets;
using GameHub.UI.Widgets.Settings;

using GameHub.Utils;

namespace GameHub.UI.Dialogs.SettingsDialog.Pages.Sources
{
	public class Humble: SettingsDialogPage
	{
		private Settings.Auth.Humble humble_auth;
		private Button logout_btn;
		private FileChooserEntry games_dir_chooser;

		public Humble(SettingsDialog dlg)
		{
			Object(
				dialog: dlg,
				title: "Humble Bundle",
				description: _("Disabled"),
				icon_name: "source-humble-symbolic",
				has_active_switch: true
			);
		}

		construct
		{
			var paths = Settings.Paths.Humble.instance;

			humble_auth = Settings.Auth.Humble.instance;

			humble_auth.bind_property("enabled", this, "active", BindingFlags.SYNC_CREATE | BindingFlags.BIDIRECTIONAL);

			add_switch(_("Load games from Humble Trove"), humble_auth.load_trove_games, v => { humble_auth.load_trove_games = v; update(); request_restart(); });

			add_separator();

			//games_dir_chooser = add_file_chooser(_("Games directory"), FileChooserAction.SELECT_FOLDER, paths.humble_games, v => { paths.humble_games = v; update(); request_restart(); }).get_children().last().data as FileChooserEntry;

			notify["active"].connect(() => {
				//request_restart();
				update();
			});

			logout_btn = new Button.with_label(_("Logout"));
			//action_area.add(logout_btn);

			logout_btn.clicked.connect(() => {
				humble_auth.authenticated = false;
				humble_auth.access_token = "";
				request_restart();
				update();
			});

			update();
		}

		private void update()
		{
			/*
			logout_btn.sensitive = humble_auth.authenticated && humble_auth.access_token.length > 0;

			if(" " in FS.Paths.Settings.instance.humble_games)
			{
				games_dir_chooser.get_style_context().add_class(Gtk.STYLE_CLASS_ERROR);
				status_type = StatusType.ERROR;
			}
			else
			{
				games_dir_chooser.get_style_context().remove_class(Gtk.STYLE_CLASS_ERROR);
				status_type = restart_requested ? StatusType.WARNING : StatusType.NONE;
			}
			dialog.update_games_dir_space_message();

			if(!humble_auth.enabled)
			{
				description = _("Disabled");
			}
			else if(!humble_auth.authenticated || humble_auth.access_token.length == 0)
			{
				description = _("Not authenticated");
			}
			else
			{
				description = _("Authenticated");
			}*/
		}

	}
}
