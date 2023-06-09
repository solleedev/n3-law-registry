// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

/// @title Linked Markdown Agreement Registry Interface
/// @author sollee.eth
/// @notice Package manager for Linked Markdown
/// @dev Zone names MUST satisfy the following regex:
/// @dev   ([a-z0-9\-]{1,32})
/// @dev Agreement names MUST satisfy the following regex:
/// @dev   ([a-z0-9\-]{1,32})
/// @dev Revision names MUST satisfy the following regex:
/// @dev   ([a-z0-9\-\._]{1,32})
/// @dev A path MUST satisfy the following regex:
/// @dev   ^([a-z0-9\-]{1,32})\/([a-z0-9\-]{1,32})@([a-z0-9\-\._]{1,32})$
/// @dev Capture group 1 is the zone, group 2 is the agreement & 3 is the revision.
/// @dev Agreements should be referenced like within Linked Markdown like:
/// @dev   zonename/agreement@revision or just zonename/agreement to get
/// @dev the key at "latest" (an exception to the immutability
/// @dev of revisions: it can be changed to whatever)
/// @dev e.g. nation3/judge-agreement@v4.0.0 or sollee/rental@revisionhere
interface IDocRegistry {
    event AgreementUpdated(
        bytes32 zone,
        bytes32 key,
        string value,
        bytes32 revision
    );

    /// @notice Claim a zone
    /// NOTE: Zone names SHOULD satisfy the following regex:
    /// ^([a-zA-Z0-9\-]{1,32})$
    /// Otherwise, it cannot be resolved.
    /// @param zone Zone name.
    function claimZone(string memory zone) external;

    /// @notice Update/create an agreement under a zone, creating a new revision
    /// @dev Agreements have tags so that people can choose to
    /// @dev lock on to one revision or automatically use the latest.
    /// NOTE: Agreement names SHOULD satisfy the following regex:
    /// ^([a-z0-9\-]{1,32})$
    /// @param zone NFT ID of zone name (e.g. vitalik, luisc, nation3)
    /// @param key Hash of agreement name (e.g. rental, delivery-escrow)
    /// @param revision Hash of revision name (e.g. v1.0.0)
    /// @param value Hash of agreement data, to be retrieved via IPFS
    function updateAgreement(
        bytes32 zone,
        bytes32 key,
        string calldata revision,
        string calldata value
    ) external;

    /// @notice Returns CID of an agreement version
    /// @param zone Hash of zone name (e.g. sollee, luisc, nation3).
    /// @param key Hash of agreement name (e.g. rental, delivery-escrow).
    /// @param revision Revision of agreement
    /// @return CID of agreement data, to be retrieved via IPFS
    function zoneAgreement(
        bytes32 zone,
        bytes32 key,
        bytes32 revision
    ) external view returns (string memory);

    /// @notice Returns zone owner
    /// @param zone Hash of zone name (e.g. sollee, luisc, nation3).
    /// @return Zone owner
    function zoneOwner(bytes32 zone) external view returns (address);

    /// @notice Returns the token ID of a zone
    /// @param zone Hash of zone name (e.g. sollee, luisc, nation3).
    /// @return Token ID
    function zoneID(bytes32 zone) external view returns (uint256);

    /// @notice Returns the name of a zone
    /// @param zone Hash of zone name (e.g. sollee, luisc, nation3).
    /// @return Zone name
    function name(bytes32 zone) external view returns (string memory);
}
