# NYC Reservoir Data
 
This is a command line application that I built in Ruby to visualize to water levels of New York City's five main water [resevoirs](http://www.nyc.gov/html/dep/html/drinking_water/maplevels_wide.shtml). 
 
These reservoir's water levels are recorded by the United States Geological Survey and this data is hosted on their [National Water Information Website](https://waterdata.usgs.gov/nwis)
 
When a user runs the application, the first thing it does is make a call to the USGS API to get the water level data for 5 reservoirs. It then parses received JSON object and builds an array of reservoir objects filled with data point objects (that contain daily water level measurements.)
 
Next, an on-screen menu is shown to allow the user to select which reservoir they would like to visualize the water levels for. Once a user makes a selection, a loop is run through all the data for that reservoir, and the water level over time is visualized using the AsciiCharts Ruby gem. The data is colorized using the Colorize Ruby gem.
 
Eventually, I would like to turn this project into a web application and visualize the data using D3. You either clone this repo and run the program locally if you have Ruby installed, or you can see an example here:
 
 
![Visualization](https://s3.amazonaws.com/andre-pictures/nyc_visualization.gif)
