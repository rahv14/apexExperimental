/**
 * @description       :
 * @author            : Rahul V
 * @group             :
 * @last modified on  : 11-09-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
 **/
public with sharing class EmailMessageWrapper {
  /**
   *@description toAddresses
   */
  public List<String> toAddresses { get; set; }
  /**
   *@description ccAddresses
   */
  public List<String> ccAddresses { get; set; }
  /**
   *@description bccAddresses
   */
  public List<String> bccAddresses { get; set; }
  /**
   *@description setReplyTo
   */
  public String setReplyTo { get; set; }
  /**
   *@description setSenderDisplayName
   */
  public String setSenderDisplayName { get; set; }
  /**
   *@description setSubject
   */
  public String setSubject { get; set; }
  /**
   *@description setBccSender
   */
  public Boolean setBccSender { get; set; }
  /**
   *@description setUseSignature
   */
  public Boolean setUseSignature { get; set; }
  /**
   *@description setPlainTextBody
   */
  public String setPlainTextBody { get; set; }
  /**
   *@description setHtmlBody
   */
  public String setHtmlBody { get; set; }
  /**
   *@description setTargetObjectId
   */
  public String setTargetObjId { get; set; }
  /**
   *@description setSaveAsActivity
   */
  public Boolean setSaveAsActivity { get; set; }
  /**
   *@description setTemplateID
   */
  public String setTemplateId { get; set; }
  /**
   *@description setWhatId
   */
  public String setWhatId { get; set; }
  /**
   *@description setOrgWideEmailAddressId
   */
  public String setOrgWideEmailAddressId { get; set; }
  /**
   *@description setFileAttachments
   */
  public List<Messaging.EmailFileAttachment> setFileAttachments { get; set; }
}
