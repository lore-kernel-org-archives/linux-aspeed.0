From: Vijay Khemka <vijaykhemka@fb.com>
Date: Wed, 26 Sep 2018 17:07:43 +0000
Subject: [PATCH] net/ncsi: Add NCSI OEM command for FB Tiogapass
In-Reply-To: <7cd8a49a057f1032e126b1e104fcf61e4956e06d.camel@mendozajonas.com>
References: <20180925000840.4111212-1-vijaykhemka@fb.com>
 <CACPK8XcDExGvCNBcFqOOP+1zQFFs6pMao+7rsZrJFqxPgcY+1Q@mail.gmail.com>
 <F570466E-4F6C-4AE1-91E0-0B4ECC193BE0@fb.com>
 <7cd8a49a057f1032e126b1e104fcf61e4956e06d.camel@mendozajonas.com>
Message-ID: <FC2694E0-2F55-4089-8544-668243C6ECA2@fb.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

>    Hi Vijay,
    
 >  Thanks for the patch; before I get too into a review though I'd like to
 >  loop in Justin (cc'd) who I know is also working on an OEM command patch.
 >  The changes here are very specific (eg. a command specific config option
 >  "CONFIG_NCSI_OEM_CMD_GET_MAC"), which is ok on a small scale but if we
 >  start to add an increasing amount of commands could get out of hand.
 >  As I understand Justin's version adds a generic handler, using the NCSI
 >  Netlink interface to pass OEM commands and responses to and from
 >  userspace, which does the actual packet handling.
 >  It would be good to compare these two approaches first before committing
 >  to any one path
    
Hi Sam,
My oem command handler is generic and can be used for any oem commands and oem response handler can be made more generic. We can certainly write a wrapper to support netlink oem command to receive form user space. There are Mellanox specific functions which sends Mellanox specific request. These needed as a part of initial configuration. We can remove Kconfig option with more generic approach.

-Vijay 

