package com.udemy.model;

import java.util.ArrayList;
import java.util.List;

public class CourseListPageInfo {
    public static final int pageLimit = 5;
    private int totalPage = 0;
    private int currentPage = 1;
    private long resultCount = 0;
    private Category category;
    private String searchString = "";
    private String sortField = "studentCount";
    private String sortDirection = "desc";
    private List<String> pagination = new ArrayList<String>();

    public void setPagination() {
        totalPage = (int) ((resultCount + pageLimit - 1) / pageLimit);
        try {
            boolean outOfRange = false;
            for (int i = 1; i <= totalPage; i++) {
                if (i <= 2 || i >= totalPage - 2 || Math.abs(i - currentPage) <= 2) {
                    outOfRange = false;
                    if (i == currentPage) {
                        pagination.add("0");
                    } else {
                        pagination.add(String.valueOf(i));
                    }
                } else {
                    if (!outOfRange) {
                        pagination.add(".");
                    }
                    outOfRange = true;
                }
            }
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    public int getTotalPage() {
        return totalPage;
    }

    public List<String> getPagination() {
        return pagination;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public String getSearchString() {
        return searchString;
    }

    public void setSearchString(String searchString) {
        this.searchString = searchString;
    }

    public String getSortField() {
        return sortField;
    }

    public void setSortField(String sortField) {
        this.sortField = sortField;
    }

    public String getSortDirection() {
        return sortDirection;
    }

    public void setSortDirection(String sortDirection) {
        this.sortDirection = sortDirection;
    }

    public int getCurrentPage() {
        return currentPage;
    }

    public void setCurrentPage(int currentPage) {
        this.currentPage = currentPage;
    }

    public long getResultCount() {
        return resultCount;
    }

    public void setResultCount(long resultCount) {
        this.resultCount = resultCount;
    }
}
