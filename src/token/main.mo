import Principal "mo:base/Principal";
import HashMap "mo:base/HashMap";
import Debug "mo:base/Debug";
import Iter "mo:base/Iter";


actor Token{
    let owner: Principal=Principal.fromText("hjm73-p7lxe-ze4il-wnxsl-dxieo-zowbz-wjhal-ecvyr-qtflz-3msia-cae");
    let totalSupply: Nat=1000000000;
    let symbol: Text ="SANG";

    private stable var balanceEntries:[(Principal,Nat)]=[];

    private var balances= HashMap.HashMap<Principal,Nat>(1,Principal.equal,Principal.hash);
   

    public query func balanceOf(who: Principal) : async Nat {

        let  balance: Nat = switch (balances.get(who)){
            case null 0;
            case (?result) result;
        };

        return balance;
    };

    public query func symbolOf():async Text{
        return symbol;
    };

    public shared(msg) func payOut(): async Text{
        Debug.print(debug_show(msg.caller));
        if(balances.get(msg.caller) == null){

        let balance=10000;
        balances.put(msg.caller,balance);
        return "Success";
        }else{
            return "Already Claimed";
        }
    };

    public shared(msg) func transfer(to: Principal,amount: Nat):async Text{
        let fromBalance = await balanceOf(msg.caller);
        if( fromBalance > amount){
            //sender's balance
            let newFormBalance: Nat = fromBalance-amount;
            balances.put(msg.caller,newFormBalance);

            let toBalance = await balanceOf(to);
            let newToBalance = toBalance + amount;

            balances.put(to,newToBalance);
            return "Success";
        }else{
            return "Insuficient Funds";
        }
    };

    system func preupgrade(){
        balanceEntries:= Iter.toArray(balances.entries());
    };

    system func postupgrade(){
        balances:= HashMap.fromIter<Principal,Nat>(balanceEntries.vals(),1,Principal.equal,Principal.hash);
        if(balances.size() < 1)
        {
             balances.put(owner,totalSupply);
        };
    };
};