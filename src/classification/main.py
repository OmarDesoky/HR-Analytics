import preprocess
from joblib import dump, load
import matplotlib.pyplot as plt
import pandas as pd
from sklearn.linear_model import LogisticRegression
from sklearn.neighbors import KNeighborsClassifier
from sklearn.naive_bayes import GaussianNB
from sklearn.tree import DecisionTreeClassifier
from sklearn import metrics
from sklearn.svm import SVC
import os




def CLF(X_train, x_test, Y_train, y_test, clf_name):
    # Accuracies:
    #      train:   val:  precision:    recall:     test
    # GLM: 0.93     0.87    0.83        0.25        0.35
    # KNN: 0.92     0.66    0.67        0.13        --
    # GNB: 0.8      0.7     0.27        0.23        0.259
    # DT:  0.89     0.68    0.37        0.42        0.426
    # SVC: 0.917    0.68    --          --          0.29

    print (f'Classifing using: {clf_name} cLassifier')
    if clf_name == "LogisticRegression":
        clf = LogisticRegression(max_iter=3000)
    elif clf_name == "KNeighborsClassifier":
        clf = KNeighborsClassifier(n_neighbors=5)
    elif clf_name == "GaussianNB":
        clf = GaussianNB()
    elif clf_name == "DecisionTreeClassifier":
        clf = DecisionTreeClassifier()
    elif clf_name == "SVC":
        clf = SVC()

    clf.fit(X_train, Y_train)
    y_pred = clf.predict(x_test)
    print (f'Training accuracy: {metrics.accuracy_score(y_test, y_pred)}')
    if clf_name != "SVC":
        y_pred_prob = clf.predict_proba(x_test)[:,1]
        fpr, tpr, thsh = metrics.roc_curve(y_test, y_pred_prob)
        plt.plot(fpr,tpr)
        plot_name = "ROC_"+clf_name+".png"
        plt.savefig(plot_name)
        auc = metrics.roc_auc_score(y_test, y_pred_prob)
        print(f'AUC: {round(auc,2)}')
        # Model Precision: what percentage of positive tuples are labeled as such?
        print("Precision:",metrics.precision_score(y_test, y_pred))

        # Model Recall: what percentage of positive tuples are labelled as such?
        print("Recall:",metrics.recall_score(y_test, y_pred))
    return clf



def CLF_predict(clf, clf_name):
    # get test data
    X, emp_id = preprocess.return_test_data()
    y_pred = clf.predict(X)
    if clf_name == "SVC":
        y_pred_int = []
        for yp in y_pred:
            if yp > 0.5: 
                y_pred_int.append(1)
            else:
                y_pred_int.append(0)
        y_pred = y_pred_int

    dict= {'employee_id':emp_id, 'is_promoted':y_pred}  
    df = pd.DataFrame(dict,columns=['employee_id','is_promoted'])
    file_name = "results_"+clf_name+".csv"
    df.to_csv(file_name,  index=False)
    return

if __name__ == "__main__":

    X_train, x_test, Y_train, y_test = preprocess.preprocess()
    clf_names = ["LogisticRegression", "KNeighborsClassifier", "GaussianNB", "DecisionTreeClassifier", "SVC"]
    print("Data is loaded successfully ..")
    print("Please pick one of these classifiers to be used:")
    for i,c in enumerate(clf_names):
        print(f'To use: {c} \t\tpress {i}')
    action = int(input(">> "))
    
    if action >= len(clf_names) or action<0:
        print("invalid index.. goodbye")
        
    clf_name = clf_names[i]

    model_name = "model_"+clf_name+".h5"
    if os.path.exists(model_name):
        print("Model already exists")
        act = str(input("To load press l, to train press any other key\n"))
        if act == "l":
            clf = load(model_name)
        else:
            clf = CLF(X_train, x_test, Y_train, y_test, clf_name)
    else:
        clf = CLF(X_train, x_test, Y_train, y_test, clf_name)

    dump(clf, model_name)
    CLF_predict(clf, clf_name)