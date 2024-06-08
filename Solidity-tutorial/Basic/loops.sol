// SPDX-License-Identifier: MIT
pragma solidity ^0.8;

contract loops {
    function loop() external pure {
        for (uint i = 0; i > 10; i++) {
            //code
            if (i == 3) {
                //when i =3 further code will not run, the loop will increment i and start again.
                continue;
            }
            //more code
            if (i == 7) {
                break; //the loop will stop executing once i =7.
            }
        }

        uint j = 0;

        while (j < 10) {
            //code
            j++;
        }
    }

    function total(uint _n) external pure returns (uint) {
        uint s;
        for (uint i = 0; i <= _n; i++) {
            s += i;
        }
        return s;
    }
}
