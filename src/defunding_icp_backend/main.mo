import Text "mo:base/Text";
import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import List "mo:base/List";
import Time "mo:base/Time";
import Result "mo:base/Result";
import Blob "mo:base/Blob";
import Types "types";
import Account "Account";
import Iter "mo:base/Iter";
import Nat8 "mo:base/Nat8";



actor Defunding{

  type Result<Ok,Err> = Types.Result<Ok,Err>;
  type HashMap<K,V> = Types.HashMap<K,V>;
  type User = Types.User;
  type FundingBeneficiary = Types.FundingBeneficiary;
  type FundingMilestone = Types.FundingMilestone;
  type Status = Types.Status;
  type MilestoneEvidence = Types.MilestoneEvidence;
  type Vote = Types.Vote;
  type Stats = Types.Stats;
  type FundingBadge = Types.FundingBadge;
  type PersonalInformation = Types.PersonalInformation;
  type AccountInformation = Types.AccountInformation;


  
  let fundingBeneficiaries = HashMap.HashMap<Principal,FundingBeneficiary>(0,Principal.equal,Principal.hash);
  let users = HashMap.HashMap<Principal,User>(0,Principal.equal,Principal.hash);
  





  


  public shared ({caller}) func addUser(personalInformation : PersonalInformation) : async Result<(), Text> {
    switch (users.get(caller)) {
      case (null) {
        let newUser : User = {
          personalInformation = {          
          name = personalInformation.name;
          lastName = personalInformation.lastName;
          userName = personalInformation.userName;
          email = personalInformation.email;
          phone = personalInformation.phone;
          profileImage = personalInformation.profileImage;
          country = personalInformation.country;
          city = personalInformation.city;
          };
          accountInformation = {
          principal = caller;
          account = await getDepositAddress(caller);
          createdAt = Time.now();          
          };
          
          //badges = List.nil();
        };
        users.put(caller, newUser);
        return #ok();
      };
      case (?user){
        return #err("User already exists");
      };
    };
  };


  public shared ({ caller }) func deleteUser() : async Result<(), Text> {
    switch(users.get(caller)){
      case (null){
        return #err("User doesnt exist");
      };
      case (?user){
        users.delete(caller);
        return #ok();
      };

    };
  };


  
  public query func getUser(principal : Principal) : async Result<User, Text> {
    switch (users.get(principal)) {
      case (null) {
        return #err("User does not exist");
        };
        case (?user){
          return #ok(user);
        };
    };
  };


  public query func getBeneficiary(principal : Principal) : async Result<FundingBeneficiary, Text> {
    switch (fundingBeneficiaries.get(principal)) {
      case (null) {
        return #err("Beneficiary does not exist");
        };
        case (?beneficiary){
          return #ok(beneficiary);
        };
    };
  };

  


  public shared ({ caller }) func deleteBeneficiary() : async Result<(), Text> {
    switch(fundingBeneficiaries.get(caller)){
      case (null){
        return #err("Beneficiary doesnt exist");
      };
      case (?user){
        fundingBeneficiaries.delete(caller);
        return #ok();
      };

    };
  };



  public query func canisterPrincipal() : async Text {
    return Principal.toText(Principal.fromActor(Defunding));
  };


  public query func getDepositAddress(principal : Principal): async Blob {
    Account.accountIdentifier(Principal.fromActor(Defunding), Account.principalToSubaccount(principal));
  };

        

  public query func greeeet(name : Text) : async Text {
    return "Hello, " # name # "!";
  };

  public shared (msg) func whoami2() : async Text {
        Principal.toText(msg.caller);
    };


  let hexChars = ["0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f"];


  public query func toHex(arr: [Nat8]): async Text {
    Text.join("", Iter.map<Nat8, Text>(Iter.fromArray(arr), func (x: Nat8) : Text {
      let a = Nat8.toNat(x / 16);
      let b = Nat8.toNat(x % 16);
      hexChars[a] # hexChars[b]
    }))
  };


    
};
