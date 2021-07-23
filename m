From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 23 Jul 2021 17:28:58 +0930
Subject: [RFC PATCH 6/6] pinctrl: Check get_group_pins callback on init
In-Reply-To: <20210723075858.376378-1-andrew@aj.id.au>
References: <20210723075858.376378-1-andrew@aj.id.au>
Message-ID: <20210723075858.376378-7-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Do configurations exist where this doesn't make sense? I lost some time
to debugging the fact that I was missing the callback :(

Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
---
 drivers/pinctrl/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index e4862552eb9b..4c436a419856 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1994,7 +1994,8 @@ static int pinctrl_check_ops(struct pinctrl_dev *pctldev)
 
 	if (!ops ||
 	    !ops->get_groups_count ||
-	    !ops->get_group_name)
+	    !ops->get_group_name ||
+	    !ops->get_group_pins)
 		return -EINVAL;
 
 	return 0;
-- 
2.30.2

