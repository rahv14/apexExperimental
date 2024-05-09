/**
 * @description       :
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             :
 * @last modified on  : 11-14-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 **/
public with sharing class SendEmailTstId {
  @InvocableMethod(label='Send Email Notifications via Id' description='Send Email Notifications based on picklist')
  public static void SendEmailTstId(List<FlowInput> arguements) {
    System.debug('arg ---------->' + arguements);

    List<Account> args = [SELECT Id, Name, Industry FROM Account WHERE Id = :arguements];

    List<OrgWideEmailAddress> owea = [SELECT Id, Address FROM OrgWideEmailAddress WHERE Address = 'msaop777@gmail.com' WITH USER_MODE LIMIT 1];
    List<EmailTemplate> template1 = [SELECT Id, DeveloperName, Body, Subject, HtmlValue FROM EmailTemplate WHERE DeveloperName = 'CommerceReorderPortalInvitation' WITH USER_MODE LIMIT 1];
    List<EmailTemplate> template2 = [SELECT Id, DeveloperName, Body, Subject, HtmlValue FROM EmailTemplate WHERE DeveloperName = 'SalesNewCustomerEmail' WITH USER_MODE LIMIT 1];
    System.debug('SalesNewCustomerEmail --------->' + template2);
    for (Account input : args) {
      if (input.Industry != null && input.Industry == 'Consulting') {
        try {
          List<EmailMessageWrapper> emailWrapperList = new List<EmailMessageWrapper>();
          System.debug('Consulting --------->' + input.Industry);
          System.debug('CommerceReorderPortalInvitation----------->' + template1);
          EmailMessageWrapper emailWrapper = new EmailMessageWrapper();
          //emailWrapper.toAddresses = emailaddress;
          emailWrapper.setOrgWideEmailAddressId = owea.size() > 0 ? owea[0].Id : null;
          emailWrapper.setTargetObjId = UserInfo.getUserId();
          emailWrapper.setSaveAsActivity = false;
          emailWrapper.setTemplateId = template1[0].Id;
          emailWrapperList.add(emailWrapper);
          EmailMessageUtility.sendEmail(emailWrapperList);
        } catch (Exception ex) {
          System.debug(LoggingLevel.WARN, 'Error : ' + ex.getMessage());
          System.debug(LoggingLevel.WARN, 'Exception type caught: ' + ex.getTypeName());
          System.debug(LoggingLevel.WARN, 'Cause: ' + ex.getCause()); // returns null
          System.debug(LoggingLevel.WARN, 'Line number: ' + ex.getLineNumber());
          System.debug(LoggingLevel.WARN, 'Stack trace: ' + ex.getStackTraceString());
        }
      } else if (input.Industry != null && input.Industry == 'Agriculture') {
        try {
          List<EmailMessageWrapper> emailWrapperList = new List<EmailMessageWrapper>();
          System.debug('Agriculture --------->' + input.Industry);
          EmailMessageWrapper emailWrapper = new EmailMessageWrapper();
          //emailWrapper.toAddresses = emailaddress;
          emailWrapper.setOrgWideEmailAddressId = owea.size() > 0 ? owea[0].Id : null;
          emailWrapper.setTargetObjId = UserInfo.getUserId();
          emailWrapper.setSaveAsActivity = false;
          emailWrapper.setTemplateId = template2[0].Id;
          emailWrapperList.add(emailWrapper);
          EmailMessageUtility.sendEmail(emailWrapperList);
        } catch (Exception ex) {
          System.debug(LoggingLevel.WARN, 'Error : ' + ex.getMessage());
          System.debug(LoggingLevel.WARN, 'Exception type caught: ' + ex.getTypeName());
          System.debug(LoggingLevel.WARN, 'Cause: ' + ex.getCause()); // returns null
          System.debug(LoggingLevel.WARN, 'Line number: ' + ex.getLineNumber());
          System.debug(LoggingLevel.WARN, 'Stack trace: ' + ex.getStackTraceString());
        }
      }
    }
  }

  public class FlowInput {
    @InvocableVariable(required=true)
    public List<Id> PicklistVal;
  }
}
