From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 14 Dec 2021 13:35:35 +1100
Subject: [PATCH v3 2/4] usb: aspeed-vhub: fix remote wakeup failure in
 iKVM use case
In-Reply-To: <HK0PR06MB320271524E51BDFA922F070780709@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20211208100545.1441397-1-neal_liu@aspeedtech.com>
 <20211208100545.1441397-3-neal_liu@aspeedtech.com>
 <391323f136e49387797d43e89b6e42cd95d916c2.camel@kernel.crashing.org>
 <HK0PR06MB320271524E51BDFA922F070780709@HK0PR06MB3202.apcprd06.prod.outlook.com>
Message-ID: <0888eb83c8b2bd53d4c3e2355019052d0ab40db6.camel@kernel.crashing.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, 2021-12-09 at 02:37 +0000, Neal Liu wrote:
> I'm confused. Signaling Wakeup when wakeup_en is set if it has any ep
> activities is not exactly what you said?
> 
> wakeup_en is set only if host allows this device have wakeup
> capability and bus being suspended.
> 
> Normal ep activities would not write the MMIO because wakeup_en is
> not set.

Hrm... I didn't think wakeup_en was limited to the bus being suspended,
but maybe I misremember, it's been a while.

Cheers,
Ben.


