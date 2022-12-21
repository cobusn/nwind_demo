from dkit.etl.model import ETLServices, Entity
from pattern.text.en import singularize


def get_tables():
    with open("tables", "rt") as infile:
        for line in infile:
            table = line.strip()
            if table not in ["employee_territories", "order_details"]:
                yield table


def update_primary_keys(model):
    entities = model.entities
    for table in get_tables():
        key_name = singularize(table)
        print(f"updating table schema: {table}")
        v = entities[table].as_entity_validator()
        v.schema[f"{key_name}ID"]["primary_key"] = True
        model.entities[table] = Entity.from_cerberus(v.schema)


if __name__ == "__main__":
    services = ETLServices.from_file("model.yml")
    model = services.model
    update_primary_keys(services.model)
    model.save("model.yml")
