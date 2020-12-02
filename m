From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 03 Dec 2020 01:32:44 +1030
Subject: [PATCH v2 3/3] edac: Supporting AST2400 and AST2600 edac driver
In-Reply-To: <PS1PR06MB26008E4BCB805553EDEC45038AF30@PS1PR06MB2600.apcprd06.prod.outlook.com>
References: <20201202063612.21241-1-troy_lee@aspeedtech.com>
 <20201202063612.21241-3-troy_lee@aspeedtech.com>
 <CACPK8XcBTm8-cAPmtswHbYAf2B+PdBiZ2s1XK1UqKA_NQX_-mw@mail.gmail.com>
 <PS1PR06MB26008E4BCB805553EDEC45038AF30@PS1PR06MB2600.apcprd06.prod.outlook.com>
Message-ID: <b6dd3a91-abe7-4e9d-b801-6e54e4c88827@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 2 Dec 2020, at 19:11, Troy Lee wrote:
> Hi Joel,
> 
> Thanks for the suggestion, I'll fix the review and create an new patch 
> against 
> latest Linux branch. Those exported function will be referenced in 
> other driver yet 
> to be upstream, so should I move those exported functions out of this 
> patch?
> 

Yes, let's leave the exports out of this patch, and add them in when you send 
the patch that depends on them.

Andrew
