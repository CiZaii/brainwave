package org.zang.analysis;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.pdfbox.Loader;
import org.apache.pdfbox.pdmodel.PDDocument;
import org.apache.pdfbox.text.PDFTextStripper;
import org.apache.tika.exception.TikaException;
import org.apache.tika.metadata.Metadata;
import org.apache.tika.parser.AutoDetectParser;
import org.apache.tika.parser.ParseContext;
import org.apache.tika.parser.Parser;
import org.apache.tika.sax.BodyContentHandler;
import org.springframework.stereotype.Service;
import org.xml.sax.ContentHandler;
import org.xml.sax.SAXException;

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

    public List<String> readDocument(File file) throws IOException, TikaException, SAXException {
        List<String> pagesText = new ArrayList<>();
        String mimeType = Files.probeContentType(file.toPath());

        try {
            if ("application/pdf".equals(mimeType)) {
                pagesText = readPdfOfPage(file);
            } else if ("application/msword".equals(mimeType)) {
                pagesText = readWordByPage(file);
            } else if ("application/vnd.openxmlformats-officedocument.wordprocessingml.document".equals(mimeType)) {
                pagesText = readWordByPage(file);
            }
        } finally {
            deleteFile(file);
        }

        return pagesText;
    }

    public List<String> readPdfOfPage(File file) throws IOException {



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
        }  finally {
            deleteFile(file);
        }
        return pagesText;
    }

    public List<String> readWordByPage(File file) throws IOException, TikaException, SAXException {
        List<String> pagesText = new ArrayList<>();

        try (FileInputStream fis = new FileInputStream(file)) {
            Metadata metadata = new Metadata();
            ParseContext parseContext = new ParseContext();

            Parser parser = new AutoDetectParser();
            ContentHandler handler = new BodyContentHandler();

            parser.parse(fis, handler, metadata, parseContext);

            String content = handler.toString();
            String[] pages = content.split("\\n\\s*\\n\\s*\\n");

            for (String page : pages) {
                if (!page.trim().isEmpty()) {
                    pagesText.add(page.trim());
                }
            }
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
