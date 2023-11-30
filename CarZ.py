import streamlit as st
import mysql.connector
import uuid
from hashlib import sha256
import re
from datetime import date

# Function to get a database connection
def get_connection():
    return mysql.connector.connect(
        host='localhost',
        user='root',
        password='Mysql@123',
        database='carz2',
    )

# Function to execute a query and fetch results as dictionaries
def execute_query(query, fetch=True):
    connection = get_connection()
    cursor = connection.cursor(dictionary=True)
    cursor.execute(query)
    if fetch:
        result = cursor.fetchall()
        connection.close()
        return result
    connection.commit()
    connection.close()

class SessionState:
    def __init__(self, **kwargs):
        self.__dict__.update(kwargs)

def get_session_state():
    if "session_state" not in st.session_state:
        st.session_state.session_state = SessionState(customer_id=None)
    return st.session_state.session_state




# Function to calculate total cost of selected configurations
def calculate_total_cost(veh_id):
    query = f"SELECT CalculateTotalCost('{veh_id}') AS TotalCost"
    result = execute_query(query)
    return result[0]['TotalCost'] if result else 0.0

# Function to allow the customer to configure a vehicle
def configure_vehicle(veh_id, base_price):
    st.subheader("Configure Your Vehicle")

    # Fetch configurations for the given vehicle
    query = f"SELECT * FROM configuration WHERE VehID = '{veh_id}'"
    configurations = execute_query(query)

    # Display each configuration along with an option to choose
    selected_configs = []
    for config in configurations:
        selected = st.checkbox(f"{config['FeatureName']} - ${config['AdditionalCost']}")
        if selected:
            selected_configs.append(config)

    # Calculate the total cost of selected configurations
    total_cost = sum(config['AdditionalCost'] for config in selected_configs)

    st.write("---")
    st.write(f"**Base Car Price:** ${base_price}")
    st.write(f"**Total Cost with Your Configurations:** ${base_price + total_cost}")

    # Display the selected configurations
    st.write("Selected Configurations:")
    for config in selected_configs:
        st.write(f"- {config['FeatureName']} - ${config['AdditionalCost']}")

    # You can perform additional actions here based on the configured options




# Function to display the home page
def display_home():
    st.title("Welcome to CarZ")
    st.write("Explore our collection of vehicles and configure them according to your preferences. It streamlines the vehicle purchasing process, offering customers an online platform for vehicle exploration, configuration, test ride scheduling, and ordering. It serves as a comprehensive solution to meet automotive industry needs, ensuring smooth operations and an exceptional customer experience.")
    st.image("images2/homeimg2.jpg", width=450)  # Replace with the path to your homepage image


# Function to display the customer popup
def display_customer_popup(customer_id):
    st.write("Customer logged in successfully!")
    st.info("Click the user icon in the top right corner to view your details.")
    st.button("Dismiss", key="dismiss_popup")

def display_user_icon(session_state):
    # Check if the user icon has already been created
    if "user_icon_created" not in st.session_state:
        # Generate a dynamic key based on the customer ID or use a default key
        user_icon_key = f"user_icon_{session_state.customer_id}" if session_state.customer_id else "user_icon_default"
        
        # Display the user icon in the top right corner
        user_icon = st.sidebar.button("👤", key=user_icon_key)

        # Set a flag to indicate that the user icon has been created
        st.session_state.user_icon_created = True

        # Handle the click event on the user icon
        if user_icon:
            display_customer_sidebar(session_state)



