from alpaca.data.historical import StockHistoricalDataClient
from alpaca.data.requests import StockBarsRequest
from dotenv import load_dotenv
from datetime import datetime
from alpaca.data.timeframe import TimeFrame
import os
import json

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
print(bars.data['MSFT'])

with open('out.json', 'w') as f:
    json.dump(bars.data, f)
