From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 10 Sep 2020 20:01:35 +0200
Subject: [PATCH v2 08/15] ARM: dts: am335x: lxm: fix PCA9539 GPIO
 expander properties
In-Reply-To: <20200910175733.11046-9-krzk@kernel.org>
References: <20200910175733.11046-1-krzk@kernel.org>
 <20200910175733.11046-9-krzk@kernel.org>
Message-ID: <20200910180135.GA11154@kozik-lap>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On Thu, Sep 10, 2020 at 07:57:26PM +0200, Krzysztof Kozlowski wrote:
> The PCA9539 GPIO expander requires GPIO controller properties to operate
> properly.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

I forgot to add here Ack from v1:
Acked-by: Tony Lindgren <tony@atomide.com>

Tony,

I think it should go through sub-architecture maintainers, not as entire
series.

Best regards,
Krzysztof

