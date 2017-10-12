<%@page import="net.sf.jasperreports.engine.JRExporterParameter"%>
<%@page import="net.sf.jasperreports.engine.export.JRXlsExporterParameter"%>
<%@page import="net.sf.jasperreports.export.SimpleXlsExporterConfiguration"%>
<%@page import="net.sf.jasperreports.export.SimpleOutputStreamExporterOutput"%>
<%@page import="javax.faces.context.FacesContext"%>
<%@page import="net.sf.jasperreports.export.SimpleXlsReportConfiguration"%>
<%@page import="net.sf.jasperreports.export.SimpleExporterInput"%>
<%@page import="net.sf.jasperreports.engine.export.JRXlsExporter"%>
<%@page import="org.apache.poi.hssf.usermodel.HSSFWorkbook"%>
<%@page import="java.util.Map"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="java.util.HashMap"%>
<%@page import="net.sf.jasperreports.view.JasperViewer"%>
<%@page import="net.sf.jasperreports.engine.design.JRDesignQuery"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.io.FileOutputStream"%>
<%@page import="net.sf.jasperreports.engine.JasperPrint"%>
<%@page import="net.sf.jasperreports.engine.JasperFillManager"%>
<%@page import="net.sf.jasperreports.engine.JasperReport"%>
<%@page import="net.sf.jasperreports.engine.JasperCompileManager"%>
<%@page import="net.sf.jasperreports.engine.xml.JRXmlLoader"%>
<%@page import="net.sf.jasperreports.engine.design.JasperDesign"%>
<%@page import="java.io.File"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.FileInputStream"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>

    <%
        Connection conn = ConClass.CClass.getConnection();

        String rep = request.getParameter("grp1");
        String url = "",title="";
        if (rep.equals("mon")) {
            title="MonthRport";
            url = "Reports/month2.jasper";
        } else if (rep.equals("pad")) {
            title="PaidReport";
            url = "Reports/paid.jasper";
        } else if (rep.equals("due")) {
           title="DueReport";
            url = "Reports/due.jasper";
        }

        String time = request.getParameter("time");
        String[] parts = time.split("-");
        String month = parts[0];
        String year = parts[1];

        try {
            File reportFile = new File(application.getRealPath(url));//your report_name.jasper file

            Map parameters = new HashMap();
            int loginid = (Integer) session.getAttribute("loginID");

            parameters.put("month", month);
            parameters.put("year", year);
            parameters.put("loginid", loginid);

            //     byte[] bytes = JasperRunManager.runReportToPdf(reportFile.getPath(), parameters, conn);
            //   response.setContentType("application/pdf");
            //   response.setContentLength(bytes.length);
            //     ServletOutputStream outStream = response.getOutputStream();
            //  outStream.write(bytes, 0, bytes.length);
            // outStream.flush();
            // outStream.close();
            JasperPrint jasperPrint = JasperFillManager.fillReport(reportFile.getPath(), parameters, conn);

            JRXlsExporter exporterXLS = new JRXlsExporter();
            exporterXLS.setParameter(JRXlsExporterParameter.JASPER_PRINT, jasperPrint);
            exporterXLS.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.FALSE);
            exporterXLS.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE);
            exporterXLS.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.FALSE);
            exporterXLS.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);
            exporterXLS.setParameter(JRExporterParameter.OUTPUT_FILE_NAME, request.getRealPath("/Reports") + "/" + "Report" + ".xls");
            exporterXLS.exportReport();
            System.out.println(request.getRealPath("/Reports") + "/" + "Report" + ".xls");
            File f = new File(request.getRealPath("/Reports") + "/" + "Report" + ".xls");
            FileInputStream fin = new FileInputStream(f);
            ServletOutputStream outStream = response.getOutputStream();
// SET THE MIME TYPE.
            response.setContentType("application/vnd.ms-excel");
// set content dispostion to attachment in with file name.
// case the open/save dialog needs to appear.
            response.setHeader("Content-Disposition", "attachment;filename=" + title + ".xls");

            byte[] buffer = new byte[1024];
            int n = 0;
            while ((n = fin.read(buffer)) != -1) {
                outStream.write(buffer, 0, n);
                System.out.println(buffer);
            }

            outStream.flush();
            fin.close();
            outStream.close();

        } catch (Exception ex) {
            out.println(ex);
        }
    %>

    <body>

    </body>
</html>