# Function to display customer details in the sidebar
def display_customer_sidebar(session_state):
    if session_state.customer_id:
        # Fetch customer details from the database, including address
        query = f"""
        SELECT 
            c.Custm_ID,
            c.Fname,
            c.Lname,
            c.Email,
            c.Phone_number,
            ca.Street_Name_And_area,
            ca.State,
            ca.City,
            ca.Pincode
        FROM 
            customer c
        JOIN 
            customeraddress ca ON c.Custm_ID = ca.CustmID
        WHERE 
            c.Custm_ID = '{session_state.customer_id}'
        """
        customer_data = execute_query(query, fetch=True)

        if customer_data:
            st.sidebar.subheader("Customer Details")
            st.sidebar.write(f"**Customer ID:** {customer_data[0]['Custm_ID']}")
            st.sidebar.write(f"**Name:** {customer_data[0]['Fname']} {customer_data[0]['Lname']}")
            st.sidebar.write(f"**Email:** {customer_data[0]['Email']}")
            st.sidebar.write(f"**Phone Number:** {customer_data[0]['Phone_number']}")
            st.sidebar.write(f"**Address:** {customer_data[0]['Street_Name_And_area']}, {customer_data[0]['City']}, {customer_data[0]['State']}, {customer_data[0]['Pincode']}")
        else:
            st.sidebar.warning("Customer details not found.")
    else:
        st.sidebar.warning("Please log in to view customer details.")


# Function to display the vehicles
def display_vehicles():
    st.subheader("Vehicle Browsing")

    # Fetch vehicle details from the database with named columns
    query = "SELECT Veh_ID, VehName, Model, VehDescription, Manufactured_date, Cost, ImagePath FROM Vehicle"
    vehicles = execute_query(query)

    # Display each vehicle along with its details
    for vehicle in vehicles:
        st.image(vehicle['ImagePath'], caption=vehicle['VehName'], width=280)
        st.write(f"**Description:** {vehicle['VehDescription']}")
        st.write(f"**Price:** ${vehicle['Cost']}")
        # Add a button to configure the vehicle
        if st.button(f"Configure {vehicle['VehName']}"):
            display_configurations(vehicle['Veh_ID'])

# Update the order_vehicle function
def order_vehicle(session_state):
    st.subheader("Online Vehicle Ordering")
    st.write("Select the vehicle you would like to order.")
    
    # Fetch vehicle details for online ordering
    query = "SELECT Veh_ID, VehName, Model, Cost FROM Vehicle"
    vehicles = execute_query(query)

    # Display vehicle options for online ordering
    selected_vehicle_name = st.selectbox("Select a Vehicle", [f"{vehicle['VehName']} - {vehicle['Model']} - ${vehicle['Cost']}" for vehicle in vehicles])

    # Extract Veh_ID from the selected option
    veh_id = next(vehicle['Veh_ID'] for vehicle in vehicles if f"{vehicle['VehName']} - {vehicle['Model']} - ${vehicle['Cost']}" == selected_vehicle_name)

    # Input form for delivery address and payment method
    with st.form("online_order_form"):
        delivery_address = st.text_input("Delivery Address")
        payment_method = st.selectbox("Select Payment Method", ["Credit Card", "Debit Card", "Online Transfer"])
        submit_button = st.form_submit_button("Place Online Order")

    # Button to place the online order
    if submit_button:
        # Get customer_id from the session_state
        customer_id = session_state.customer_id

        # Get the current date
        order_date = date.today()

        # Print the query and values for debugging
        print(f"INSERT INTO ebook (EBookID, DeliveryAddress, PaymentMethod, PaymentStatus, VehID, CustmID, OrderDate) VALUES (UUID(), '{delivery_address}', '{payment_method}', 'Pending', '{veh_id}', '{customer_id}', '{order_date}')")

        # Update the database with the order details in the 'ebook' table
        query = f"INSERT INTO ebook (EBookID, DeliveryAddress, PaymentMethod, PaymentStatus, VehID, CustmID, OrderDate) VALUES (UUID(), '{delivery_address}', '{payment_method}', 'Pending', '{veh_id}', '{customer_id}', '{order_date}')"
        execute_query(query, fetch=False)
        st.success(f"Order placed successfully for {selected_vehicle_name}.")            

# Function to display configurations for a vehicle
def display_configurations(veh_id):
    st.subheader("Vehicle Configurations")

    # Fetch base car price
    query_base_price = f"SELECT Cost FROM Vehicle WHERE Veh_ID = '{veh_id}'"
    base_price_result = execute_query(query_base_price)
    base_price = base_price_result[0]['Cost'] if base_price_result else 0.0

    # Fetch configurations for the given vehicle
    query = f"SELECT * FROM configuration WHERE VehID = '{veh_id}'"
    configurations = execute_query(query)

    # Display each configuration along with its details
    total_cost = 0
    for config in configurations:
        st.write(f"**{config['FeatureName']}** - {config['FeatureDescription']} - ${config['AdditionalCost']}")
        total_cost += config['AdditionalCost']

    st.write("---")
    st.write(f"**Base Car Price:** ${base_price}")
    st.write(f"**Total Cost with Configurations:** ${base_price + total_cost}")

    # Add a button to allow the customer to configure the vehicle
    if st.button("Configure Your Vehicle"):
        configure_vehicle(veh_id, base_price)

