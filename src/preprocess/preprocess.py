import pandas as pd
from pandas.api.types import is_numeric_dtype, is_string_dtype

df = pd.read_csv("../../data/train_data.csv")


def show_null_featurs(df):
    # print (df.describe())
    missing_count = df.isnull().sum()
    value_count = df.isnull().count()
    missing_percentage = round(missing_count/value_count*100,1)
    missing_df = pd.DataFrame({'count':missing_count, 'percentage':missing_percentage})
    print (missing_df)

def drop_missing_rows(df):
    df = df.dropna(subset=["previous_year_rating"])
    # show_null_featurs(df)


def get_num_cat (df):
    num = []
    cat = []
    for col in df:
        if is_numeric_dtype(df[col]):
            num.append(col)
        elif is_string_dtype(df[col]):
            cat.append(col)
    return num, cat

def cure_missing_data(df, num, cat):
    for i in cat:
        if df[i].isnull().any():
            df[i].fillna("unknown",inplace=True)
    for i in num:
        if df[i].isnull().any():
            df[i].fillna(df[i].mean(),inplace=True)
    show_null_featurs(df)


