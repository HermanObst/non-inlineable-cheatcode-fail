// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.7 <0.9.0;
import {Test} from "../lib/forge-std/src/Test.sol";
import {console} from "../lib/forge-std/src/Console.sol";
import "../src/Greeter.sol";

contract testFail is Test {
    function test_migrateCodeHashWhenforkZkSyncThenZkVmOff() external {
       vm.createSelectFork("https://mainnet.era.zksync.io");
       (bool success, ) = address(vm).call(
           abi.encodeWithSignature("zkVm(bool)", false)
       );
       
       address(vm).call(abi.encodeWithSignature("writeFile(string,string)", './herman.txt' ,"LOW LEVEL")); // This works as is a low level call
       assert(address(vm).codehash != 0); // This shows cheatcode address dont have code.
       vm.writeFile('./herman.txt' ,"HIGH LIVEL PASSING"); // Passing with eb21bc27
    }
}