# Function to allow the customer to configure a vehicle
def configure_vehicle(veh_id, base_price):
    st.subheader("Configure Your Vehicle")

    # Fetch configurations for the given vehicle
    query = f"SELECT * FROM configuration WHERE VehID = '{veh_id}'"
    configurations = execute_query(query)

    # Display each configuration along with an option to choose
    selected_configs = []
    for config in configurations:
        selected = st.checkbox(f"{config['FeatureName']} - ${config['AdditionalCost']}")
        if selected:
            selected_configs.append(config)

    # Calculate the total cost of selected configurations
    total_cost = sum(config['AdditionalCost'] for config in selected_configs)

    st.write("---")
    st.write(f"**Base Car Price:** ${base_price}")
    st.write(f"**Total Cost with Your Configurations:** ${base_price + total_cost}")

    # Display the selected configurations
    st.write("Selected Configurations:")
    for config in selected_configs:
        st.write(f"- {config['FeatureName']} - ${config['AdditionalCost']}")



# Function to validate email format using regular expression
def validate_email(email):
    pattern = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$'
    return re.match(pattern, email) is not None

# Function to display the registration form
def register_customer():
    st.subheader("Customer Registration")

    # Input form for customer registration
    with st.form("customer_registration_form"):
        fname = st.text_input("First Name")
        lname = st.text_input("Last Name")
        email = st.text_input("Email")
        phone_number = st.text_input("Phone Number")
        password = st.text_input("Password", type="password")
        street_name_and_area = st.text_input("Street Name And Area")
        state = st.text_input("State")
        city = st.text_input("City")
        pincode = st.text_input("Pincode")
        submit_button = st.form_submit_button("Register")

    if submit_button:
        if not validate_email(email):
            st.error("Invalid email format. Please enter a valid email address.")
            return

        # Generate a unique identifier for Custm_ID
        custm_id = str(uuid.uuid4())

        # Hash the password before storing it
        hashed_password = sha256(password.encode('utf-8')).hexdigest()

        # Insert basic data into the customer table
        query = f"INSERT INTO customer (Custm_ID, Fname, Lname, Email, Phone_number, Password, Street_Name_And_area, State, City, Pincode) VALUES ('{custm_id}', '{fname}', '{lname}', '{email}', '{phone_number}', '{hashed_password}', '{street_name_and_area}', '{state}', '{city}', '{pincode}')"
        execute_query(query, fetch=False)
        st.success("Registration successful!")

# Function to handle customer login
def login_customer(session_state):
    session_state = get_session_state()
    st.subheader("Customer Login")

    # Input form for customer login
    with st.form("customer_login_form"):
        email = st.text_input("Email")
        password = st.text_input("Password", type="password")
        submit_button = st.form_submit_button("Login")

    if submit_button:
        # Hash the provided password for comparison with stored hash
        hashed_password = sha256(password.encode('utf-8')).hexdigest()

        # Check if the email and hashed password match a record in the database
        query = f"SELECT * FROM customer WHERE Email = '{email}' AND Password = '{hashed_password}'"
        result = execute_query(query)

        if result:
            session_state.customer_id = result[0]['Custm_ID']
            # Display customer popup and user icon
            display_customer_popup(session_state.customer_id)
            display_user_icon(session_state)
            st.success("Login successful!")
            # You can redirect to the customer's dashboard or perform other actions here
        else:
            st.error("Invalid email or password. Please try again.")

