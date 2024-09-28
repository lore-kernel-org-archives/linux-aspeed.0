From: Patrick Williams <patrick@stwcx.xyz>
Date: Fri, 27 Sep 2024 22:33:18 -0400
Subject: [PATCH v1] ARM: dts: aspeed: yosemite4: Add i2c-mux for CPLD IOE
 on Spider Board
In-Reply-To: <TYZPR04MB5853B51141F3D0610D970265D66B2@TYZPR04MB5853.apcprd04.prod.outlook.com>
References: <20240926024133.3786712-1-Delphine_CC_Chiu@wiwynn.com>
 <fbdc9efe87a1bed9fea7d0abaf955aa1a3dc24ac.camel@codeconstruct.com.au>
 <TYZPR04MB5853B51141F3D0610D970265D66B2@TYZPR04MB5853.apcprd04.prod.outlook.com>
Message-ID: <Zvdq7o6NFXRVCJqX@heinlein.vulture-banana.ts.net>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Fri, Sep 27, 2024 at 09:24:11AM +0000, Delphine_CC_Chiu/WYHQ/Wiwynn wrote:

> Would like to ask should I base on the openbmc/linux repo to create the
> remaining patches that have context dependencies and add the lore link
> of the those patches that I've sent in the cover letter?

I believe you're trying to get the patches applied onto the upstream
tree, so no you should not base on the openbmc/linux repo.  That repo is
a 6.6 branch.  You need to base the commits on torvalds/linux.

-- 
Patrick Williams
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.ozlabs.org/pipermail/linux-aspeed/attachments/20240927/d8aab60a/attachment.sig>
