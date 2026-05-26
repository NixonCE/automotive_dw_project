# load_data_staging.ipynb
#importing necessary libraries
from sqlalchemy import create_engine
import pandas as pd
#creating connection to the database
def load_data_staging():
    engine = create_engine('postgresql://postgres:1234@localhost:5432/car_sales_dw')
    # loading the cleaned data into a dataframe
    df = pd.read_csv('../data/processed/car_sales_cleaned.csv')
    # loading the data into the staging schema
    df.to_sql(
        name='car_sales_raw',
        con=engine,
        schema='staging',
        if_exists='replace',
        index=False
    )
    engine.dispose()
    print('listo')
load_data_staging()