def display_past_orders(customer_id):
    st.subheader("Past Orders")

    # Fetch past orders for the customer
    query_past_orders = f"""
    SELECT 
        e.EBookID,
        v.VehName,
        v.Model,
        e.DeliveryAddress,
        e.PaymentMethod,
        e.OrderDate
    FROM 
        ebook e
    JOIN 
        vehicle v ON e.VehID = v.Veh_ID
    WHERE 
        e.CustmID = '{customer_id}'
    """
    past_orders = execute_query(query_past_orders)

    if past_orders:
        for order in past_orders:
            st.write(f"**Order ID:** {order['EBookID']}")
            st.write(f"**Vehicle:** {order['VehName']} - {order['Model']}")
            st.write(f"**Delivery Address:** {order['DeliveryAddress']}")
            st.write(f"**Payment Method:** {order['PaymentMethod']}")
            st.write(f"**Order Date:** {order['OrderDate']}")
            st.write("---")
    else:
        st.warning("No past orders available for the customer.")


# Function to handle booking a test ride
def book_test_ride():
    st.subheader("Book Test Ride")
    
    # Fetch vehicle details for test ride booking
    query = "SELECT Veh_ID, VehName, Model FROM Vehicle"
    vehicles = execute_query(query)

    # Display vehicle options for test ride booking
    selected_vehicle_name = st.selectbox("Select a Vehicle", [f"{vehicle['VehName']} - {vehicle['Model']}" for vehicle in vehicles])

    # Extract Veh_ID from the selected option
    veh_id = next(vehicle['Veh_ID'] for vehicle in vehicles if f"{vehicle['VehName']} - {vehicle['Model']}" == selected_vehicle_name)

    # Input form for test ride details, including duration
    with st.form("testride_form"):
        preferred_date = st.date_input("Preferred Date")
        preferred_time = st.time_input("Preferred Time")
        duration = st.number_input("Duration of Test Ride (in minutes)", min_value=30, max_value=120, step=5)
        submit_button = st.form_submit_button("Book Test Ride")

    # Button to book the test ride
    if submit_button:
        # Get customer_id from the session_state
        customer_id = get_session_state().customer_id

        # Print the query and values for debugging
        print(f"INSERT INTO testride (TestRide_ID, VehID, CustmID, ScheduledDate, ScheduledTime, Durationoftestride) VALUES (UUID(), '{veh_id}', '{customer_id}', '{preferred_date}', '{preferred_time}', {duration})")

        # Update the database with the test ride details in the 'testride' table
        query = f"INSERT INTO testride (TestRide_ID, VehID, CustmID, ScheduledDate, ScheduledTime, Durationoftestride) VALUES (UUID(), '{veh_id}', '{customer_id}', '{preferred_date}', '{preferred_time}', {duration})"
        execute_query(query, fetch=False)
        st.success(f"Test ride booked successfully for {selected_vehicle_name} on {preferred_date} at {preferred_time} for {duration} minutes.")



# Function to handle showing interest in a vehicle
def show_interest():
    st.subheader("Show Interest")
    
    # Fetch vehicle details for showing interest
    query = "SELECT Veh_ID, VehName, Model FROM Vehicle"
    vehicles = execute_query(query)

    # Display vehicle options for showing interest
    selected_vehicle_name = st.selectbox("Select a Vehicle", [f"{vehicle['VehName']} - {vehicle['Model']}" for vehicle in vehicles])

    # Extract Veh_ID from the selected option
    veh_id = next(vehicle['Veh_ID'] for vehicle in vehicles if f"{vehicle['VehName']} - {vehicle['Model']}" == selected_vehicle_name)

    # Input form for showing interest details
    with st.form("interest_form"):
        
        # Add a rating input component
        interest_rating = st.slider("Rate your interest (1-5)", min_value=1, max_value=5, value=3)
        submit_button = st.form_submit_button("Show Interest")

    # Button to show interest
    if submit_button:
        # Get customer_id from the session_state
        customer_id = get_session_state().customer_id

        # Print the query and values for debugging
        print(f"INSERT INTO showsintereston (CustmID, VehID, InterestRating) VALUES ('{customer_id}', '{veh_id}', {interest_rating})")

        # Update the database with the interest details in the 'showsintereston' table
        query = f"INSERT INTO showsintereston (CustmID, VehID, InterestRating) VALUES ('{customer_id}', '{veh_id}', {interest_rating})"
        execute_query(query, fetch=False)
        st.success(f"Interest shown successfully for {selected_vehicle_name} with a rating of {interest_rating}.")

