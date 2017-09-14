package org.webproject.servlet;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.webproject.servlet.DBUtility;

/**
 * Servlet implementation class HttpServlet
 */
@WebServlet("/HttpServlet")
public class HttpServlet extends javax.servlet.http.HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see javax.servlet.http.HttpServlet#javax.servlet.http.HttpServlet()
     */
    public HttpServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		
		System.out.println("ran");
		
		String action = request.getParameter("action");
		
		if (action.equals("send")) {
			System.out.println("A report is submitted");
			try {
				 createReport(request, response);
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		else if (action.equals("recieve")) {
			try{
				queryReport(request, response);
			
				
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		/*JSONObject data = new JSONObject();
	
			java.util.Date d = new Date();
			data.put("Time request recieved",d.toString());
		
		response.getWriter().write(data.toString());*/
	}
	
	private void createReport(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException {
		DBUtility dbutil = new DBUtility();
		String sql;
		
		//creates crime report
		int user_id = 0;
		String crimeDate = request.getParameter("Date");
		String crimeDescription = request.getParameter("Description");
		String crimeType = request.getParameter("Type");
		String lat = request.getParameter("lat");
		String lon = request.getParameter("lon");
		crimeDate = "'" + crimeDate + "'";
		crimeDescription = "'" + crimeDescription + "'";
		crimeType = "'" + crimeType + "'";
		String coordinates = "ST_GeomFromText('POINT(" + lon + " " + lat + ")',4326)";

		
		
		sql = "insert into crime (date, primary_type, descriptio, "
				+ "geom) "
				+ "values (" + crimeDate + "," + crimeType + "," 
				+ crimeDescription + "," + coordinates + ")";
		
		
		System.out.println(sql);
		dbutil.modifyDB(sql);
		
		System.out.println("Success! Damage report created.");
		
		// response that the report submission is successful
		JSONObject indicator = new JSONObject();
	
			System.out.println("it is working?");
			indicator.put("status","success");
	
			
			System.out.println("it is not working?");
		
	
		
		
		System.out.println("data to return client >> " + indicator.toString());
		response.getWriter().write(indicator.toString());
	}
	
	private void queryReport(HttpServletRequest request, HttpServletResponse
			response) throws  SQLException, IOException {
		JSONArray list = new JSONArray();
		
			// String sql = "select report.id, report_type, resource_type, " +
			// 		"disaster_type, first_name, last_name, time_stamp, ST_X(geom) as " +
			// 		"longitude, ST_Y(geom) as latitude, message from report, person, " +
			// 		"request_report where reportor_id = person.id and report.id = " +
			// 		"report_id";

			String sql =  "select id,  primary_type, descriptio,date, st_asgeojson(geom) as feature"
					+ " from crime"
					+ " where geom is not null "
					+ " limit 1 " 
					;
			queryReportHelper(sql,list);

		
		
		
	//	String results = list.toJSONString();
	
		

		JSONObject featureObjects = new JSONObject();
		
		featureObjects.put("type", "FeatureCollection");
		
		featureObjects.put("features", list);
	
		
		System.out.println("return results to the client" +  featureObjects.toJSONString());
		response.getWriter().write(featureObjects.toJSONString());
	}
	
	private void queryReportHelper(String sql, JSONArray list) throws SQLException {
		DBUtility dbutil = new DBUtility();
		// if (disaster_type != null) {
		// 	sql += " and disaster_type= '" + disaster_type + "'";
		// }
		// if (resource_or_damage != null) {
		// 	if (report_type.equalsIgnoreCase("damage")){
		// 		sql += " and damage_type= '" + resource_or_damage + "'";
		// 	} else {
		// 		sql += " and resource_type= '" + resource_or_damage + "'";
		// 	}
		// }
		
		System.out.println(sql);
		ResultSet res = dbutil.queryDB(sql);
		while (res.next()) {
			
			HashMap<String, Object> m = new HashMap<String, Object>();
			
			
			
			m.put("type", "Feature");
			
			
			JSONParser parser = new JSONParser();
			JSONObject json;
			try {
				json = (JSONObject) parser.parse(res.getString("feature"));
				m.put("geometry", json );

			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		
			/*HashMap<String, String> properties = new HashMap<String, String>();
			
			properties.put("ID", res.getString("id"));
			properties.put("Date",  res.getString("date"));
			properties.put("Primary Ty", res.getString("primary_type"));
			properties.put("Descriptio", res.getString("descriptio"));
			*/
			
			JSONObject  properties = new JSONObject();
			
			properties.put("ID", res.getString("id"));
			properties.put("Date",  res.getString("date"));
			properties.put("Primary Ty", res.getString("primary_type"));
			properties.put("Descriptio", res.getString("descriptio"));
			
		
			m.put("properties", properties);
			
			
			list.add(m);
		}
	}

}
