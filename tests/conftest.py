import pytest


@pytest.fixture(autouse=True)
def sleepless(mocker):
    """Mock time.sleep() as pass"""

    def mock_sleep(seconds):
        """Does nothing"""
        pass

    mocker.patch("time.sleep", mock_sleep)
