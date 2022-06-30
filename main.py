"""Main function"""
import argparse

"""Add code here"""


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "--config", help="Config file", type=str, default="configs/config.yaml"
    )
    args = parser.parse_args()

    """Add code here"""
