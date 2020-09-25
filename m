From: Tony Lindgren <tony@atomide.com>
Date: Fri, 25 Sep 2020 14:37:56 +0300
Subject: [PATCH v3 09/15] ARM: dts: am335x: t335: align GPIO hog names
 with dtschema
In-Reply-To: <20200916155715.21009-10-krzk@kernel.org>
References: <20200916155715.21009-1-krzk@kernel.org>
 <20200916155715.21009-10-krzk@kernel.org>
Message-ID: <20200925113756.GK9471@atomide.com>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

* Krzysztof Kozlowski <krzk@kernel.org> [200916 18:58]:
> The convention for node names is to use hyphens, not underscores.
> dtschema for pca95xx expects GPIO hogs to end with 'hog' prefix.

I'm picking up this too into omap-for-v5.10/dt thanks.

Tony
