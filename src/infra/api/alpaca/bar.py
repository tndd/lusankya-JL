import os
from dataclasses import dataclass
from datetime import datetime
from typing import Optional

from alpaca.data import BarSet
from alpaca.data.historical import StockHistoricalDataClient
from alpaca.data.requests import StockBarsRequest
from alpaca.data.timeframe import TimeFrame


@dataclass
class StockBarClient:
    api_key: str
    secret_key: str

    def __post_init__(self):
        self.cli = StockHistoricalDataClient(self.api_key, self.secret_key)

    def get_stock_bars_min(
            self,
            symbol: str,
            start: datetime,
            end: datetime,
            limit: Optional[int]=None
    ) -> str:
        return self._get_stock_bars(
            symbol,
            start,
            end,
            TimeFrame.Minute,
            limit
        )

    def get_stock_bars_hour(
        self,
        symbol: str,
        start: datetime,
        end: datetime,
        limit: Optional[int]=None
    ) -> str:
        return self._get_stock_bars(
            symbol,
            start,
            end,
            TimeFrame.Hour,
            limit
        )

    def get_stock_bars_day(
            self,
            symbol: str,
            start: datetime,
            end: datetime,
            limit: Optional[int]=None
    ) -> str:
        return self._get_stock_bars(
            symbol,
            start,
            end,
            TimeFrame.Day,
            limit
        )

    def get_stock_bars_week(
            self,
            symbol: str,
            start: datetime,
            end: datetime,
            limit: Optional[int]=None
    ) -> str:
        return self._get_stock_bars(
            symbol,
            start,
            end,
            TimeFrame.Week,
            limit
        )

    def get_stock_bars_month(
        self,
        symbol: str,
        start: datetime,
        end: datetime,
        limit: Optional[int]=None
    ) -> str:
        return self._get_stock_bars(
            symbol,
            start,
            end,
            TimeFrame.Month,
            limit
        )

    def _get_stock_bars(
        self,
        symbol: str,
        start: str,
        end: str,
        timeframe: TimeFrame,
        limit: Optional[int]=None
    ) -> str:
        request = StockBarsRequest(
            symbol_or_symbols=symbol,
            start=datetime.fromisoformat(start),
            end=datetime.fromisoformat(end),
            timeframe=timeframe,
            limit=limit
        )
        bars = self.cli.get_stock_bars(request)
        return self._to_json_str(bars, symbol)

    @staticmethod
    def _to_json_str(bars: BarSet, symbol:str) -> str:
        body = bars.data[symbol]
        bars_str_list = [bar.model_dump_json() for bar in body]
        return '[' + ', '.join(bars_str_list) + ']'


if __name__ == "__main__":
    from dotenv import load_dotenv

    load_dotenv()
    api_key = os.getenv("APCA_API_KEY_ID")
    secret_key = os.getenv("APCA_API_SECRET_KEY")

    stock_bar_cli = StockBarClient(api_key, secret_key)
    resp = stock_bar_cli.get_stock_bars_day(
        symbol="MSFT",
        start="2020-01-01",
        end="2023-12-13",
        limit=10
    )
    print(resp)

    with open('out.json', 'w') as f:
        f.write(resp)
