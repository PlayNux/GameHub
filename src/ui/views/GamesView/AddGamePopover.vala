using Gtk;
using Gdk;
using Gee;
using Granite;
using GameHub.Data;
using GameHub.Data.DB;
using GameHub.Utils;
using GameHub.UI.Widgets;

using GameHub.Data.Sources.User;

namespace GameHub.UI.Views.GamesView
{
	public class AddGamePopover: Popover
	{
		public signal void game_added(UserGame game);

		private Grid grid;
		private int rows = 0;

		private new Entry name;
		private FileChooserButton gamedir;
		private FileChooserButton executable;
		private Entry arguments;
		private new Button add;

		public AddGamePopover(Widget? relative_to)
		{
			Object(relative_to: relative_to);
		}

		construct
		{
			grid = new Grid();
			grid.margin = 8;
			grid.row_spacing = 4;
			grid.column_spacing = 12;

			name = add_entry(_("Name"), "insert-text-symbolic");
			gamedir = add_filechooser(_("Directory"), _("Select game directory"), FileChooserAction.SELECT_FOLDER);
			executable = add_filechooser(_("Executable"), _("Select game executable"));
			arguments = add_entry(_("Arguments"), "utilities-terminal-symbolic");

			add = new Button.with_label(_("Add game"));
			add.margin_top = 4;
			add.get_style_context().add_class(Gtk.STYLE_CLASS_SUGGESTED_ACTION);
			add.sensitive = false;

			grid.attach(add, 0, rows, 2, 1);

			name.changed.connect(update);
			gamedir.file_set.connect(update);
			executable.file_set.connect(update);
			arguments.changed.connect(update);

			update();

			add.clicked.connect(add_game);

			child = grid;
			grid.show_all();
		}

		private void update()
		{
			add.sensitive = name.text.strip().length > 0
				&& gamedir.get_file() != null && gamedir.get_file().query_exists()
				&& executable.get_file() != null && executable.get_file().query_exists();
		}

		private void add_game()
		{
			var game = new UserGame(name.text.strip(), gamedir.get_file(), executable.get_file(), arguments.text.strip());
			name.text = "";
			gamedir.unselect_all();
			executable.unselect_all();
			arguments.text = "";
			update();
			Tables.Games.add(game);
			game_added(game);
			#if GTK_3_22
			popdown();
			#else
			hide();
			#endif
		}

		private Entry add_entry(string text, string icon)
		{
			var label = new Label(text);
			label.halign = Align.END;
			label.xalign = 1;
			var entry = new Entry();
			entry.primary_icon_name = icon;
			entry.primary_icon_activatable = false;
			entry.set_size_request(220, -1);
			grid.attach(label, 0, rows);
			grid.attach(entry, 1, rows);
			rows++;
			return entry;
		}

		private FileChooserButton add_filechooser(string text, string title, FileChooserAction action=FileChooserAction.OPEN)
		{
			var label = new Label(text);
			label.halign = Align.END;
			label.xalign = 1;
			var button = new FileChooserButton(title, action);
			button.set_size_request(220, -1);
			grid.attach(label, 0, rows);
			grid.attach(button, 1, rows);
			rows++;
			return button;
		}
	}
}