# Function to display loan offers for the customer
def display_loan_offers(customer_id):
    st.title("Loan Offers")

    # Fetch loan offers for the customer
    query_loan_offers = f"SELECT * FROM loanoffer WHERE CustmID = '{customer_id}'"
    loan_offers = execute_query(query_loan_offers)

    if loan_offers:
        for loan_offer in loan_offers:
            st.write(f"**Loan Offer ID:** {loan_offer['LoanOffer_ID']}")
            st.write(f"**Offer Details and Eligibility:** {loan_offer['OfferDetailsAndEligibility']}")
            st.write(f"**Approval Date:** {loan_offer['ApprovalDate']}")
            st.write(f"**Valid Until:** {loan_offer['ValidUntil']}")
            st.write("---")
    else:
        st.warning("No loan offers available for the customer.")

def display_showroom_locator():
    st.subheader("Showroom Locator")

    # Fetch showroom details from the database
    query = """
    SELECT 
        s.Email,
        s.Address AS ShowroomAddress,
        s.ShowroomName,
        sl.State,
        sl.City,
        s.Phone_Number,
        sl.Pincode
    FROM 
        showroom s
    JOIN 
        showroomlocator sl ON s.Showroom_ID = sl.ShowroomID
    """
    showrooms = execute_query(query)

    # Display each showroom along with its details
    for showroom in showrooms:
        st.write(f"**Showroom Name:** {showroom['ShowroomName']}")
        st.write(f"**Showroom Address:** {showroom['ShowroomAddress']}")
        st.write(f"**Email:** {showroom['Email']}")
        st.write(f"**State:** {showroom['State']}")
        st.write(f"**City:** {showroom['City']}")
        st.write(f"**Phone Number:** {showroom['Phone_Number']}")
        st.write(f"**Pincode:** {showroom['Pincode']}")
        st.write("---")

# Function to get the loan status for a customer and vehicle
def get_loan_status(customer_id, vehicle_id):
    query = f"SELECT GetLoanStatusAlternative('{customer_id}', '{vehicle_id}') AS LoanStatus"
    result = execute_query(query)
    return result[0]['LoanStatus'] if result else "Unknown"

# Function to display the loan status
def display_loan_status():
    st.subheader("Check Loan Status")

    # Fetch customer details for loan status check
    query_customers = "SELECT Custm_ID, Fname, Lname FROM Customer"
    customers = execute_query(query_customers)

    # Display customer options for loan status check
    selected_customer_name = st.selectbox("Select a Customer", [f"{customer['Fname']} {customer['Lname']}" for customer in customers])

    # Extract Custm_ID from the selected option
    customer_id = next(customer['Custm_ID'] for customer in customers if f"{customer['Fname']} {customer['Lname']}" == selected_customer_name)

    # Fetch vehicle details for loan status check
    query_vehicles = "SELECT Veh_ID, VehName, Model FROM Vehicle"
    vehicles = execute_query(query_vehicles)

    # Display vehicle options for loan status check
    selected_vehicle_name = st.selectbox("Select a Vehicle", [f"{vehicle['VehName']} - {vehicle['Model']}" for vehicle in vehicles])

    # Extract Veh_ID from the selected option
    vehicle_id = next(vehicle['Veh_ID'] for vehicle in vehicles if f"{vehicle['VehName']} - {vehicle['Model']}" == selected_vehicle_name)

    # Button to check the loan status
    if st.button("Check Loan Status"):
        loan_status = get_loan_status(customer_id, vehicle_id)
        st.success(f"Loan Status for {selected_customer_name} and {selected_vehicle_name}: {loan_status}")

def apply_for_loan():
    st.subheader("Apply for Loan")

    # Input form for applying for a loan
    with st.form("loan_application_form"):
        custm_id = st.text_input("Customer ID")
        veh_id = st.text_input("Vehicle ID")
        loan_amount = st.number_input("Loan Amount", min_value=0.0)
        application_date = st.date_input("Application Date")
        submit_button = st.form_submit_button("Submit Loan Application")

    # Button to apply for a loan
    if submit_button:
        # Get the current date for the application date
        formatted_application_date = application_date.strftime('%Y-%m-%d')

        # Call the ApplyForLoan stored procedure
        query = f"CALL ApplyForLoan('{custm_id}', '{veh_id}', {loan_amount}, '{formatted_application_date}')"
        execute_query(query, fetch=False)
        
        st.success("Loan application submitted successfully!")

