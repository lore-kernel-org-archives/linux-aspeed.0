From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 15 Feb 2021 09:31:10 +1030
Subject: [PATCH] soc: aspeed: socinfo: Add new systems
In-Reply-To: <20210210114651.334324-1-joel@jms.id.au>
References: <20210210114651.334324-1-joel@jms.id.au>
Message-ID: <78fe9c2a-aa41-45b5-b0ec-35fe77b58598@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Wed, 10 Feb 2021, at 22:16, Joel Stanley wrote:
> Aspeed's u-boot sdk has been updated with the SoC IDs for the AST2605
> variant, as well as A2 and A3 variants of the 2600 family.
> 
> From u-boot's arch/arm/mach-aspeed/ast2600/scu_info.c:
> 
>     SOC_ID("AST2600-A0", 0x0500030305000303),
>     SOC_ID("AST2600-A1", 0x0501030305010303),
>     SOC_ID("AST2620-A1", 0x0501020305010203),
>     SOC_ID("AST2600-A2", 0x0502030305010303),
>     SOC_ID("AST2620-A2", 0x0502020305010203),
>     SOC_ID("AST2605-A2", 0x0502010305010103),
>     SOC_ID("AST2600-A3", 0x0503030305030303),
>     SOC_ID("AST2620-A3", 0x0503020305030203),
>     SOC_ID("AST2605-A3", 0x0503010305030103),
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
