From: Andrew Jeffery <andrew@aj.id.au>
Date: Mon, 11 Apr 2022 09:50:40 +0930
Subject: [PATCH RESEND v3 3/3] ARM: dts: aspeed: add reset properties into
 MDIO nodes
In-Reply-To: <20220407075734.19644-4-dylan_hung@aspeedtech.com>
References: <20220407075734.19644-1-dylan_hung@aspeedtech.com>
 <20220407075734.19644-4-dylan_hung@aspeedtech.com>
Message-ID: <1b708e26-264c-4b68-b6c8-c31a8d34a873@www.fastmail.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit



On Thu, 7 Apr 2022, at 17:27, Dylan Hung wrote:
> Add reset control properties into MDIO nodes.  The 4 MDIO controllers in
> AST2600 SOC share one reset control bit SCU50[3].
>
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
