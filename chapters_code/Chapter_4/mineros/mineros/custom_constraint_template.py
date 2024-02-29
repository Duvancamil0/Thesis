import pandas as pd

from sdv.constraints import create_custom_constraint_class


def is_valid(column_names, data, extra_parameter):
    """
    Checks for the validity of the data for the given column names.
    
    Args:
        column_names(list[str]):
            A list of the column names involved in the constraint
        data(pandas.DataFrame):
            A dataset

    Returns:
        pandas Series:
            A Series of True/False values describing whether the each row
            of the data is valid. There is exactly 1 True/False value for
            every row in the data.
    """

    
    # Calculate the total number of risks for each row
    total_risks = data[column_names].sum(axis=1)
    
    # Create a boolean Series based on the business logic
    # if total risks is 0, 'Category_Overrun' should be the lowest
    no_risks = (total_risks == 0) & (data['Time_Overrun_category'] == "[0,0.12]")
    # if total risks is between 1 and 3, 'Category_Overrun' should not be 'Minimal'
    some_risks = (total_risks.between(1, 3))
    
    return (no_risks) | (some_risks)

# Create your constraint class
RiskOverrunConstraint = create_custom_constraint_class(
    is_valid_fn=is_valid
)