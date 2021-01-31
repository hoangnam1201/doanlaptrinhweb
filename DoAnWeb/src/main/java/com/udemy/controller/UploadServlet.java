package com.udemy.controller;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

@WebServlet(name = "UploadServlet", urlPatterns = "/upload")
public class UploadServlet extends HttpServlet {
    private boolean isMultipart;
    private String filePath = "E:\\videos";
    private int maxFileSize = 100 * 1024 * 1024;
    private int maxMemSize = 1000 * 1024 * 1024;
    private File file;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        FileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);
        List<FileItem> items = null;
        try {
            items = upload.parseRequest(request);
        } catch (FileUploadException e) {
            e.printStackTrace();
        }
        Iterator<FileItem> iter = items.iterator();
        Hashtable<String, String> params = new Hashtable<String, String>();
        String fileName = "";
        while (iter.hasNext()) {
            FileItem item = iter.next();
            if (item.isFormField()) {
                params.put(item.getFieldName(), item.getString("UTF-8"));
            } else {
                try {
                    if (!item.getName().isEmpty()) {
                        String[] split = item.getName().split("\\.");
                        fileName = System.currentTimeMillis() + "." + split[split.length - 1];
                    }
                    String realPath = "E:/videos/" + fileName;
                    File savedFile = new File(realPath);
                    item.write(savedFile);
                    out.println(fileName);
                    out.flush();
                } catch (Exception e) {
                    response.setStatus(500);
                    e.printStackTrace();
                }
            }
        }
    }


    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
