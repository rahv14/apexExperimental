/**
 * @description       :
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             :
 * @last modified on  : 11-27-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 **/
@isTest
public with sharing class EmailMessageUtilityTest {
  @isTest
  public static void sendEmail() {
    List<EmailMessageWrapper> emailWrapper = new List<EmailMessageWrapper>();
    //List<EmailMessageWrapper> emailWrapper2 = new List<EmailMessageWrapper>();
    List<OrgWideEmailAddress> owea = [SELECT Id, Address FROM OrgWideEmailAddress WHERE Address = 'msaop777@gmail.com' WITH USER_MODE LIMIT 1];
    List<Account> acc = [SELECT Id FROM Account WITH USER_MODE LIMIT 1];
    List<EmailTemplate> template1 = [SELECT Id, DeveloperName, Body, Subject, HtmlValue FROM EmailTemplate WHERE DeveloperName = 'CommerceReorderPortalInvitation' WITH USER_MODE LIMIT 1];
    List<String> toAddress = new List<String>{ 'rahulreddy7322@gmail.com' };
    List<String> ccAddress = new List<String>{ 'rahulreddy7322@gmail.com' };
    List<String> bccAddress = new List<String>{ 'rahulreddy7322@gmail.com' };
    EmailMessageWrapper mail = new EmailMessageWrapper();
    mail.toAddresses = toAddress;
    mail.ccAddresses = ccAddress;
    mail.bccAddresses = bccAddress;
    mail.setReplyTo = 'rahulreddy7322@gmail.com';
    //mail.setSenderDisplayName = 'Test';
    mail.setSubject = 'TestSubject';
    mail.setBccSender = null;
    mail.setUseSignature = true;
    mail.setPlainTextBody = 'TestBody';
    mail.setHtmlBody = 'HTMLBody';
    mail.setTargetObjId = UserInfo.getUserId();
    mail.setSaveAsActivity = false;
    mail.setTemplateID = template1[0].Id;
    mail.setWhatId = acc.size() > 0 ? acc[0].Id : null;
    mail.setOrgWideEmailAddressId = owea.size() > 0 ? owea[0].Id : null;
    emailWrapper.add(mail);
    EmailMessageUtility.sendEmail(emailWrapper);
    //EmailMessageUtility_sls.sendEmail(emailWrapper2);
  }
}
