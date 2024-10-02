From: Andrew Jeffery <andrew@codeconstruct.com.au>
Date: Wed, 02 Oct 2024 11:15:40 +0930
Subject: [PATCH v2 07/10] ARM: dts: aspeed: yosemite4: correct the
 compatible string for max31790
In-Reply-To: <20241001082053.3455836-8-Delphine_CC_Chiu@wiwynn.com>
References: <20241001082053.3455836-1-Delphine_CC_Chiu@wiwynn.com>
	 <20241001082053.3455836-8-Delphine_CC_Chiu@wiwynn.com>
Message-ID: <21415012dec630193b916900f1382d5518d98042.camel@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Tue, 2024-10-01 at 16:20 +0800, Delphine CC Chiu wrote:
> From: Ricky CX Wu <ricky.cx.wu.wiwynn@gmail.com>
> 
> Fix the compatible string for max31790 to match the binding document.
> 
> Fixes: 2b8d94f4b4a4 ("ARM: dts: aspeed: yosemite4: add Facebook Yosemite 4 BMC")

Can you please order this change to patch 06/10? That way the fixes tag
is meaningful. Otherwise the fix is disrupted by the code motion in
06/10.

Andrew
