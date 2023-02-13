From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Mon, 13 Feb 2023 21:24:17 +0800
Subject: [PATCH v3 1/5] clk: ast2600: allow empty entries in aspeed_g6_gates
In-Reply-To: <cover.1676294433.git.jk@codeconstruct.com.au>
References: <cover.1676294433.git.jk@codeconstruct.com.au>
Message-ID: <bb1ef5ea4973466442e9d8c9a932117b840b1211.1676294433.git.jk@codeconstruct.com.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

We're about to remove an entry from aspeed_g6_gates, but we won't want
to alter/reorder existing entries. Allow empty entries in this array.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

---
v3:
 - reword commit message
---
 drivers/clk/clk-ast2600.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/clk/clk-ast2600.c b/drivers/clk/clk-ast2600.c
index 9c3305bcb27a..1f08ff3c60fa 100644
--- a/drivers/clk/clk-ast2600.c
+++ b/drivers/clk/clk-ast2600.c
@@ -652,6 +652,9 @@ static int aspeed_g6_clk_probe(struct platform_device *pdev)
 		const struct aspeed_gate_data *gd = &aspeed_g6_gates[i];
 		u32 gate_flags;
 
+		if (!gd->name)
+			continue;
+
 		/*
 		 * Special case: the USB port 1 clock (bit 14) is always
 		 * working the opposite way from the other ones.
-- 
2.39.1

