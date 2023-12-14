import os
from typing import List

import pytest
from dotenv import load_dotenv

from src.infra.api.alpaca.asset import AssetClient

load_dotenv()


@pytest.fixture
def api_client() -> AssetClient:
    return AssetClient(
        api_key=os.getenv('APCA_API_KEY_ID'),
        secret_key=os.getenv('APCA_API_SECRET_KEY')
    )


def test_fetch_stock_assets(api_client: AssetClient):
    """
    Testing of stock asset acquisitions.
    Checking is minimal, almost only looking to see if the value is returned.
    """
    response_data: str = api_client.fetch_stock_assets()
    assert isinstance(response_data, str), "Response from fetch_stock_assets is not a list"


def test_fetch_crypto_assets(api_client):
    """
    Testing of crypto asset acquisitions.
    Checking is minimal, almost only looking to see if the value is returned.
    """
    response_data: List[dict] = api_client.fetch_crypto_assets()
    assert isinstance(response_data, str), "Response from fetch_crypto_assets is not a list"
