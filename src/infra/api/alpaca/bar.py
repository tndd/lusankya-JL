from alpaca.data.historical import StockHistoricalDataClient
from alpaca.data.requests import StockBarsRequest
from dotenv import load_dotenv
from datetime import datetime
from alpaca.data.timeframe import TimeFrame
from alpaca.data import BarSet
import os
import json
from dataclasses import dataclass
from typing import Optional

load_dotenv()
api_key = os.getenv("APCA_API_KEY_ID")
secret_key = os.getenv("APCA_API_SECRET_KEY")

client = StockHistoricalDataClient(api_key, secret_key)

request = StockBarsRequest(
    symbol_or_symbols="MSFT",
    start=datetime(2000,1,1),
    end=datetime(2023,12,13),
    timeframe=TimeFrame.Minute,
    limit=10
)

bars = client.get_stock_bars(request)
body = list(bars.data.values())[0]
dictlist = [{k: v.isoformat() if k == 'timestamp' else v for k, v in d.__dict__.items()} for d in body]
# print(dictlist)

with open('out.json', 'w') as f:
    json.dump(dictlist, f)


@dataclass
class StockBarClient:
    api_key: str
    secret_key: str

    def __post_init__(self):
        self.cli = StockHistoricalDataClient(api_key, secret_key)

    def get_stock_bars_min(
            self,
            symbol: str,
            start: datetime,
            end: datetime,
            limit: Optional[int]=None
    ) -> str:
        return self.get_stock_bars(
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
        return self.get_stock_bars(
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
        return self.get_stock_bars(
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
        return self.get_stock_bars(
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
        return self.get_stock_bars(
            symbol,
            start,
            end,
            TimeFrame.Month,
            limit
        )

    def _get_stock_bars(
        self,
        symbol: str,
        start: datetime,
        end: datetime,
        timeframe: TimeFrame,
        limit: Optional[int]=None
    ) -> str:
        request = StockBarsRequest(
            symbol_or_symbols=symbol,
            start=start,
            end=end,
            timeframe=timeframe,
            limit=limit
        )
        bars = self.cli.get_stock_bars(request)
        return self.to_json_str(bars, symbol)

    @staticmethod
    def _to_json_str(bars: BarSet, symbol:str) -> str:
        body = bars.data[symbol]
        listdict = [
            {
                k: v.isoformat()
                if k == 'timestamp' else v
                for k, v in d.__dict__.items()
            }
            for d in body
        ]
        return json.dumps(listdict)


if __name__ == "__main__":
    load_dotenv()
    api_key = os.getenv("APCA_API_KEY_ID")
    secret_key = os.getenv("APCA_API_SECRET_KEY")

    stock_bar_cli = StockBarClient(api_key, secret_key)
    resp = stock_bar_cli.get_stock_bars(
        symbol="MSFT",
        start=datetime(2000,1,1),
        end=datetime(2023,12,13),
        timeframe=TimeFrame.Minute,
        limit=10
    )
    print(resp)
