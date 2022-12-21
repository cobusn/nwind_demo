from dkit.etl.model import ETLServices


def update_transform(model):
    t = model.transforms["update_extract"]
    t["month"] = 'int(strftime(${orderDate}, "%Y%m"))'
    t["total"] = '${quantity} * ${unitPrice}'
    model.transforms["update_extract"] = t


if __name__ == "__main__":
    services = ETLServices.from_file("model.yml")
    model = services.model
    update_transform(model)
    model.save("model.yml")
