From: Stefan Schaeckeler (sschaeck) <sschaeck@cisco.com>
Date: Mon, 7 Dec 2020 08:57:00 +0000
Subject: [PATCH 3/3] edac: Supporting AST2400 and AST2600 edac driver
In-Reply-To: <PS1PR06MB26008D10C46C5DF0B47F81368AF40@PS1PR06MB2600.apcprd06.prod.outlook.com>
References: <20201130083345.4814-1-troy_lee@aspeedtech.com>
 <20201130083345.4814-3-troy_lee@aspeedtech.com>
 <4AD4AB7A-54E7-4922-9547-7E26D61F7C77@cisco.com>
 <PS1PR06MB26008D10C46C5DF0B47F81368AF40@PS1PR06MB2600.apcprd06.prod.outlook.com>
Message-ID: <40547026-144F-443C-BF14-C7FA0E3229C5@cisco.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello Troy,

> Hi Stefan,
>
> The driver was ported from latest ASPEED BSP, so I only test with ECC-on/off 
> from u-boot and check if driver runs correctly.

I noticed now most changes are these "exports". As you removed them a later revision, the patch looks now lean and clean. I'll give you my Reviewed-by tag after you addressed Andrew's last comment.



> The test doc you provided is very nice and detailed, I'll try to reproduce the 
> injection test in v2 patch.

It does not harm to redo the testing. That is time-consuming and with your current, now trivial changes, it's not really necessary.

 Stefan

