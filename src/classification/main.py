import matplotlib.pyplot as plt
import preprocess
from sklearn.linear_model import LogisticRegression
from sklearn import metrics
import pandas as pd



def glm():
    X_train, x_test, Y_train, y_test = preprocess.preprocess()
    reg = LogisticRegression(max_iter=3000)
    reg.fit(X_train, Y_train)
    y_pred = reg.predict(x_test)
    # conf_matrix = metrics.plot_confusion_matrix(reg, x_test, y_test, cmap="GnBu")
    print (f'Accuracy: {metrics.accuracy_score(y_test, y_pred)}')
    #ROC and AUC
    y_pred_prob = reg.predict_proba(x_test)[:,1]
    fpr, tpr, thsh = metrics.roc_curve(y_test, y_pred_prob)
    plt.plot(fpr,tpr)
    plt.savefig("ROC.png")
    auc = metrics.roc_auc_score(y_test, y_pred_prob)
    print(f'AUC: {round(auc,2)}')
    return reg

def glm_predict(reg):
    # get test data
    X, emp_id = preprocess.return_test_data()
    y_pred = reg.predict(X)
    dict= {'employee_id':emp_id, 'is_promoted':y_pred}
    df = pd.DataFrame(dict,columns=['employee_id','is_promoted'])
    df.to_csv("results.csv",  index=False)
    return

reg = glm()
glm_predict(reg)