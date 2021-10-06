// SPDX-License-Identifier: UNLICENSED
pragma solidity =0.7.6;
pragma abicoder v2;

import '../libraries/OracleLibrary.sol';

contract OracleTest {
    function consult(address pool, uint32 secondsAgo)
        public
        view
        returns (OracleLibrary.TimeWeightedPoolData memory observation)
    {
        observation = OracleLibrary.consult(pool, secondsAgo);
    }

    function getQuoteAtTick(
        int24 tick,
        uint128 baseAmount,
        address baseToken,
        address quoteToken
    ) public pure returns (uint256 quoteAmount) {
        quoteAmount = OracleLibrary.getQuoteAtTick(tick, baseAmount, baseToken, quoteToken);
    }

    // For gas snapshot test
    function getGasCostOfConsult(address pool, uint32 period) public view returns (uint256) {
        uint256 gasBefore = gasleft();
        OracleLibrary.consult(pool, period);
        return gasBefore - gasleft();
    }

    function getGasCostOfGetQuoteAtTick(
        int24 tick,
        uint128 baseAmount,
        address baseToken,
        address quoteToken
    ) public view returns (uint256) {
        uint256 gasBefore = gasleft();
        OracleLibrary.getQuoteAtTick(tick, baseAmount, baseToken, quoteToken);
        return gasBefore - gasleft();
    }

    function getOldestObservationSecondsAgo(address pool)
        public
        view
        returns (uint32 secondsAgo, uint32 currentTimestamp)
    {
        secondsAgo = OracleLibrary.getOldestObservationSecondsAgo(pool);
        currentTimestamp = uint32(block.timestamp);
    }

    function getBlockStartingTick(address pool) public view returns (int24) {
        return OracleLibrary.getBlockStartingTick(pool);
    }

    function getArithmeticMeanTickWeightedByLiquidity(OracleLibrary.TimeWeightedPoolData[] memory observations)
        public
        pure
        returns (int24 arithmeticMeanWeightedTick)
    {
        arithmeticMeanWeightedTick = OracleLibrary.getArithmeticMeanTickWeightedByLiquidity(observations);
    }
}
