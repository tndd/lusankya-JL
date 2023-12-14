from dataclasses import dataclass

from alpaca.trading.client import TradingClient
from alpaca.trading.enums import AssetClass
from alpaca.trading.requests import GetAssetsRequest


@dataclass
class AssetClient:
    api_key: str
    secret_key: str

    def __post_init__(self):
        self.cli = TradingClient(self.api_key, self.secret_key)

    def fetch_stock_assets(self) -> str:
        return self._fetch_assets(asset_class=AssetClass.US_EQUITY)

    def fetch_crypto_assets(self) -> str:
        return self._fetch_assets(asset_class=AssetClass.CRYPTO)

    def _fetch_assets(self, asset_class: AssetClass) -> str:
        search_params = GetAssetsRequest(asset_class=asset_class)
        assets = self.cli.get_all_assets(search_params)
        assets_dictlist = [asset.model_dump_json() for asset in assets]
        return '[' + ', '.join(assets_dictlist) + ']'


if __name__ == "__main__":
    import os

    from dotenv import load_dotenv

    load_dotenv()
    api_key = os.getenv("APCA_API_KEY_ID")
    secret_key = os.getenv("APCA_API_SECRET_KEY")

    asset_cli = AssetClient(api_key, secret_key)
    resp = asset_cli.fetch_stock_assets()
    print(resp)
    with open('out.json', 'w') as f:
        f.write(resp)
