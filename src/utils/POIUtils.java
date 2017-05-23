package utils;



import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;

import java.io.*;
import java.util.List;

/**
 * Java操作Excel
 * 参考:<br/>
 *      <a href='http://blog.csdn.net/lansetiankong12/article/details/52276632'>Java读写Excel</a> <br/>
 *      <a href='http://www.cnblogs.com/chenyq/p/5530970.html'>java写入excel文件poi</a> <br/>
 *      <a href='http://blog.csdn.net/not_lost_yesterday/article/details/50722752'>关于apache POI 对Excel的下载 遇到的几个问题总结</a>
 * Created by weijia on 2017-05-22.
 */
public class POIUtils {


    /**
     * 将数据写入到Excel中并输出到OutputStream中
     * @param sheetName 表格工作簿名称
     * @param outputStream 输出流
     * @param titleArray 表头数组,最终为文本
     * @param contentList 表格内容List,一行为一个Object[]数组
     * @throws IOException
     */
    @SuppressWarnings("deprecation")    //不提示不被推荐使用的方法
    public static void writeToExcel(String sheetName, OutputStream outputStream, Object[] titleArray, List<Object[]> contentList) throws IOException {
        HSSFWorkbook workbook = new HSSFWorkbook();
        //获取List size作为excel行数
        int rowCount = contentList.size();
        HSSFSheet sheet = workbook.createSheet(sheetName);
        //创建第一行
        HSSFRow headRow = sheet.createRow(0);
        for(int i=0;i<=titleArray.length-1;i++)
        {
            HSSFCell cell = headRow.createCell(i);
            cell.setCellType(HSSFCell.CELL_TYPE_STRING);
            sheet.setColumnWidth(i, 6000);
            HSSFCellStyle style = workbook.createCellStyle();
            HSSFFont font = workbook.createFont();
            font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
            font.setColor(HSSFColor.HSSFColorPredefined.BLACK.getIndex());
            style.setFont(font);
            //填写数据
            cell.setCellStyle(style);
            cell.setCellValue(""+titleArray[i]);

        }

        //写入数据
        for(int i = 0 ; i < contentList.size();i++){
            Object[] data = contentList.get(i);
            HSSFRow row = sheet.createRow(i+1);
            for(int j = 0 ; j < data.length;j++){
                row.createCell(j);
                row.getCell(j).setCellValue(""+data[j]);
            }
        }
        workbook.write(outputStream);
        outputStream.flush();
        outputStream.close();
    }
}
