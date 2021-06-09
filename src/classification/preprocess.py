import pandas as pd
from pandas.api.types import is_numeric_dtype, is_string_dtype
from sklearn.preprocessing import OneHotEncoder
from sklearn.model_selection import train_test_split


def show_null_featurs(df):
    # print (df.describe())
    missing_count = df.isnull().sum()
    value_count = df.isnull().count()
    missing_percentage = round(missing_count/value_count*100,1)
    missing_df = pd.DataFrame({'count':missing_count, 'percentage':missing_percentage})
    print (missing_df)

def drop_missing_rows(df):
    df = df.dropna(subset=["previous_year_rating"])
    return df
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
    return df


def one_hot_encode_cat(df, cat):
    # creating instance of one-hot-encoder
    enc = OneHotEncoder(handle_unknown='ignore')
    # passing bridge-types-cat column (label encoded values of bridge_types)
    for i in cat:
        enc_df = pd.DataFrame(enc.fit_transform( df[[i]] ).toarray())
        #Set columns names
        col_naems = enc.get_feature_names()
        enc_df.columns = col_naems
        # merge with main df bridge_df on key values
        df = df.join(enc_df)
        # remove original columns
        df = df.drop([i],axis=1)
    return df
    

def divide_data(df):
    X = df.iloc[:, :-1]
    Y = df['is_promoted']
    x_train, x_test, y_train, y_test = train_test_split(X, Y, test_size=0.2, random_state=42)
    print (f'x_train.shape: {x_train.shape}')
    print (f'y_train.shape: {y_train.shape}')
    print (f'x_test.shape: {x_test.shape}')
    print (f'y_test.shape: {y_test.shape}')
    return x_train, x_test, y_train, y_test
    



def preprocess(path = "../../data/train_data.csv"):
    df = pd.read_csv(path)

    #eliminate nulls
    df = drop_missing_rows(df)
    num, cat = get_num_cat (df)
    df = cure_missing_data(df, num, cat)

    #one hot encoding
    df = one_hot_encode_cat(df, cat)

    #spit data
    return divide_data(df)