# Function to get the total number of vehicles sold by each showroom
def get_showroom_sales():
    query = """
    SELECT
        sh.Showroom_ID,
        sh.ShowroomName,
        (
            SELECT COUNT(*)
            FROM Sales s
            WHERE s.ShowroomID = sh.Showroom_ID
        ) AS TotalVehiclesSold
    FROM
        Showroom sh
    """
    return execute_query(query)

def display_total_sales_cost():
    st.subheader("Total Sales Cost and Vehicles Sold")

    # Fetch total sales cost
    query_total_sales_cost = """
    SELECT
        sh.Showroom_ID,
        sh.ShowroomName,
        SUM(s.Cost) AS TotalSalesCost
    FROM
        Showroom sh
    JOIN
        Sales s ON sh.Showroom_ID = s.ShowroomID
    GROUP BY
        sh.Showroom_ID, sh.ShowroomName
    ORDER BY
        TotalSalesCost DESC;
    """
    total_sales_cost_result = execute_query(query_total_sales_cost)

    # Fetch total vehicles sold using the nested query
    showroom_sales_result = get_showroom_sales()

    # Display the result
    if total_sales_cost_result and showroom_sales_result:
        for row, sales_row in zip(total_sales_cost_result, showroom_sales_result):
            st.write(f"**Showroom ID:** {row['Showroom_ID']}")
            st.write(f"**Showroom Name:** {row['ShowroomName']}")
            st.write(f"**Total Sales Cost:** ${row['TotalSalesCost']}")
            st.write(f"**Total Vehicles Sold:** {sales_row['TotalVehiclesSold']}")
            st.write("---")
    else:
        st.warning("No data available for total sales cost.")


# Update the main function to include the new functionality
def main():
    # Initialize session state
    session_state = SessionState(customer_id=None)
    session_state = get_session_state()
    display_user_icon(session_state)


    st.title("CarZ")

    selected_functionality = st.sidebar.selectbox(
    "Select Functionality",
    ["Home", "Customer Registration", "Customer Login", "Vehicle Browsing", "Online Vehicle Ordering", "Book Test Ride", "Show Interest", "Showroom Locator","Past Orders","Loan Offers", "Check Loan Status","Apply for Loan","Total Sales Cost"]
    )


    if selected_functionality == "Home":
        display_home()
    elif selected_functionality == "Customer Registration":
        register_customer()
    elif selected_functionality == "Customer Login":
        login_customer(session_state)
    elif selected_functionality == "Vehicle Browsing":
        display_vehicles()
    elif selected_functionality == "Online Vehicle Ordering":
        if session_state.customer_id:
            order_vehicle(session_state)
        else:
            st.warning("Please log in to place an online order.")
    elif selected_functionality == "Book Test Ride":
        if session_state.customer_id:
            book_test_ride()
        else:
            st.warning("Please log in to book a test ride.")
    elif selected_functionality == "Show Interest":
        if session_state.customer_id:
            show_interest()
        else:
            st.warning("Please log in to show interest.")
    elif selected_functionality == "Loan Offers":
        if session_state.customer_id:
            display_loan_offers(session_state.customer_id)
        else:
            st.warning("Please log in to view loan offers.")
    # Add a new option in the sidebar for the Showroom Locator
    elif selected_functionality == "Showroom Locator":
        display_showroom_locator()
    elif selected_functionality == "Past Orders":
        if session_state.customer_id:
            display_past_orders(session_state.customer_id)
        else:
            st.warning("Please log in to view past orders.")

    elif selected_functionality == "Check Loan Status":
        display_loan_status()

    elif selected_functionality == "Apply for Loan":
        apply_for_loan()
    
    elif selected_functionality == "Total Sales Cost":
        display_total_sales_cost()

if __name__ == "__main__":
    main()        