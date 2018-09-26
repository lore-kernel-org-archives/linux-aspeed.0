From: Amithash Prasad <amithash@fb.com>
Date: Wed, 26 Sep 2018 18:07:54 +0000
Subject: [PATCH] net/ncsi: Add NCSI OEM command for FB Tiogapass
In-Reply-To: <FC2694E0-2F55-4089-8544-668243C6ECA2@fb.com>
References: <20180925000840.4111212-1-vijaykhemka@fb.com>
 <CACPK8XcDExGvCNBcFqOOP+1zQFFs6pMao+7rsZrJFqxPgcY+1Q@mail.gmail.com>
 <F570466E-4F6C-4AE1-91E0-0B4ECC193BE0@fb.com>
 <7cd8a49a057f1032e126b1e104fcf61e4956e06d.camel@mendozajonas.com>,
 <FC2694E0-2F55-4089-8544-668243C6ECA2@fb.com>
Message-ID: <MWHPR15MB14861AED8F8AF652CE5E62B3B2150@MWHPR15MB1486.namprd15.prod.outlook.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

 >  As I understand Justin's version adds a generic handler, using the NCSI

 >  Netlink interface to pass OEM commands and responses to and from
 >  userspace, which does the actual packet handling.
Thanks for the direction Sam! Justin, if you don't mind, can you share the patches you have to add the support? This actually would solve a few other things we are trying to accomplish.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20180926/69622785/attachment.html>
