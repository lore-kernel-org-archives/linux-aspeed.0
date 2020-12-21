From: Hongwei Zhang <hongweiz@ami.com>
Date: Mon, 21 Dec 2020 15:51:56 -0500
Subject: [Aspeed,
 v1 0/1] net: ftgmac100: Change the order of getting MAC address
Message-ID: <20201221205157.31501-1-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Reviewer,

Use native MAC address is preferred over other choices, thus change the order
of reading MAC address, try to read it from MAC chip first, if it's not
 availabe, then try to read it from device tree.

Hongwei Zhang (1):
  net: ftgmac100: Change the order of getting MAC address

 drivers/net/ethernet/faraday/ftgmac100.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

-- 
2.17.1

