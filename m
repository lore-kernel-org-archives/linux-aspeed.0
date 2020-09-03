From: Tony Lindgren <tony@atomide.com>
Date: Thu, 3 Sep 2020 11:31:29 +0300
Subject: [PATCH 3/6] ARM: dts: am335x: lxm: Fix PCA9539 GPIO expander
 properties
In-Reply-To: <20200829094024.31842-3-krzk@kernel.org>
References: <20200829094024.31842-1-krzk@kernel.org>
 <20200829094024.31842-3-krzk@kernel.org>
Message-ID: <20200903083129.GA2782@atomide.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

* Krzysztof Kozlowski <krzk@kernel.org> [200829 09:40]:
> The PCA9539 GPIO expander requires GPIO controller properties to operate
> properly.

Best to merge this with the rest of the series:

Acked-by: Tony Lindgren <tony@atomide.com>
