pragma solidity ^0.4.25;

contract UsersContract{

    struct User{
        string name;
        string surName;
    }

    mapping(address => User) private users;
    mapping(address => bool) private joinedUsers;
    address[] total;

    event onUserJoined(address, string);

    function join(string name, string surName) public{
        require(!userJoined(msg.sender)); // si no se ha unido, te puedes registrar
        //storage es para guardar los datos de forma persistente
        User storage user = users[msg.sender];
        user.name = name;
        user.surName = surName;
        joinedUsers[msg.sender] = true;
        total.push(msg.sender);

        emit onUserJoined(msg.sender, string(abi.encodePacked(name, " ", surName)));
    }

    function getUser(address addr) public view returns(string, string){
        require(userJoined(addr)); // si se ha registrado, puedes ver sus datos
        //memory porque no vamos a guardar ningun dato, solo consultar
        User  memory user = users[addr];
        return (user.name, user.surName);
    }

    function userJoined(address addr) private view returns(bool){
        return joinedUsers[addr];
    }

    function totalUsers() public view returns(uint){
        return total.length;
    }

}