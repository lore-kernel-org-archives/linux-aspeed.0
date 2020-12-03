From: Borislav Petkov <bp@alien8.de>
Date: Thu, 3 Dec 2020 08:20:36 +0100
Subject: [PATCH v2 3/3] edac: Supporting AST2400 and AST2600 edac driver
In-Reply-To: <PS1PR06MB2600D6A1E73D89EA0D0D59DC8AF20@PS1PR06MB2600.apcprd06.prod.outlook.com>
References: <20201202063612.21241-1-troy_lee@aspeedtech.com>
 <20201202063612.21241-3-troy_lee@aspeedtech.com>
 <CACPK8XcBTm8-cAPmtswHbYAf2B+PdBiZ2s1XK1UqKA_NQX_-mw@mail.gmail.com>
 <PS1PR06MB26008E4BCB805553EDEC45038AF30@PS1PR06MB2600.apcprd06.prod.outlook.com>
 <b6dd3a91-abe7-4e9d-b801-6e54e4c88827@www.fastmail.com>
 <20201202182349.GJ2951@zn.tnic>
 <PS1PR06MB2600D6A1E73D89EA0D0D59DC8AF20@PS1PR06MB2600.apcprd06.prod.outlook.com>
Message-ID: <20201203072036.GB3059@zn.tnic>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Dec 03, 2020 at 01:27:27AM +0000, Troy Lee wrote:
> Hi Broislav and Andrew,
> 
> I removed these exported function and submitted v3 PATCH.

I saw that. A couple of comments:

First of all, please do not top-post on a public mailing list.

Secondly, Joel gave you Reviewed-by: and Acked-by: for your patches 1
and 2 which are not in your new submission. But they should be, please
have a look at Documentation/process/ while you're waiting for his
review of your v3.

You don't have to resend now with those added and I can add them if Joel
is fine with patch 3 but pls remember to pick up tags reviewers have
given you, in the future.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
