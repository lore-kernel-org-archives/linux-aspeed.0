From: Hongwei Zhang <hongweiz@ami.com>
Date: Wed, 13 Jan 2021 17:38:07 -0500
Subject: [PATCH, v1 0/1] gpio: aspeed: Add gpio base address reading
Message-ID: <20210113223808.31626-1-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Reviewer,

Add gpio base address reading in the driver; in old code, it just
returns -1 to gpio->chip.base. In this patch, the code first try to
read base address from of_property_read_u32(), if it fails, then
return -1.

Hongwei Zhang (1):
  gpio: aspeed: Add gpio base address reading

 drivers/gpio/gpio-aspeed.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.17.1

