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
	public abstract class DataProvider<T>: Provider
	{
		public override string icon { get { return "text-x-generic-symbolic"; } }

		public abstract async T data(Game game);
	}

	public static DataProvider[] DataProviders;
}
