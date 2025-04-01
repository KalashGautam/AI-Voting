pragma solidity ^0.8.0;

contract AIVotingAdvisor {
    // Enum for different voting options
    enum VoteOption { 
        STRONG_YES, 
        YES, 
        NEUTRAL, 
        NO, 
        STRONG_NO 
    }
    
    // Struct to hold voting parameters
    struct VotingParameters {
        uint256 proposalQuality;       // 0-100 score
        uint256 communitySupport;      // 0-100 score
        uint256 financialImpact;      // 0-100 score
        uint256 longTermBenefits;      // 0-100 score
        uint256 urgency;               // 0-100 score
    }
    
    // Current voting parameters (hardcoded for example)
    VotingParameters public currentParams = VotingParameters({
        proposalQuality: 75,
        communitySupport: 82,
        financialImpact: 60,
        longTermBenefits: 88,
        urgency: 45
    });
    
    // Weightings for each parameter (sum to 100)
    struct ParameterWeights {
        uint8 proposalQualityWeight;      // 0-100
        uint8 communitySupportWeight;     // 0-100
        uint8 financialImpactWeight;      // 0-100
        uint8 longTermBenefitsWeight;    // 0-100
        uint8 urgencyWeight;             // 0-100
    }
    
    // Current weights (hardcoded for example)
    ParameterWeights public weights = ParameterWeights({
        proposalQualityWeight: 25,
        communitySupportWeight: 20,
        financialImpactWeight: 20,
        longTermBenefitsWeight: 25,
        urgencyWeight: 10
    });
    
    // Get current voting recommendation
    function getVotingRecommendation() public view returns (VoteOption) {
        uint256 totalScore = calculateTotalScore();
        
        if (totalScore >= 80) {
            return VoteOption.STRONG_YES;
        } else if (totalScore >= 60) {
            return VoteOption.YES;
        } else if (totalScore >= 40) {
            return VoteOption.NEUTRAL;
        } else if (totalScore >= 20) {
            return VoteOption.NO;
        } else {
            return VoteOption.STRONG_NO;
        }
    }
    
    // Calculate total weighted score
    function calculateTotalScore() internal view returns (uint256) {
        uint256 score = 0;
        
        score += (currentParams.proposalQuality * weights.proposalQualityWeight) / 100;
        score += (currentParams.communitySupport * weights.communitySupportWeight) / 100;
        score += (currentParams.financialImpact * weights.financialImpactWeight) / 100;
        score += (currentParams.longTermBenefits * weights.longTermBenefitsWeight) / 100;
        score += (currentParams.urgency * weights.urgencyWeight) / 100;
        
        return score;
    }
    
    // Get explanation for the recommendation
    function getRecommendationExplanation() public view returns (string memory) {
        VoteOption recommendation = getVotingRecommendation();
        
        if (recommendation == VoteOption.STRONG_YES) {
            return "Strongly recommend YES: The proposal has excellent quality, strong community support, and significant long-term benefits.";
        } else if (recommendation == VoteOption.YES) {
            return "Recommend YES: The proposal has good qualities and benefits that outweigh the concerns.";
        } else if (recommendation == VoteOption.NEUTRAL) {
            return "Neutral recommendation: The proposal has both positive and negative aspects that balance each other out.";
        } else if (recommendation == VoteOption.NO) {
            return "Recommend NO: The proposal has significant drawbacks that outweigh its benefits.";
        } else {
            return "Strongly recommend NO: The proposal has serious flaws and would likely have negative consequences.";
        }
    }
    
    // Get detailed scoring breakdown
    function getScoringBreakdown() public view returns (
        uint256 totalScore,
        uint256 proposalQualityScore,
        uint256 communitySupportScore,
        uint256 financialImpactScore,
        uint256 longTermBenefitsScore,
        uint256 urgencyScore
    ) {
        totalScore = calculateTotalScore();
        proposalQualityScore = (currentParams.proposalQuality * weights.proposalQualityWeight) / 100;
        communitySupportScore = (currentParams.communitySupport * weights.communitySupportWeight) / 100;
        financialImpactScore = (currentParams.financialImpact * weights.financialImpactWeight) / 100;
        longTermBenefitsScore = (currentParams.longTermBenefits * weights.longTermBenefitsWeight) / 100;
        urgencyScore = (currentParams.urgency * weights.urgencyWeight) / 100;
    }
}
