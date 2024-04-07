import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.linear_model import Perceptron
import json

FILE = 'upark\lib\data\dummydata.csv'
MONFILE = 'upark\lib\data\dummyMonday.csv'
TUEFILE = 'upark\lib\data\dummyTuesday.csv'
WEDFILE = 'upark\lib\data\dummyWednesday.csv'
THURFILE = 'upark\lib\data\dummyThursday.csv'
FRIFILE = 'upark\lib\data\dummyFriday.csv'

train_data = pd.read_csv(FILE)
mon_test_data = pd.read_csv(MONFILE)
tue_test_data = pd.read_csv(TUEFILE)
wed_test_data = pd.read_csv(WEDFILE)
thur_test_data = pd.read_csv(THURFILE)
fri_test_data = pd.read_csv(FRIFILE)

train_data['day'] = train_data['day'].replace({'Monday': 1, 'Tuesday': 2, 'Wednesday': 3, 'Thursday': 4, 'Friday': 5})
train_data['time'] = train_data['time'].replace({'7AM': 1, '8AM': 2, '9AM': 3, '10AM': 4, '11AM': 5, '12PM': 6, '1PM': 7, '2PM': 8, '3PM': 9, '4PM': 10, '5PM': 11, '6PM': 12})

mon_test_data['day'] = mon_test_data['day'].replace({'Monday': 1})
mon_test_data['time'] = mon_test_data['time'].replace({'7AM': 1, '8AM': 2, '9AM': 3, '10AM': 4, '11AM': 5, '12PM': 6, '1PM': 7, '2PM': 8, '3PM': 9, '4PM': 10, '5PM': 11, '6PM': 12})

tue_test_data['day'] = tue_test_data['day'].replace({'Tuesday': 2})
tue_test_data['time'] = tue_test_data['time'].replace({'7AM': 1, '8AM': 2, '9AM': 3, '10AM': 4, '11AM': 5, '12PM': 6, '1PM': 7, '2PM': 8, '3PM': 9, '4PM': 10, '5PM': 11, '6PM': 12})

wed_test_data['day'] = wed_test_data['day'].replace({'Wednesday': 3})
wed_test_data['time'] = wed_test_data['time'].replace({'7AM': 1, '8AM': 2, '9AM': 3, '10AM': 4, '11AM': 5, '12PM': 6, '1PM': 7, '2PM': 8, '3PM': 9, '4PM': 10, '5PM': 11, '6PM': 12})

thur_test_data['day'] = thur_test_data['day'].replace({'Thursday': 4})
thur_test_data['time'] = thur_test_data['time'].replace({'7AM': 1, '8AM': 2, '9AM': 3, '10AM': 4, '11AM': 5, '12PM': 6, '1PM': 7, '2PM': 8, '3PM': 9, '4PM': 10, '5PM': 11, '6PM': 12})

fri_test_data['day'] = fri_test_data['day'].replace({'Friday': 5})
fri_test_data['time'] = fri_test_data['time'].replace({'7AM': 1, '8AM': 2, '9AM': 3, '10AM': 4, '11AM': 5, '12PM': 6, '1PM': 7, '2PM': 8, '3PM': 9, '4PM': 10, '5PM': 11, '6PM': 12})
    
train_data = train_data.dropna()

trainX = train_data.drop(columns=['occupancy%'])
trainY = train_data['occupancy%']

testMon = mon_test_data
testTue = tue_test_data
testWed = wed_test_data
testThur = thur_test_data
testFri = fri_test_data

X_train, X_valid, Y_train, Y_valid = train_test_split(trainX, trainY, test_size=0.1, random_state=5)
per = Perceptron()
per.fit(X_train, Y_train)

predMon = per.predict(testMon)
predTue = per.predict(testTue)
predWed = per.predict(testWed)
predThur = per.predict(testThur)
predFri = per.predict(testFri)

days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"]

pred_data = {}
for day in days:
    if day == "Monday":
        pred_data[day] = predMon.tolist()
    elif day == "Tuesday":
        pred_data[day] = predTue.tolist()
    elif day == "Wednesday":
        pred_data[day] = predWed.tolist()
    elif day == "Thursday":
        pred_data[day] = predThur.tolist()
    else:
        pred_data[day] = predFri.tolist()

with open('upark\lib\\assets\\predictions.json', 'w') as outfile:
    json.dump(pred_data, outfile, indent=4)

# with open('upark\lib\\assets\mondayPred.csv', 'w', newline='') as outfile:
#     fields = ['occupancy%']
#     writer = csv.DictWriter(outfile, fieldnames = fields)
#     writer.writeheader()
#     for id in range(0, 12):
#         writer.writerow({'occupancy%': predMon[id]})

# with open('upark\lib\\assets\\tuesdayPred.csv', 'w', newline='') as outfile:
#     fields = ['occupancy%']
#     writer = csv.DictWriter(outfile, fieldnames = fields)
#     writer.writeheader()
#     for id in range(0, 12):
#         writer.writerow({'occupancy%': predTue[id]})

# with open('upark\lib\\assets\wednesdayPred.csv', 'w', newline='') as outfile:
#     fields = ['occupancy%']
#     writer = csv.DictWriter(outfile, fieldnames = fields)
#     writer.writeheader()
#     for id in range(0, 12):
#         writer.writerow({'occupancy%': predWed[id]})

# with open('upark\lib\\assets\\thursdayPred.csv', 'w', newline='') as outfile:
#     fields = ['occupancy%']
#     writer = csv.DictWriter(outfile, fieldnames = fields)
#     writer.writeheader()
#     for id in range(0, 12):
#         writer.writerow({'occupancy%': predThur[id]})

# with open('upark\lib\\assets\\fridayPred.csv', 'w', newline='') as outfile:
#     fields = ['occupancy%']
#     writer = csv.DictWriter(outfile, fieldnames = fields)
#     writer.writeheader()
#     for id in range(0, 12):
#         writer.writerow({'occupancy%': predFri[id]})