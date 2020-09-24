From: Andrew Jeffery <andrew@aj.id.au>
Date: Thu, 24 Sep 2020 16:26:37 +0930
Subject: [PATCH v3 2/3] soc: aspeed: Add soc info driver
In-Reply-To: <20200921091644.133107-3-joel@jms.id.au>
References: <20200921091644.133107-1-joel@jms.id.au>
 <20200921091644.133107-3-joel@jms.id.au>
Message-ID: <eaa6ddb0-476a-4e6e-be52-26dd6a02dba0@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Mon, 21 Sep 2020, at 18:46, Joel Stanley wrote:
> This adds a SOC_BUS info driver for the ASPEED platform.
> 
> The full ID table is preserved in this commit message in case someone
> finds a need to change the implemntation in the future.
> 
> 	{ "AST1100-A0", 0x00000200 },
> 	{ "AST1100-A1", 0x00000201 },
> 	{ "AST1100-A2", 0x00000202 },
> 	{ "AST1100-A3", 0x00000202 },
> 
> 	{ "AST2050-A0", 0x00000200 },
> 	{ "AST2050-A1", 0x00000201 },
> 	{ "AST2050-A2", 0x00000202 },
> 	{ "AST2050-A3", 0x00000202 },
> 
> 	{ "AST2100-A0", 0x00000300 },
> 	{ "AST2100-A1", 0x00000301 },
> 	{ "AST2100-A2", 0x00000302 },
> 	{ "AST2100-A3", 0x00000302 },
> 
> 	{ "AST2150-A0", 0x00000202 },
> 	{ "AST2150-A1", 0x00000202 },
> 
> 	{ "AST2200-A0", 0x00000102 },
> 	{ "AST2200-A1", 0x00000102 },
> 
> 	{ "AST2300-A0", 0x01000003 },
> 	{ "AST2300-A1", 0x01010303 },
> 
> 	{ "AST1300-A1", 0x01010003 },
> 	{ "AST1050-A1", 0x01010203 },
> 
> 	{ "AST2400-A0", 0x02000303 },
> 	{ "AST2400-A1", 0x02010303 },
> 	{ "AST1400-A1", 0x02010103 },
> 	{ "AST1250-A1", 0x02010303 },
> 
> 	{ "AST2500-A0", 0x04000303 },
> 	{ "AST2510-A0", 0x04000103 },
> 	{ "AST2520-A0", 0x04000203 },
> 	{ "AST2530-A0", 0x04000403 },
> 	{ "AST2500-A1", 0x04010303 },
> 	{ "AST2510-A1", 0x04010103 },
> 	{ "AST2520-A1", 0x04010203 },
> 	{ "AST2530-A1", 0x04010403 },
> 	{ "AST2500-A2", 0x04030303 },
> 	{ "AST2510-A2", 0x04030103 },
> 	{ "AST2520-A2", 0x04030203 },
> 	{ "AST2530-A2", 0x04030403 },
> 
> 	{ "AST2600-A0", 0x05000303 },
> 	{ "AST2600-A1", 0x05010303 },
> 	{ "AST2600-A2", 0x05020303 },
> 	{ "AST2620-A1", 0x05010203 },
> 	{ "AST2620-A2", 0x05020203 },
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

I didn't rigorously check the list above, but it looks reasonable at a glance. 
The code looks good to me this time, so:

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
