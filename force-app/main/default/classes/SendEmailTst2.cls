/**
 * @description       :
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             :
 * @last modified on  : 11-09-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 **/
public with sharing class SendEmailTst2 {
  public class MailInputParameters {
    /**
     * @description toAddresses
     */
    @InvocableVariable(required=false)
    public List<String> toAddresses;
    /**
     *@description ccAddresses
     */
    @InvocableVariable(required=false)
    public List<String> ccAddresses;
    /**
     *@description bccAddresses
     */
    @InvocableVariable(required=false)
    public List<String> bccAddresses;
    /**
     *@description setReplyTo
     */
    @InvocableVariable(required=false)
    public String setReplyTo;
    /**
     *@description setSenderDisplayName
     */
    @InvocableVariable(required=false)
    public String setSenderDisplayName;
    /**
     *@description setSubject
     */
    @InvocableVariable(required=false)
    public String setSubject;
    /**
     *@description setBccSender
     */
    @InvocableVariable(required=false)
    public Boolean setBccSender;
    /**
     *@description setUseSignature
     */
    @InvocableVariable(required=false)
    public Boolean setUseSignature;
    /**
     *@description setPlainTextBody
     */
    @InvocableVariable(required=false)
    public String setPlainTextBody;
    /**
     *@description setHtmlBody
     */
    @InvocableVariable(required=false)
    public String setHtmlBody;
    /**
     *@description setTargetObjectId
     */
    @InvocableVariable(required=false)
    public String setTargetObjId;
    /**
     *@description setSaveAsActivity
     */
    @InvocableVariable(required=false)
    public Boolean setSaveAsActivity;
    /**
     *@description setTemplateID
     */
    @InvocableVariable(required=false)
    public String setTemplateId;
    /**
     *@description setWhatId
     */
    @InvocableVariable(required=false)
    public String setWhatId;
    /**
     *@description setOrgWideEmailAddressId
     */
    @InvocableVariable(required=false)
    public String setOrgWideEmailAddressId;
    /**
     *@description setFileAttachments
     */
    @InvocableVariable(required=false)
    public List<Messaging.EmailFileAttachment> setFileAttachments;
  }

  @InvocableMethod(label='label' description='description')
  public static List<MailInputParameters> sendemailtest2(List<MailInputParameters> lstparameters) {
    List<String> strtoAddress;
    List<String> strccAddress;
    String strbccAdress;
    String strTargetObjectId;
    String strSetSaveasActivity;
    String TemplateId;
    String OrgWideAdress;

    for (MailInputParameters objInput : lstParameters) {
      strtoAddress = objInput.toAddresses;
      strccAddress = ObjInput.ccAddresses;
    }
  }
}
