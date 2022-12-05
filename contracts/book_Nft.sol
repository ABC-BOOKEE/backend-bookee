 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
 
contract bookNft {
    address payable immutable i_feeAddress;
    uint public immutable i_percent;
    uint256 itemCount;

constructor (uint _feePercent){
    i_feeAddress = payable (msg.sender);
    i_feeAmmount = _feePercent;
}



    struct book {
        bookId;
        IERC721 nft;
        uint256 price;
        uint256 tokenId
        address payable seller;
        bool sold;
    }





   

    event bookBought(
        address indexed buyer,
        address indexed nftAddress,
        uint256 indexed tokenId,
        uint256 price
    );

    mapping( uint256 => book) private bookMapping;

    modifier notListed(
        address nftAddress,
        uint256 tokenId
    ) {
        Listing memory listing = s_listings[nftAddress][tokenId];
        if (listing.price > 0) {
            revert AlreadyListed(nftAddress, tokenId);
        }
        _;
    }

    modifier isListed(address nftAddress, uint256 tokenId) {
        Listing memory listing = s_listings[nftAddress][tokenId];
        if (listing.price <= 0) {
            revert NotListed(nftAddress, tokenId);
        }
        _;
    }

    modifier isOwner(
        address nftAddress,
        uint256 tokenId,
        address spender
    ) {
        IERC721 nft = IERC721(nftAddress);
        address owner = nft.ownerOf(tokenId);
        if (spender != owner) {
            revert NotOwner();
        }
        _;
    }

     modifier isNotOwner(
        address nftAddress,
        uint256 tokenId,
        address spender
    ) {
        IERC721 nft = IERC721(nftAddress);
        address owner = nft.ownerOf(tokenId);
        if (spender == owner) {
            revert IsNotOwner();
        }
        _;
    } */


    function listBook(
        IERC721 nftAddress,
        uint256 _bookId,
        uint256 _price
    )
     external
     returns (uint256)
        

    {
        require (_price >0, "price should be greater than zero")
        itemCount ++;
         nftAddress.transferFrom (msg.sender, address (this), tokenId);
        bookMapping[bookID]= book (itemCount,nftAddress,price,_bookId,payable(msg.sender),false);

        emit ItemListed(msg.sender, nftAddress, tokenId, price);

        return itemCount;
    }

     




 
    


    function buyItem(uint256 bookId)
        external
        payable
    

    {
         uint256 totalPrice = calcTotalPrice (bookId)
        book memory bookFound = bookMapping[bookId];
        require (msg.value < totalPrice, "not enough money ");
        bookFound.seller.transfer (bookFound.price);
        i_feeAddress.transfer(totalPrice- bookFound.price);
        bookFound.nft.safeTransferFrom(address(this), msg.sender,bookFound.tokenId);
        emit ItemBought(msg.sender, bookFound.nft, bookFound.tokenId, bookFound.price);
    }

    
    function calcTotalPrice (uint256 bookId) public view  returns (uint2256){
        return bookMapping [bookId].price * (100 + i_percent/100)

    }
     


    
  
 
}