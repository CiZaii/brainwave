package org.zang.analysis;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.pdfbox.Loader;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.springframework.stereotype.Service;

/**
 * 读取pdf文档
 * @author Eliauk，微信：Cizai_，邮箱：zang.dromara.org <br/>
 * @date 2024/6/26 <br/>
 * &#064;Copyright  博客：<a href="https://eliauku.gitee.io/">...</a>  ||  per aspera and astra <br/>
 */
@Service
public class PDF2String {

    private static final Log log = LogFactory.getLog(PDF2String.class);

    /**
     * 读取文件
     * @param file 文件
     * @return pdf内容
     */
    public String readPdf(File file) {

        String text = "";

            List<String> pagesText = new ArrayList<>();

            try (PDDocument document = Loader.loadPDF(file)) {
                if (!document.isEncrypted()) {
                    PDFTextStripper pdfStripper = new PDFTextStripper();

                    int numberOfPages = document.getNumberOfPages();
                    for (int i = 1; i <= numberOfPages; i++) {
                        pdfStripper.setStartPage(i);
                        pdfStripper.setEndPage(i);
                        String pageText = pdfStripper.getText(document);
                        pagesText.add(pageText);
                    }
                }
            } catch (IOException e) {
                log.error("读取文件失败", e);
            } finally {
                deleteFile(file);
            }
        System.out.println(pagesText);
        return text;

    }

    public List<String> readPdfOfPage(File file) {
        List<String> pagesText = new ArrayList<>();

        try (PDDocument document = Loader.loadPDF(file)) {
            if (!document.isEncrypted()) {
                PDFTextStripper pdfStripper = new PDFTextStripper();

                int numberOfPages = document.getNumberOfPages();
                for (int i = 1; i <= numberOfPages; i++) {
                    pdfStripper.setStartPage(i);
                    pdfStripper.setEndPage(i);
                    String pageText = pdfStripper.getText(document);
                    pagesText.add(pageText);
                }
            }
        } catch (IOException e) {
            log.error("读取文件失败", e);
        } finally {
            deleteFile(file);
        }
        return pagesText;
    }

    /**
     * 删除文件
     * @param file 文件
     */
    private void deleteFile(File file) {
        if (file.delete()) {
            log.info("本地文件已成功删除");
        } else {
            log.error("本地文件删除失败");
        }
    }



}
