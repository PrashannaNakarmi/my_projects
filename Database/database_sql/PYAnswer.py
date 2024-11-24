#------------------------------------------question 1--------------------------------------------------
import cx_Oracle

#connect to database
try:
    constr = 'supreme/supreme@localhost:1521/xe'
    conn = cx_Oracle.connect(constr)
except cx_Oracle.DatabaseError as Exception:
    print("\nCouldn't connect to the data base , Check for possible errors\n")
    print("Exception\n")

#connect cursor
cur = conn.cursor()
print(conn.version)

category_id = []  #empty list to store values
all_ids = []  
cur.execute("select * from CATEGORY")

all_ids = cur.fetchall()  #fetches all the rows and stores them in the list

for i in all_ids:
    category_id.append(i[0])

#Max function to find the maximum exixting CATRGORY ID in the list
max = max(category_id)
max += 1      #increment value by 1                                                                                                                                                            

row1 = [] #list to store results

#takes user input of category
category = input("Enter category name: ")

cur.execute("select CATEGORYID,NAME from CATEGORY WHERE NAME = :category",{'category':category}) #using bind variables to store the input

row1 = cur.fetchall()
#check if the category entered by user exixts or not
if not row1:
    print("\nNo value found in category table\n")

    add_newValue = input("Enter 'Y' to add new category, 'N' to exit: ")

    while(True):  #if there is no such category, ask user to add new category
        row2 = []
        if (add_newValue == 'Y' or add_newValue == 'y'):
            new_categoryName = input("\nEnter new category Name: ")

            cur.execute("select NAME from CATEGORY where NAME =: new_categoryName",{'new_categoryName':new_categoryName})
            row2 = cur.fetchall()

            if row2: #if the category entered exists ask user again
                print(f"\n{new_categoryName} category Name already exist, Please enter new name...\n")
                continue

            if not row2:  #insert new category name and id into the table
                cur.execute("insert into CATEGORY(CATEGORYID,NAME) VALUES(:max_categoryID,:new_categoryName)",{'max_categoryID':max,'new_categoryName':new_categoryName})
                print("\n..Sucessfully Inserted")
                more = input("\nEnter 'Y' to add another category name, 'N' to exit : ")
                if (more == 'Y' or more == 'y'):
                    continue
                else:
                    break
        else:
            print("\n... Thank you for joining with us...\n")
            break
else:
    print(row1)
    print(f"\n{category} category name exists\n") #prints when the category name exists

# commit the values in the table
conn.commit()
# close the cur and conn
cur.close()
conn.close()

#.......................................................................................
#------------------------------------question 2-----------------------------------------
import cx_Oracle

#connect to database
try:
    constr = 'supreme/supreme@localhost:1521/xe'
    conn = cx_Oracle.connect(constr)
except cx_Oracle.DatabaseError as Exception:
    print("\nCouldn't connect to the data base , Check for possible errors\n")
    print("Exception\n")

#connect cursor
cur = conn.cursor()
print(conn.version)

filling=[] #empty list to store fillingID
fill_id=[]

# executing query
cur.execute("SELECT * FROM FILLING")
filling = cur.fetchall()

#append the filling id to the existing fillingid
for i in filling:
    fill_id.append(i[0])

#find maximum existing fillingid
max = max(fill_id) 

#loop to ask user to input filling values
while(True):
    fillname=[]
    pricepergram=[]
    calpergram=[]
    categoryid=[]

    max += 1      #increment value by 1  

    #take user input for filling table
    fill_name = str(input("Enter new filling name: "))

    #check if the filling name already exists
    cur.execute("Select NAME from filling where NAME =: fill_name",{'fill_name':fill_name})
    fillname = cur.fetchall()

    if fillname:
        print(f"\nFilling Name already exists")
        continue
    
    if not fillname:
        category_id =(input ("Enter the Category ID: "))
        #check if categoryID exsist or not
        cur.execute("Select CATEGORYID from CATEGORY where CATEGORYID =: category_id",{'category_id':category_id})
        categoryid = cur.fetchall()

        if not categoryid:
            print(f"\nCategoryID does not exists")
            continue

        if categoryid:
            price_per_gram = int(input("Enter price per gram: "))
            calories_per_gram = int(input("Enter calories per gram: "))

            cur.execute("insert into FILLING(FILLINGID,NAME,GRAMPRICE,GRAMCALORIES,CATEGORYID) VALUES(:max_fillid,:fill_name,:price_per_gram,:calories_per_gram,:categoryid)",{'max_fillid':max,'fill_name':fill_name,'price_per_gram':price_per_gram,'calories_per_gram':calories_per_gram,'categoryid':category_id})

            print("New filling added sucessfully")

    # Asking the user if they want to add another filling if y the code will continue and if n the code will exit 
    more = input("\nEnter 'Y' to add another filling name, 'N' to exit : \n")
    if (more == 'Y' or more == 'y'):
        continue
    else:
        print("....Thank you for joining with us....")
        break
# commit the values in the table
conn.commit()
# close the cur and conn
cur.close()
conn.close()


#...........................................................................................
#------------------------------------question 3----------------------------------------------
import cx_Oracle

#connect to database
try:
    constr = 'hr/hr@localhost:1521/xe'
    conn = cx_Oracle.connect(constr)
except cx_Oracle.DatabaseError as Exception:
    print("\nCouldn't connect to the data base , Check for possible errors\n")
    print("Exception\n")

#connect cursor
cur = conn.cursor()
print(conn.version)


#takes user for an Order ID
orderid = input("Enter an Order ID: ")

# Call check_cashback function and store the result in a variable
result = cur.callfunc("check_cashback", str, [orderid])

# Print the result
print(result)

# Close the cursor and connection
cur.close()
conn.close()