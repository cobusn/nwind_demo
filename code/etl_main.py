#!/usr/bin/env python
"""
Extract, Transform and Load final orders data to s3/parquet
"""
import argparse
import logging

import awswrangler as wr
import boto3
import lib_ferret
import pyarrow as pa
from dkit.etl import source
from dkit.etl.model import ETLServices, Entity
from dkit.etl.extensions.ext_arrow import build_table, make_arrow_schema
from dkit.utilities.file_helper import yaml_load
from dkit.utilities.log_helper import init_stderr_logger


logger = init_stderr_logger(__name__, level=logging.INFO)


class ETLOrders:

    def __init__(self, args):
        with open(args.config, "rt") as infile:
            self.config = yaml_load(infile)
        self.args = args
        self.session = self.__make_session()
        self.services = ETLServices.from_file(self.args.model)
        self.entity: Entity = self.services.model.entities["final_orders"]

    def __make_session(self):
        """make boto3 session"""
        ferret = lib_ferret.from_config()
        public_key = ferret.decrypt(self.config["credentials"]["s3"]["id"])
        secret_key = ferret.decrypt(self.config["credentials"]["s3"]["key"])
        session = boto3.Session(
            aws_access_key_id=public_key,
            aws_secret_access_key=secret_key
        )
        logger.info("successfully instantiated boto3 session")
        return session

    def extract(self):
        "extract and validate from source provided"
        with source.load(self.args.source[0]) as infile:
            yield from self.entity.iter_validate(infile)

    def transform(self, data):
        """transform from raw data to table"""
        schema = make_arrow_schema(self.entity)
        return build_table(
            data,
            schema=schema,
            micro_batch_size=100
        )

    def load(self, table: pa.Table):
        """save to S3"""
        df = table.to_pandas()
        logger.info(f"writing to {self.args.s3_path}")
        wr.s3.to_parquet(
            df,
            self.args.s3_path,
            boto3_session=self.session,
            dataset=True,
            mode="overwrite_partitions",
            partition_cols=[
                "month"
            ]
        )

    def run(self):
        try:
            self.load(
                self.transform(
                    self.extract()
                )
            )
        except Exception as e:
            logger.error(f"{e.__class__.__name__}: {e}")


def main(args):
    ETLOrders(args).run()


if __name__ == "__main__":
    description = "ETL for hbu billing master data"
    parser = argparse.ArgumentParser(description=description)
    parser.add_argument('source', nargs=1, help='data source')
    parser.add_argument(
        '--config', help='configuration',
        default="config/config.yaml"
    )
    parser.add_argument('--model', default="model.yml", help='model file')
    parser.add_argument(
        "-d", "-destination", dest="s3_path",
        default="s3://northwind.db/orders",
        help="s3 destination"
    )

    main(parser.parse_args())
