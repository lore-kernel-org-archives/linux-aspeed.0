From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 21 Mar 2022 16:53:09 +0100
Subject: [PATCH v2 3/3] ARM: dts: aspeed: add reset properties into MDIO
 nodes
In-Reply-To: <20220321095648.4760-4-dylan_hung@aspeedtech.com>
References: <20220321095648.4760-1-dylan_hung@aspeedtech.com>
 <20220321095648.4760-4-dylan_hung@aspeedtech.com>
Message-ID: <eefe6dd8-6542-a5c2-6bdf-2c3ffe06e06b@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 21/03/2022 10:56, Dylan Hung wrote:
> Add reset control properties into MDIO nodes.  The 4 MDIO controllers in
> AST2600 SOC share one reset control bit SCU50[3].
> 
> Signed-off-by: Dylan Hung <dylan_hung@aspeedtech.com>
> Cc: stable at vger.kernel.org

Please describe the bug being fixed. See stable-kernel-rules.

Best regards,
Krzysztof
