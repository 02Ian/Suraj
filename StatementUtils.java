package com.capgemini.stargate.util;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;

import com.capgemini.stargate.controller.model.Statement;
import com.capgemini.stargate.controller.model.Transaction;
import com.capgemini.stargate.exception.StarGateException;
import com.itextpdf.text.Anchor;
import com.itextpdf.text.Chapter;
import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Element;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.Section;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;

public class StatementUtils {
	
	public static ByteArrayInputStream statementReport(Statement statement) throws StarGateException{

		Document document = new Document();
		ByteArrayOutputStream out = new ByteArrayOutputStream();

		try {

			if(statement!=null){
				if(statement.getTransactions()!=null && !statement.getTransactions().isEmpty()){
					
					PdfPTable table = new PdfPTable(6);
					table.setWidthPercentage(60);
					com.itextpdf.text.Font headFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD);

					PdfPCell hcell;
					hcell = new PdfPCell(new Phrase("AccountId", headFont));
					hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
					table.addCell(hcell);

					hcell = new PdfPCell(new Phrase("TransactionId", headFont));
					hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
					table.addCell(hcell);

					hcell = new PdfPCell(new Phrase("TransactionTime", headFont));
					hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
					table.addCell(hcell);

					hcell = new PdfPCell(new Phrase("Description", headFont));
					hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
					table.addCell(hcell);
					
					hcell = new PdfPCell(new Phrase("Status", headFont));
					hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
					table.addCell(hcell);
					
					hcell = new PdfPCell(new Phrase("Amount", headFont));
					hcell.setHorizontalAlignment(Element.ALIGN_CENTER);
					table.addCell(hcell);

					for(Transaction transaction :statement.getTransactions()){
						PdfPCell cell;

						cell = new PdfPCell(new Phrase(transaction.getAccountId().toString()));
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_CENTER);
						table.addCell(cell);

						cell = new PdfPCell(new Phrase(transaction.getTransactionId().toString()));
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_CENTER);
						table.addCell(cell);

						cell = new PdfPCell(new Phrase(transaction.getTransactionTimestamp().toString()));
						cell.setPaddingLeft(1);
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						table.addCell(cell);

						cell = new PdfPCell(new Phrase(transaction.getDescription().toString()));
						cell.setPaddingLeft(1);
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						table.addCell(cell);
						
						cell = new PdfPCell(new Phrase(transaction.getStatus().toString()));
						cell.setPaddingLeft(1);
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						table.addCell(cell);
						
						cell = new PdfPCell(new Phrase(transaction.getAmount().toString()));
						cell.setPaddingLeft(1);
						cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
						cell.setHorizontalAlignment(Element.ALIGN_LEFT);
						table.addCell(cell);
						
					}

					PdfWriter.getInstance(document, out);
					document.open();
					 addContent(document,statement);
					document.add(table);
					document.close();
					
				}
				
				
				
			}
			

		} catch (DocumentException ex) {
			throw new StarGateException(ex.getMessage());
		}

		return new ByteArrayInputStream(out.toByteArray());
	}
	
	private static void addContent(Document document,Statement statement) throws DocumentException {
        
        // first parameter is the number of the chapter
        Chapter catPart = new Chapter(0);
        Paragraph subPara = new Paragraph("Customer Information");
        Section subCatPart = catPart.addSection(subPara);
        subCatPart.add(new Paragraph("Name: Rajesh"));
        subCatPart.add(new Paragraph("StatementDate: "+statement.getStatementDate()));
        subCatPart.add(new Paragraph("StatementId: "+statement.getStatementId()));
        subCatPart.add(new Paragraph("Email: rajesh.shah@capgemini.com"));
        subCatPart.add(new Paragraph(""));
     
       
        // now add all this to the document
        document.add(subCatPart);

    }

}
