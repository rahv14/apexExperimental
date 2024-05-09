/**
 * @description       :
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             :
 * @last modified on  : 11-28-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 **/
public with sharing class SendEmailTst {
  @InvocableMethod(label='Send Email Notifications' description='Send Email Notifications based on picklist')
  public static void sendemailtest(List<FlowInput> arguements) {
    System.debug('arg ---------->' + arguements);
    List<OrgWideEmailAddress> owea = [SELECT Id, Address FROM OrgWideEmailAddress WHERE Address = 'msaop777@gmail.com' WITH USER_MODE LIMIT 1];
    List<EmailTemplate> template1 = [SELECT Id, DeveloperName, Body, Subject, HtmlValue FROM EmailTemplate WHERE DeveloperName = 'CommerceReorderPortalInvitation' WITH USER_MODE LIMIT 1];
    List<EmailTemplate> template2 = [SELECT Id, DeveloperName, Body, Subject, HtmlValue FROM EmailTemplate WHERE DeveloperName = 'SalesNewCustomerEmail' WITH USER_MODE LIMIT 1];
    System.debug('SalesNewCustomerEmail --------->' + template2);
    for (FlowInput input : arguements) {
      if (input.PicklistVal != null && input.PicklistVal == 'Consulting') {
        try {
          List<EmailMessageWrapper> emailWrapperList = new List<EmailMessageWrapper>();
          System.debug('Consulting --------->' + input.PicklistVal);
          System.debug('CommerceReorderPortalInvitation----------->' + template1);
          EmailMessageWrapper emailWrapper = new EmailMessageWrapper();
          //emailWrapper.toAddresses = emailaddress;
          emailWrapper.setOrgWideEmailAddressId = owea[0]?.Id;
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
      } else if (input.PicklistVal != null && input.PicklistVal == 'Agriculture') {
        try {
          List<EmailMessageWrapper> emailWrapperList = new List<EmailMessageWrapper>();
          System.debug('Agriculture --------->' + input.PicklistVal);
          EmailMessageWrapper emailWrapper = new EmailMessageWrapper();
          //emailWrapper.toAddresses = emailaddress;
          emailWrapper.setOrgWideEmailAddressId = owea[0]?.Id;
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
    public String PicklistVal;
  }
}
