From: Andrew Jeffery <andrew@aj.id.au>
Date: Fri, 16 Oct 2020 15:05:11 +1030
Subject: [PATCH 0/2] ARM: dts: Enable ramoops for Rainier and Tacoma
Message-ID: <20201016043513.119841-1-andrew@aj.id.au>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

We're looking to improve our crash data capture for the BMC on some IBM
platforms. This small series enables ramoops for Rainier and Tacoma.

Please review.

Andrew

Andrew Jeffery (2):
  ARM: dts: rainier: Add reserved memory for ramoops
  ARM: dts: tacoma: Add reserved memory for ramoops

 arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 9 +++++++++
 arch/arm/boot/dts/aspeed-bmc-opp-tacoma.dts  | 9 +++++++++
 2 files changed, 18 insertions(+)

-- 
2.25.1

