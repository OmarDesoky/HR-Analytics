import preprocess
from sklearn.linear_model import LogisticRegression
from sklearn import metrics

def clf_1():
    X_train, x_test, Y_train, y_test = preprocess.preprocess()
    reg = LogisticRegression(max_iter=700)
    reg.fit(X_train, Y_train)
    y_pred = reg.predict(x_test)
    # conf_matrix = metrics.plot_confusion_matrix(reg, x_test, y_test, cmap="GnBu")
    print (f'Accuracy: {metrics.accuracy_score(y_test, y_pred)}')

clf_1()