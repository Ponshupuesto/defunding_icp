import Result "mo:base/Result";
import Time "mo:base/Time";
import HashMap "mo:base/HashMap";
import Blob "mo:base/Blob";
import List "mo:base/List";
import Principal "mo:base/Principal";
import Nat "mo:base/Nat";
import Int "mo:base/Int";
import Text "mo:base/Text";
import Account "Account";



module{

    public type Result<Ok, Err> = Result.Result<Ok, Err>;
    public type HashMap<Ok, Err> = HashMap.HashMap<Ok, Err>;


    public type Attachment = {
        document_type : Text;
        document : Blob;
    };

    //User definition

    public type PersonalInformation = {
        name : Text;
        lastName :  Text;
        userName :  Text;
        email : Text;
        phone : Text;
        profileImage : ?Blob;
        country : Text;
        city : Text;
    };

    public type AccountInformation = {
        principal : Principal;
        account : Blob;
        createdAt : Int;
    };

    public type User = {
        personalInformation : PersonalInformation;
        accountInformation : AccountInformation;
    };

    //Beneficiary definition
    //Contiene BeneficiaryInformation, AccountInformation, LogHistory, Milestones

    public type BeneficiaryInformation = {
        beneficiarysName : Text;
        beneficiarysMision : Text;
        beneficiarysVision : Text;
        beneficiarysValues : Text;
        beneficiaryRepresentative : Text;
        beneficiaryCountry : Text;
        beneficiaryCity : Text;
        beneficiaryAddress : Text;
        beneficiarySocialNetworks : List.List<Text>;
    };

    public type BeneficiaryAccount = {
        //validar backend Cuenta sea Válida
        account :  Blob;
        withdrawalAccount : Principal;
    };

    /*public type RequirementSpecs = {
        description :  Text;
        islimited : Bool;
        minimumAmount : Nat;
        limitedUsers : Nat;
        attachments : List.List<Attachment>;
    };*/


    /*public type Requirement = {
        request : Text;
        attachments : List.List<Attachment>;
    };*/


    public type Project = {
        projectName : Text;
        projectDescription : Text;
        requiredAmount : Nat;
        milestones : List.List<FundingMilestone>;
        status : Status;
        stats : Stats;
        //allowRequirements : Bool;
        //requirements : List.List<RequirementSpecs>;
    };

    public type FundingBeneficiary = {
        beneficiaryInformation : BeneficiaryInformation;
        beneficiaryAccount : BeneficiaryAccount;
        projects : List.List<Project>;
        //fundingBadges : List.List<FundingBadge>;
    };

    public type FundingMilestone = {
        id : Nat;
        description : Text;
        ammount : Nat;
        milestoneStatus : Status;
        milestoneEvidence : List.List<MilestoneEvidence>;
    };

    public type Status = {
        #OnProgress;
        #Pending;
        #Achieved;
        #Unachieved;
        #Canceled;
        #Replaced;
    };

    public type MilestoneEvidence = {
        description : Text;
        links : List.List<Text>;
        votes : List.List<Vote>;
        comments : List.List<Text>;
        attachments : List.List<Attachment>;        
    };

    public type Vote = {
        userName : Text;
        userPrincipal : Principal;
        votedFor : Bool; 
    };

    public type Stats = {
        supporters : Nat;
        contributedAmmount : Nat;
        milestonesAchieved : ?List.List<FundingMilestone>;
    };

    public type FundingBadge = {
        description : Text;
        image : ?Blob;
    };

};
