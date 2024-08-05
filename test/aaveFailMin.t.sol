// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.7 <0.9.0;
import {Test} from "../lib/forge-std/src/Test.sol";
import {console} from "../lib/forge-std/src/Console.sol";
import "../src/Greeter.sol";

contract UsesCheatcodes is Test {
    function activeForkId() external view returns (uint256 forkId){
        console.log("inside foo");
        return vm.activeFork();
    }
}

contract AaveLike is Test {
   Greeter internal greeter;
   UsesCheatcodes internal helper;

   function setUp() external {
       vm.createSelectFork("https://mainnet.era.zksync.io");

       //proposal deployment
       greeter = new Greeter();

       //super.setUp()
       helper = new UsesCheatcodes();
       vm.makePersistent(address(helper));
       vm.allowCheatcodes(address(helper));
   }

   function test_aave() external {
       (bool success, ) = address(vm).call(
           abi.encodeWithSignature("zkVm(bool)", false)
       );
       assert(address(vm).codehash != 0);
   }
}