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

using Gee;
using GameManager.Utils;

namespace GameManager.Data.Providers
{
	public abstract class ImagesProvider: Provider
	{
		public override string icon { get { return "image-x-generic"; } }

		public abstract async ArrayList<Result> images(Game game);

		public class Result: Object
		{
			public string?           name   { get; set; default = null; }
			public string?           url    { get; set; default = null; }
			public ArrayList<Image>? images { get; set; default = null; }
			public ImageSize         image_size { get; set; default = ImageSize(460, 215); }
		}

		public class Image: Object
		{
			public string  url         { get; protected construct set; }
			public string? description { get; protected construct set; default = null; }

			public Image(string url, string? description=null)
			{
				Object(url: url, description: description);
			}
		}

		public struct ImageSize
		{
			public int width;
			public int height;

			public ImageSize(int w, int h)
			{
				width = w;
				height = h;
			}
		}
	}

	public static ImagesProvider[] ImageProviders;
}
