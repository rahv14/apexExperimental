/**
 *@description Utility class to send email form apex
 */
public with sharing class EmailMessageUtility {
  /**
   *@description  Method to send email message
   *@param emailWrapper for emailmessaging details
   */
  public static List<Messaging.SingleEmailMessage> sendEmail(List<EmailMessageWrapper> emailWrapper) {
    //List to single email message
    List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
    //Iterating the wrapper class and assigning the values
    for (EmailMessageWrapper emailMessage : emailWrapper) {
      Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
      if (emailMessage.toAddresses != null && emailMessage.toAddresses.size() > 0) {
        mail.setToAddresses(emailMessage.toAddresses);
      }
      if (emailMessage.ccAddresses != null && emailMessage.ccAddresses.size() > 0) {
        mail.setCcAddresses(emailMessage.ccAddresses);
      }
      if (emailMessage.bccAddresses != null && emailMessage.bccAddresses.size() > 0) {
        mail.setBccAddresses(emailMessage.bccAddresses);
      }
      if (!String.isBlank(emailMessage.setReplyTo)) {
        mail.setReplyTo(emailMessage.setReplyTo);
      }
      if (!String.isBlank(emailMessage.setSenderDisplayName)) {
        mail.setSenderDisplayName(emailMessage.setSenderDisplayName);
      }
      if (!String.isBlank(emailMessage.setSubject)) {
        mail.setSubject(emailMessage.setSubject);
      }
      if (emailMessage.setBccSender != null) {
        mail.setBccSender(emailMessage.setBccSender);
      }
      if (emailMessage.setUseSignature != null) {
        mail.setUseSignature(emailMessage.setUseSignature);
      }
      if (!String.isBlank(emailMessage.setPlainTextBody)) {
        mail.setPlainTextBody(emailMessage.setPlainTextBody);
      }
      if (!String.isBlank(emailMessage.setHtmlBody)) {
        mail.setHtmlBody(emailMessage.setHtmlBody);
      }
      if (!String.isBlank(emailMessage.setTargetObjId)) {
        mail.setTargetObjectId(emailMessage.setTargetObjId);
      }
      if (emailMessage.setSaveAsActivity != null) {
        mail.setSaveAsActivity(emailMessage.setSaveAsActivity);
      }
      if (!String.isBlank(emailMessage.setTemplateId)) {
        mail.setTemplateId(emailMessage.setTemplateId);
      }
      if (!String.isBlank(emailMessage.setWhatId)) {
        mail.setWhatId(emailMessage.setWhatId);
      }
      if (!String.isBlank(emailMessage.setOrgWideEmailAddressId)) {
        mail.setOrgWideEmailAddressId(emailMessage.setOrgWideEmailAddressId);
      }
      /*  if (emailMessage.setTemplateID != null && emailMessage.setTemplateID.size() > 0) {
        mail.setTemplateId(emailMessage.setTemplateID);
      }

      if (emailMessage.setOrgWideEmailAddressId != null && emailMessage.setOrgWideEmailAddressId.size() > 0) {
        mail.setOrgWideEmailAddressId(emailMessage.setOrgWideEmailAddressId);
      } */
      if (emailMessage.setFileAttachments != null && emailMessage.setFileAttachments.size() > 0) {
        mail.setFileAttachments(emailMessage.setFileAttachments);
      }
      mails.add(mail);
      system.debug(LoggingLevel.DEBUG, mails);
    }
    //Checking the list size and sending the email.
    if (mails.size() > 0) {
      Messaging.SendEmailResult[] results = Messaging.sendEmail(mails);
      if (results[0].success) {
        System.debug(LoggingLevel.DEBUG, 'The email was sent successfully-->');
      } else {
        System.debug(LoggingLevel.DEBUG, 'The email failed to send: -->' + results[0].errors[0].message);
      }
    }
    return mails;
  }
}
