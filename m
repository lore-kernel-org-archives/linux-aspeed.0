From: Rob Herring <robh@kernel.org>
Date: Fri, 22 Sep 2023 17:51:11 -0500
Subject: [PATCH 1/2] dt-bindings: watchdog: aspeed-wdt: Add
 aspeed,reset-mask property
In-Reply-To: <20230922104231.1434-5-zev@bewilderbeest.net>
References: <20230922104231.1434-4-zev@bewilderbeest.net>
 <20230922104231.1434-5-zev@bewilderbeest.net>
Message-ID: <169542307112.4075948.15645605897080315437.robh@kernel.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit


On Fri, 22 Sep 2023 03:42:33 -0700, Zev Weiss wrote:
> This property configures the Aspeed watchdog timer's reset mask, which
> controls which peripherals are reset when the watchdog timer expires.
> Some platforms require that certain devices be left untouched across a
> reboot; aspeed,reset-mask can now be used to express such constraints.
> 
> Signed-off-by: Zev Weiss <zev@bewilderbeest.net>
> ---
>  .../bindings/watchdog/aspeed-wdt.txt          | 18 +++-
>  include/dt-bindings/watchdog/aspeed-wdt.h     | 92 +++++++++++++++++++
>  2 files changed, 109 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/watchdog/aspeed-wdt.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>

