From: Hongwei Zhang <hongweiz@ami.com>
Date: Tue, 22 Dec 2020 15:14:35 -0500
Subject: [Aspeed,
 v2 0/2] net: ftgmac100: Change the order of getting MAC address
In-Reply-To: <20201221205157.31501-2-hongweiz@ami.com>
References: <20201221205157.31501-2-hongweiz@ami.com>
Message-ID: <20201222201437.5588-1-hongweiz@ami.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Dear Reviewer,

Use native MAC address is preferred over other choices, thus change the order
of reading MAC address, try to read it from MAC chip first, if it's not
 availabe, then try to read it from device tree.

Thanks,
--Hongwei

Changelog:
v2:
- Corrected comments in the patch

v1: https://patchwork.ozlabs.org/project/linux-aspeed/list/?series=221576
- Initial submission

Hongwei Zhang (1):
  net: ftgmac100: Change the order of getting MAC address

 drivers/net/ethernet/faraday/ftgmac100.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

-- 
2.17.1

