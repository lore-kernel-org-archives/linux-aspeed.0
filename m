From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 20 Jun 2024 09:15:22 +0200
Subject: [PATCH v2 2/2] dt-bindings: pinctrl: aspeed,ast2600-pinctrl: add
 NCSI group
In-Reply-To: <20240620012512.3109518-3-potin.lai.pt@gmail.com>
References: <20240620012512.3109518-1-potin.lai.pt@gmail.com>
 <20240620012512.3109518-3-potin.lai.pt@gmail.com>
Message-ID: <21320239-2991-4ec8-97a9-f1e6da249685@linaro.org>
List-Id: <linux-aspeed.lists.ozlabs.org>
To: linux-aspeed@lists.ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

On 20/06/2024 03:25, Potin Lai wrote:
> In the NCSI pin table, the reference clock output pin (RMIIXRCLKO) is not
> needed on the management controller side.
> 
> Add NCSI group to distinguish the pin group between RMII and NCSI.

Bindings go before users.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


---

<form letter>
This is an automated instruction, just in case, because many review tags
are being ignored. If you know the process, you can skip it (please do
not feel offended by me posting it here - no bad intentions intended).
If you do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tag is "received", when
provided in a message replied to you on the mailing list. Tools like b4
can help here. However, there's no need to repost patches *only* to add
the tags. The upstream maintainer will do that for tags received on the
version they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577
</form letter>

Best regards,
Krzysztof

