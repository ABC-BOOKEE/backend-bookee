 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
 
contract bookNft {
    address payable immutable i_feeAddress;
    uint public immutable i_percent;
    uint256 itemCount;

constructor (uint _feePercent){
    i_feeAddress = payable (msg.sender);
    i_percent = _feePercent;
}



    struct book {
        uint256 bookId;
        IERC721 nft;
        uint256 price;
        uint256 tokenId;
        address payable seller;
        bool sold;
    }





   

    event bookBought(
        address indexed buyer,
        IERC721 indexed nftAddress,
        uint256 indexed tokenId,
        uint256 price
    );

    mapping( uint256 => book) private bookMapping;

    book [] bookArray;
 

     
   
 
    function listBook(
        IERC721 nftAddress,
        uint256 _bookId,
        uint256 _price
    )
     external
     returns (uint256)
        

    {
        require (_price >0, "price should be greater than zero");
        itemCount ++;
         nftAddress.transferFrom (msg.sender, address (this),_bookId);
        bookMapping[_bookId]= book (itemCount,nftAddress,_price,_bookId,payable(msg.sender),false);
        book memory newBk = book (itemCount,nftAddress,_price,_bookId,payable(msg.sender),false);
        bookArray.push(newBk);

        return itemCount;
    }

     




 
    


    function buyItem(uint256 bookId)
        external
        payable
    

    {
         uint256 totalPrice = calcTotalPrice (bookId);
        book memory bookFound = bookMapping[bookId];
        require (msg.value < totalPrice, "not enough money ");
        bookFound.seller.transfer (bookFound.price);
        i_feeAddress.transfer(totalPrice- bookFound.price);
        bookFound.nft.safeTransferFrom(address(this), msg.sender,bookFound.tokenId);
        emit bookBought(msg.sender, bookFound.nft, bookFound.tokenId, bookFound.price);
    }

    
    function calcTotalPrice (uint256 bookId) public view  returns (uint256){
        return bookMapping [bookId].price * (100 + i_percent/100);

    }
     
function getBooks () public view  returns (book [] memory){
    return bookArray;
}

    
  
 
}